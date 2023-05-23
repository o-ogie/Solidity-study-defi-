pragma solidity ^8.0.0;

contranct Count{
    uint256 value;

    function getValue() public view returns(uint256){
        return value
    }

    function setValue(uint256 _value) public {
        value = _value
    }
}