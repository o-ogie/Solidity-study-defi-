// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Father {
    uint256 public fatherMoney = 100;

    function getFatherName() public pure returns(string memory){
        return "LeeSang";
    }

    function getMoney() public view virtual returns(uint256){
        return fatherMoney;
    }
}

contract Mother{
    uint256 public motherMoney = 500;

    function getMotherName() public pure returns(string memory){
        return "KimHyun";
    }

    function getMoney() public view virtual returns(uint256){
        return motherMoney;
    }
}


contract son is Father, Mother{

    function getMoney() public view override(Father, Mother) returns(uint256){
        return fatherMoney + motherMoney;
    }

}
/*
    contract son is Father, Mother{

    }
    이상태로 컴파일을 진행하면 오류가 발생한다.
    >> Derived contract must override function "getMoney". Two or more base classes define function with same name and parameter types.

    위 son 코드처럼 getMoney의 함수를 오버라이딩을 해줘야한다.
*/

