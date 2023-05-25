// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint256 value;

    constructor() public {}

    function getValue() public view returns(uint256){
        return value;
    }

    function setValue(uint256 _value)public {
        value = _value;
    }

    function increment() public {
        value += 1;
    }

    function decrement() public {
        value -= 1;
    }
}