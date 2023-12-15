## Wei Formatter

Simple library to format wei values to humanly readeable string values, great for logs:

```text

raw value (DAI): 3647185179987473289582102320
------------------------------------------------
  --toTokenDecimalStr--
  3,647,185,179.987473289582102320 DAI
  3,647,185,179.98747 DAI

--toScientificStr--
  3.647185179987473289582102320_e27 DAI
  3.64718_e27 DAI

--Others--
  3,647,185,179,987,473,289,582,102,320 DAI
  3,647,185,179,987,473,289,582,102,320 (28) DAI
  3647185179987473289582102320 (28) DAI

raw value (USDC): 22172038791635991
------------------------------------------------
  --toTokenDecimalStr--
  22,172,038,791.635991 USDC
  22,172,038,791.63 USDC

--toScientificStr--
  2.2172038791635991_e16 USDC
  2.21720_e16 USDC

--Others--
  22,172,038,791,635,991 USDC
  22,172,038,791,635,991 (17) USDC
  22172038791635991 (17) USDC

```
## Usage

```solidity
import "../src/WeiFormatterLib.sol";
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
		console.log(value.addDelimiter());
		console.log(value.addDelimiterAndCount());
		console.log(value.addCount());
	}
}

```

## Documentation

#### toTokenDecimalStr
You can configure token decimals (`IERC20.decimals()`) and desired precision for the fractional part
```solidity
function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals, uint256 precision)  public pure returns (string memory)
function toTokenDecimalStr(uint256 valueInWei, uint256 tokenDecimals)  external pure returns (string memory)
```

#### toScientificStr
```solidity
function toScientificStr(uint256 valueInWei, uint256 precision) public pure returns (string memory)
function toScientificStr(uint256 valueInWei) external pure returns (string memory)
```

#### addDelimiter
```solidity
function addCommaDelimiter(uint256 value) external pure returns (string memory)
```
#### addDelimiterAndCount
```solidity
function addDelimiterAndCount(uint256 value) external pure returns (string memory)
```
#### addCount
```solidity
function addCount(uint256 value) external pure returns (string memory)
```
