## Wei Formatter

Simple library to format wei values to humanly readeable string values, great for logs:

```text
Running 1 test for test/WeiFormatterLib.t.sol:testLogTokens
[PASS] testLogTokens() (gas: 125433)
Logs:

  raw value: 3676833871223741709049641512 //DAI 18 decimals
  --toTokenDecimalStr--
  fmt value: 3,676,833,871.223741709049641512 DAI
  fmt value: 3,676,833,871.22374 DAI
  --toScientificStr--
  fmt value: 3.676833871223741709049641512 e27 DAI
  fmt value: 3.67683 e27 DAI

  raw value: 22297844161394365 //USDC 6 decimals
  --toTokenDecimalStr--
  fmt value: 22,297,844,161.394365 USDC
  fmt value: 22,297,844,161.39 USDC
  --toScientificStr--
  fmt value: 2.2297844161394365 e16 DAI
  fmt value: 2.22978 e16 DAI
```

## Documentation

#### toEthString
You can configure token decimals (`IERC20.decimals()`) and desired precision for the fractional part
```solidity
function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals, uint256 precision)
function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals)
```

#### toScientificStr

```solidity
function toScientificStr(uint256 valueInWei, uint256 precision) public pure returns (string memory)
function toScientificStr(uint256 valueInWei) public pure returns (string memory)
```

## Usage

```solidity
import "../src/lib/ToEthString.sol";
import "../lib/forge-std/src/console.sol"; //could be another one

contract MyContract {	

    using WeiFormatterLib for uint256;
	//...

	function foo() public {
		IERC20 token;
		uint256 value;
		uint256 precision;

		console.log(value.toTokenDecimalStr(value, token.decimals(), precision));
		console.log(value.toScientificStr(value, precision));
	}
}

```

### Build
