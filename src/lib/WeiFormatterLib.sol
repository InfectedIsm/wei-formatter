// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library WeiFormatterLib {
    function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals, uint256 precision)
        public
        pure
        returns (string memory)
    {
        string memory valueStr = toString(valueInWei);

        while (bytes(valueStr).length < tokenDecimals) {
            valueStr = string(abi.encodePacked("0", valueStr));
        }

        string memory integerPart = substring(valueStr, 0, bytes(valueStr).length - tokenDecimals);
        string memory fractionalPart = substring(valueStr, bytes(valueStr).length - tokenDecimals, bytes(valueStr).length);

        if (bytes(integerPart).length == 0) {
            integerPart = "0";
        }

        integerPart = addCommaDelimiter(integerPart);
        fractionalPart = applyPrecision(fractionalPart, precision);

        return string(abi.encodePacked(integerPart, ".", fractionalPart));
    }

    function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals) public pure returns (string memory) {
        return toTokenDecimalStr(valueInWei, tokenDecimals, tokenDecimals);
    }

    function toScientificStr(uint256 valueInWei, uint256 precision) public pure returns (string memory) {
        if (valueInWei == 0) return "0 e0";

        uint256 digits = digitsCount(valueInWei);

        uint256 exponent = uint256(digits) - 1;
        string memory baseStr = toString(valueInWei / (10 ** exponent));

        string memory fractionStr;
        if (precision > 0) {
            uint256 fractionalPart = (valueInWei % 10 ** exponent) * 10 ** precision / (10 ** exponent);
            fractionStr = string(abi.encodePacked(".", toString(fractionalPart)));
        }

        return string(abi.encodePacked(baseStr, fractionStr, " e", toString(uint256(exponent))));
    }

    function toScientificStr(uint256 valueInWei) public pure returns (string memory) {
        if (valueInWei == 0) return "0 e0";
		uint256 digits = digitsCount(valueInWei);

        return toScientificStr(valueInWei, digits - 1);
    }

    function applyPrecision(string memory fractionalPart, uint256 precision)
        internal
        pure
        returns (string memory)
    {
        if (bytes(fractionalPart).length > precision) {
            fractionalPart = substring(fractionalPart, 0, precision);
        } else {
            while (bytes(fractionalPart).length < precision) {
                fractionalPart = string(abi.encodePacked(fractionalPart, "0"));
            }
        }
        return fractionalPart;
    }

    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }

        uint256 digits = digitsCount(value);

        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function digitsCount(uint256 value) internal pure returns (uint256) {
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        return digits;
    }

    function substring(string memory str, uint256 startIndex, uint256 endIndex) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    function addCommaDelimiter(string memory integerPart) public pure returns (string memory) {
        uint256 digits = bytes(integerPart).length;
        if (digits <= 3) {
            return integerPart;
        }
        uint256 underscores = (digits - 1) / 3;
        bytes memory buffer = new bytes(digits + underscores);
        uint256 bufferIndex = 0;
        for (uint256 i = 0; i < digits; i++) {
            // Insert comma before every 3rd digit from the right, except at the start
            if (i != 0 && (digits - i) % 3 == 0) {
                buffer[bufferIndex++] = ",";
            }
            buffer[bufferIndex++] = bytes(integerPart)[i];
        }

        return string(buffer);
    }

    function toStringWithDecimals(uint256 _number, uint8 decimals) internal pure returns (string memory) {
        uint256 integerToPrint = _number / (10 ** decimals);
        uint256 decimalsToPrint = _number - (_number / (10 ** decimals)) * (10 ** decimals);
        return string.concat(toString(integerToPrint), ".", toString(decimalsToPrint));
    }
}