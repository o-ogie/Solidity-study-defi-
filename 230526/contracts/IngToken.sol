// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract IngToken {

    mapping(address=>uint256) public balances;

    string public name = '';
    string public symbol = 'ITK';
    // symbol : ex) BTC, ETH ...
    uint8 public decimals = 18;
    uint256 public totalSupply = 1000 * 10 ** decimals; // 총 발행량

    constructor(){
        balances[msg.sender] = totalSupply; 
    }

    function balanceOf(address _account) public view returns(uint256 balance){
        return balances[_account];
    }

    function transfer(address _to, uint256 _value) public returns(bool){
        require(balances[msg.sender] >= _value);

        balances[msg.sender] -= _value;
        balances[_to] += _value;
        return true;
    }
}