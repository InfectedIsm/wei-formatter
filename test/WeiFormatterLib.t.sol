// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/console.sol";

import {IERC20} from "./interfaces/IERC20.sol";

import "../src/WeiFormatterLib.sol";

contract TestToEth is Test {
    using WeiFormatterLib for uint256;

    IERC20 DAI = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

    function setUp() public {
        vm.createSelectFork("mainnet");
    }

    function testLogTokens() public view {
        uint256 daiTotalSupply = DAI.totalSupply();
        uint256 usdcTotalSupply = USDC.totalSupply();

        console.log("\nraw value: %d", daiTotalSupply);
        console.log("--toTokenDecimalString--");
        console.log("fmt value: %s DAI", daiTotalSupply.toTokenDecimalStr(DAI.decimals()));
        console.log("fmt value: %s DAI", daiTotalSupply.toTokenDecimalStr(DAI.decimals(), 5));
        console.log("--toScientificString--");
        console.log("fmt value: %s DAI", daiTotalSupply.toScientificStr());
        console.log("fmt value: %s DAI", daiTotalSupply.toScientificStr(5));
        console.log("--addCommaDelimiter--");
        console.log("fmt value: %s DAI", daiTotalSupply.addCommaDelimiter());

        console.log("\nraw value: %d", usdcTotalSupply);
        console.log("--toTokenDecimalString--");
        console.log("fmt value: %s USDC", usdcTotalSupply.toTokenDecimalStr(USDC.decimals()));
        console.log("fmt value: %s USDC", usdcTotalSupply.toTokenDecimalStr(USDC.decimals(), 2));
        console.log("--toScientificString--");
        console.log("fmt value: %s USDC", usdcTotalSupply.toScientificStr());
        console.log("fmt value: %s USDC", usdcTotalSupply.toScientificStr(5));
        console.log("--addCommaDelimiter--");
        console.log("fmt value: %s USDC", usdcTotalSupply.addCommaDelimiter());
    }

    function testZeroValue() public view {
        uint256 zero = 0;

        console.log("\nraw value: %d", zero);
        console.log("fmt value: %s DAI", zero.toTokenDecimalStr(18));
        console.log("fmt value: %s DAI", zero.toScientificStr());
    }
}
