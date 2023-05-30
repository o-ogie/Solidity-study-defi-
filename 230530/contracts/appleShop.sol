// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract AppleShop {
    mapping(address=>uint256) myApple;

    function buy() public payable{
        myApple[msg.sender] += 1; // uint256 초기값 0
    }

    function get() public view returns(uint256){
        return  myApple[msg.sender];
    }

    function sell() public payable {
        uint256 refund = myApple[msg.sender] * 10 ** 18;
        myApple[msg.sender] = 0;
        payable(msg.sender).transfer(refund); // return : Account객체 => codehash, storage, balance, nonce
    }

    /*
    const tx = {
        from:'0x000',
        to:CA,
        data:"",
        value:"1000000000000000000" 1eth
    }
    이더리움은 value 값을 넘길 수 없게 만들어 놨지만 value값을 넘겨야할 경우에는 payable 속성을 달아줘야한다.
     */

}