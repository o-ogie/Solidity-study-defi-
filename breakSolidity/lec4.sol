// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract lec4 {

    uint256 public a = 3;

    // 1. Parameter 와 return이 없는 경우
    function changeA1() public{
        a = 5;
    }
    // 2. Parameter는 있고 return이 없는 경우
    function changeA2(uint256 _value) public {
        a = _value;
    }

    // 3. Parameter는 없고 return이 있는 경우
    function changeA3() public view returns(uint256) {
        return a;
    }
 
    // 4. Parameter 와 return이 있는 경우
    function changeA4(uint256 _value) public returns(uint256) {
        a = _value;
        return a;
    }
}
