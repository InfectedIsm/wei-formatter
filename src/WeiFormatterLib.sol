// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library WeiFormatterLib {

    function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals, uint256 precision)
        public
        pure
        returns (string memory)
    {
        string memory valueStr = _toString(valueInWei);

        while (bytes(valueStr).length < tokenDecimals) {
            valueStr = string(abi.encodePacked("0", valueStr));
        }

        string memory integerPart = _substring(valueStr, 0, bytes(valueStr).length - tokenDecimals);
        string memory fractionalPart =
            _substring(valueStr, bytes(valueStr).length - tokenDecimals, bytes(valueStr).length);

        if (bytes(integerPart).length == 0) {
            integerPart = "0";
        }

        integerPart = _addDelimiter(integerPart);
        fractionalPart = _applyPrecision(fractionalPart, precision);

        return string(abi.encodePacked(integerPart, ".", fractionalPart));
    }

    function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals) external pure returns (string memory) {
        return toTokenDecimalStr(valueInWei, tokenDecimals, tokenDecimals);
    }

    function toScientificStr(uint256 valueInWei, uint256 precision) public pure returns (string memory) {
        if (valueInWei == 0) return "0_e0";

        uint256 digits = _digitsCount(valueInWei);

        uint256 exponent = uint256(digits) - 1;
        string memory baseStr = _toString(valueInWei / (10 ** exponent));

        string memory fractionStr;
        if (precision > 0) {
            uint256 fractionalPart = (valueInWei % 10 ** exponent) * 10 ** precision / (10 ** exponent);
            fractionStr = string(abi.encodePacked(".", _toString(fractionalPart)));
        }

        return string(abi.encodePacked(baseStr, fractionStr, "_e", _toString(uint256(exponent))));
    }

    function toScientificStr(uint256 valueInWei) external pure returns (string memory) {
        if (valueInWei == 0) return "0 e0";
        uint256 digits = _digitsCount(valueInWei);

        return toScientificStr(valueInWei, digits - 1);
    }

    function addCount(uint256 value) external pure returns (string memory) {
		uint digits = _digitsCount(value);
        string memory integerPart = _toString(value);
        return string(abi.encodePacked(integerPart, " (", _toString(uint256(digits)), ")"));
    }

    function addDelimiter(uint256 value) external pure returns (string memory) {
        string memory integerPart = _toString(value);
        return _addDelimiter(integerPart);
    }

    function addDelimiterAndCount(uint256 value) external pure returns (string memory) {
		uint digits = _digitsCount(value);
        string memory integerPart = _toString(value);
		integerPart = _addDelimiter(integerPart);
        return string(abi.encodePacked(integerPart, " (", _toString(uint256(digits)), ")"));
    }

    function _applyPrecision(string memory fractionalPart, uint256 precision) internal pure returns (string memory) {
        if (bytes(fractionalPart).length > precision) {
            fractionalPart = _substring(fractionalPart, 0, precision);
        } else {
            while (bytes(fractionalPart).length < precision) {
                fractionalPart = string(abi.encodePacked(fractionalPart, "0"));
            }
        }
        return fractionalPart;
    }

    function _toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }

        uint256 digits = _digitsCount(value);

        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function _digitsCount(uint256 value) internal pure returns (uint256) {
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        return digits;
    }

    function _substring(string memory str, uint256 startIndex, uint256 endIndex)
        internal
        pure
        returns (string memory)
    {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    function _addDelimiter(string memory integerPart) internal pure returns (string memory) {
        uint256 digits = bytes(integerPart).length;
        if (digits <= 3) {
            return integerPart;
        }
        uint256 underscores = (digits - 1) / 3;
        bytes memory buffer = new bytes(digits + underscores);
        uint256 bufferIndex = 0;
        for (uint256 i = 0; i < digits; i++) {
            if (i != 0 && (digits - i) % 3 == 0) {
                buffer[bufferIndex++] = ",";
            }
            buffer[bufferIndex++] = bytes(integerPart)[i];
        }

        return string(buffer);
    }

    function _toStringWithDecimals(uint256 _number, uint8 decimals) internal pure returns (string memory) {
        uint256 integerToPrint = _number / (10 ** decimals);
        uint256 decimalsToPrint = _number - (_number / (10 ** decimals)) * (10 ** decimals);
        return string.concat(_toString(integerToPrint), ".", _toString(decimalsToPrint));
    }
}
