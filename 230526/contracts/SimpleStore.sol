// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract SimpleStore {
    uint256 public value;
    address public owner;   

    constructor(uint256 _value){
        value = _value;
        //msg.sender 트랜잭션을 실행한 사람의 Account값이 있음.
        owner = msg.sender;
    }

}