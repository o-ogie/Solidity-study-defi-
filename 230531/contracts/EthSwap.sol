//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0 ;
import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract EthSwap {
    //_token :IngToken을 배포한 CA값
    // ERC20은 하나의 클래스역할을 하기 때문에 하나의 타입으로 사용한다.
    ERC20 public token;
    uint256 public rate = 100; //반감기의 형태로 구현할 수 있다.
    


    constructor(ERC20 _token){ //CA값
        token = _token;
    }   
    function getToken() public view returns(address){
        return address(token);
    }
    // Tx{from :"web7722", to:"EthSwap(CA)", data: getSwapBalance} ERC20 밸런스 리턴
    function getSwapBalance() public view returns (uint256){
        return token.balanceOf(msg.sender);
    }

    function getThisAddress() public view returns(address){
        //this를 하면 인스턴스의 객체를 반환 받을텐데 이는 account이다 그래서 address로 형변환을 진행한다.
        return address(this);
    }

    function getTokenOwner() public view returns(address){
        // IngToken을 배포한 사람의 EOA계정
         return token.owner2();
    } 

    // ETH -> Token : CA가 이더를 받는다. => payable 키워드가 필요하다.
    function buyToken () public payable{
        // CA에게 트랜잭션을 보낼 때 값을 얻을 수 있다.
        uint256 tokenAmount = msg.value * rate;
        require(token.balanceOf(token.owner2()) >= tokenAmount, 'Error' );
        token.transferFrom(token.owner2(), msg.sender, tokenAmount);
    }
    
    // Token -> ETH
    function sellToken(uint256 _amount) public payable {
        require(token.balanceOf(msg.sender)>= _amount , "not enough token");
        uint256 etherAmount = _amount/rate;
        require(address(this).balance >= etherAmount); // eth의 갯수
        token.transferFrom(msg.sender, token.owner2(), _amount);

        // payable(msg.sender) : to
        payable(msg.sender).transfer(etherAmount);
    }
}