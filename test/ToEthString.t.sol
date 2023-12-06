// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/console.sol";

import {IERC20} from "../src/interfaces/IERC20.sol";

import "../src/lib/ToEthString.sol";

contract TestToEth is Test {
    IERC20 DAI = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    IERC20 USDC = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);

    function setUp() public {
        vm.createSelectFork("mainnet");
    }

    function testLogEth() public {
        uint256 daiTotalSupply = DAI.totalSupply();
        uint256 usdcTotalSupply = USDC.totalSupply();

        console.log("raw value: %d", daiTotalSupply);
        console.log("fmt value: %s", ToEthStringLib.toEthString(daiTotalSupply, DAI.decimals(), 5));
        console.log("raw value: %s", ToEthStringLib.toEthString(usdcTotalSupply, USDC.decimals(), 7));
        console.log("fmt value: %d", usdcTotalSupply);
    }
}
