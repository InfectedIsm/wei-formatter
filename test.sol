// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/console.sol";

contract MyContract {
    function testLogEth() public {
        console.log("value: %s", toEthString(123154651654 ether, 18, 5));
        console.log("value: %s", toEthString(0.00465 ether, 18, 5));
        console.log("value: %s", toEthString(152456784230158, 18, 5));
        console.log("value: %s", toEthString(1_123_456.789 ether, 6, 5));
    }

    function toEthString(uint256 valueInWei, uint256 tokenDecimals, uint256 decimalPrecision)
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
        string memory integralPart = substring(valueStr, 0, bytes(valueStr).length - tokenDecimals);
        string memory fractionalPart =
            substring(valueStr, bytes(valueStr).length - tokenDecimals, bytes(valueStr).length - decimalPrecision);
        fractionalPart = adjustFractionalPart(fractionalPart, decimalPrecision);

        // Print the value
        if (bytes(integralPart).length == 0) {
            integralPart = "0";
        }
        return string(abi.encodePacked(integralPart, ".", fractionalPart));
    }

    function adjustFractionalPart(string memory fractionalPart, uint256 decimalPrecision)
        internal
        pure
        returns (string memory)
    {
        // Adjust the length of the fractional part based on the desired precision
        if (bytes(fractionalPart).length > decimalPrecision) {
            fractionalPart = substring(fractionalPart, 0, decimalPrecision);
        } else {
            while (bytes(fractionalPart).length < decimalPrecision) {
                fractionalPart = string(abi.encodePacked(fractionalPart, "0"));
            }
        }
        return fractionalPart;
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
        return string.concat(toString2(integerToPrint), ".", toString2(decimalsToPrint));
    }
}
