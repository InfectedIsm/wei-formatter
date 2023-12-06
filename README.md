## Wei Formatter
Simple library to format wei values to humanly readeable string values, great for test logs:

```Lisp
Running 1 test for test/ToEthString.t.sol:TestToEth
[PASS] testLogEth() (gas: 84509)
Logs:
  raw value: 3679528730497806738513236668
  fmt value: 3679528730.49780 DAI
  raw value: 22292124848623647
  fmt value: 22292124848.6236470 USDC
```

You can configure token decimals (`IERC20.decimals()`) and desired precision for the fractional part
```solidity
function toEthString(uint256 valueInWei, uint256 tokenDecimals, uint256 decimalPrecision)
```

## Documentation

## Usage

### Build
