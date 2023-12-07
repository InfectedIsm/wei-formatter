## Wei Formatter
Simple library to format wei values to humanly readeable string values, great for test logs:

```text
Running 1 test for test/ToEthString.t.sol:TestToEth
[PASS] testLogTokens() (gas: 125433)
Logs:
  raw value: 3673470030444314849278418100
  fmt value: 3,673,470,030.44431 DAI // precision = 5
  raw value: 22237737826906447
  fmt value: 22,237,737,826.906447 USDC // precision = none
  fmt value: 22,237,737,826.90 USDC // precision = 2
```

You can configure token decimals (`IERC20.decimals()`) and desired precision for the fractional part
```solidity
function toEthString(uint256 valueInWei, uint256 tokenDecimals, uint256 precision)
function toEthString(uint256 valueInWei, uint256 tokenDecimals)
```

## Documentation

## Usage

### Build
