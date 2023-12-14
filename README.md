## Wei Formatter

Simple library to format wei values to humanly readeable string values, great for logs:

```text
Running 1 test for test/WeiFormatterLib.t.sol:testLogTokens
[PASS] testLogTokens() (gas: 125433)
Logs:

	>>raw value: 3664561361098409999959676821	//DAI 18 decimals
	>>
	------toTokenDecimalStr--------
	3,664,561,361.098409999959676821 DAI 	// precision = none
	3,664,561,361.09840 DAI  	// precision = 5
	--------toScientificStr--------
	3.664561361098409999959676821_e27 DAI  // precision = none
	3.66456_e27 DAI  // precision = 5
	-------addCommaDelimiter--------
	3,664,561,361,098,409,999,959,676,821 DAI

```

## Documentation

#### toEthString
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
		console.log(value.addCommaDelimiter());
	}
}

```

### Build
