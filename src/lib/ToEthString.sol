// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library ToEthStringLib {
    function toEthString(uint256 valueInWei, uint256 tokenDecimals, uint256 precision)
        public
        pure
        returns (string memory)
    {
        // Convert the value to a string
        string memory valueStr = toString(valueInWei);

        //make the value at least 18 decimals long
        while (bytes(valueStr).length < tokenDecimals) {
            valueStr = string(abi.encodePacked("0", valueStr));
        }

        // Insert the decimal point
        string memory integerPart = substring(valueStr, 0, bytes(valueStr).length - tokenDecimals);
        string memory fractionalPart = substring(valueStr, bytes(valueStr).length - tokenDecimals, bytes(valueStr).length);

        // Print the value
        if (bytes(integerPart).length == 0) {
            integerPart = "0";
        }
		integerPart = addCommaToInteger(integerPart);
        fractionalPart = adjustFractionalPart(fractionalPart, precision);

        return string(abi.encodePacked(integerPart, ".", fractionalPart));
    }

    function toEthString(uint256 valueInWei, uint256 tokenDecimals)
        public
        pure
        returns (string memory)
    {
        // Convert the value to a string
        string memory valueStr = toString(valueInWei);

        //make the value at least 18 decimals long
        while (bytes(valueStr).length < tokenDecimals) {
            valueStr = string(abi.encodePacked("0", valueStr));
        }

        // Insert the decimal point
        string memory integerPart = substring(valueStr, 0, bytes(valueStr).length - tokenDecimals);
        string memory fractionalPart = substring(valueStr, bytes(valueStr).length - tokenDecimals, bytes(valueStr).length);

        // Print the value
        if (bytes(integerPart).length == 0) {
            integerPart = "0";
        }
		integerPart = addCommaToInteger(integerPart);

        return string(abi.encodePacked(integerPart, ".", fractionalPart));
    }


    function adjustFractionalPart(string memory fractionalPart, uint256 precision)
        internal
        pure
        returns (string memory)
    {
        // Adjust the length of the fractional part based on the desired precision
        if (bytes(fractionalPart).length > precision) {
            fractionalPart = substring(fractionalPart, 0, precision);
        } else {
            while (bytes(fractionalPart).length < precision) {
                fractionalPart = string(abi.encodePacked(fractionalPart, "0"));
            }
        }
        return fractionalPart;
    }

    function addCommaToInteger(string memory integerPart) public pure returns (string memory) {
        uint256 digits = bytes(integerPart).length;
        if (digits <= 3) {
            return integerPart;
        }
        uint256 underscores = (digits - 1) / 3;
        bytes memory buffer = new bytes(digits + underscores);
        uint256 bufferIndex = 0;
        for (uint256 i = 0; i < digits; i++) {
            // Insert underscore before every 3rd digit from the right, except at the start
            if (i != 0 && (digits - i) % 3 == 0) {
                buffer[bufferIndex++] = ',';
            }
            buffer[bufferIndex++] = bytes(integerPart)[i];
        }

        return string(buffer);
	}

    function toString(uint256 value) internal pure returns (string memory) {
        // Convert uint to string
        if (value == 0) {
            return "0";
        }

        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }

        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }

    function substring(string memory str, uint256 startIndex, uint256 endIndex) internal pure returns (string memory) {
        bytes memory strBytes = bytes(str);
        bytes memory result = new bytes(endIndex - startIndex);
        for (uint256 i = startIndex; i < endIndex; i++) {
            result[i - startIndex] = strBytes[i];
        }
        return string(result);
    }

    function toStringWithDecimals(uint256 _number, uint8 decimals) internal pure returns (string memory) {
        uint256 integerToPrint = _number / (10 ** decimals);
        uint256 decimalsToPrint = _number - (_number / (10 ** decimals)) * (10 ** decimals);
        return string.concat(toString(integerToPrint), ".", toString(decimalsToPrint));
    }
}
