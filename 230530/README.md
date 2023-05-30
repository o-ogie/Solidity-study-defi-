# 크립토 좀비, 솔리디티 깨부시기, 인프런

# payalbe
account의 4가지 속성을 다사용하는 계정 CA
balance에 값을 넣으려다가 실패하는 이유 payalbe이 되어잇는 계정에 가능하기 때문?

contract를 짜고 배포하려면
- react
- web3
- truffle
    - web3기반
- ganache
 - 트랜잭션생성하면 블럭을 바로 생성해줌
 - 가스비용이 안듬
 -> 빠르게 확인할 수 있음.

다른 네트워크에 배포를 하려면?
 ex) 폴리곤
1. 어떤 네트워크인지 알아야함. ex) 이더리움 기반..
이더리움에 가스라는 개념이 있다.
 - 이더리움은 스마트 컨트랙트가 가능한 플랫폼. DApp을 만들기 위한 플랫폼.
 - EVM, 솔리디티 언어로 만들어진 스마트 컨트랙트가 정상적인 코드인가 아닌가 판별하기 위해 가스라는 개념이 존재함.
 - 가스가 높으면 노드에 무리가 가기 때문에. 연산을 제한하는 역할을 한다.


스마트 컨트랙트를 잘 짠다 - 가스 비용을 적게 발생시키는 것.

Layer2 - 비싼 수수료를 극복하고자 나온 개념.
 코드 실행은 다른 곳에서 하고 결과 값만 보낸다면 수수료를 아낄 수 있을 것이다?

수만은 트랜잭션을 발생시키는데 처리 방법?0934



**truffle세팅**
```sh
npx truffle init
```

**react세팅**
``sh
npm init -y
npx create-react-app front

**ganache**
Available Accounts
==================
(0) 0xe43363f30746B594F007F237B2F4abDDcF4e826C (100 ETH)
(1) 0xEAE2F2C11dBEa2d1E8f30E92687C3C33F22BfF50 (100 ETH)
(2) 0x4Fe7966487fa22Cf24D09D5B164838C97937686c (100 ETH)
(3) 0x15be7Bb2b5283102d62F5Ee93AA7a891560B6734 (100 ETH)
(4) 0x00a395fc8eeF6fc9BEaFB846403396eba52B3DBC (100 ETH)
(5) 0x783aEAAa0C040559c04d09B63A2d7b6045dB24F0 (100 ETH)
(6) 0xa6378C11c85C00C74cf6FDEa51520F83bE444aD9 (100 ETH)
(7) 0x84c1243aF5B5A2d85004cD001a790f39ad8aCe53 (100 ETH)
(8) 0x1fA4Ad04C58332b558849b1A556edd2B95aBB912 (100 ETH)
(9) 0xA7772821B40c1e45ab789B55faf3F7f3d885Ab54 (100 ETH)

Private Keys
==================
(0) 0x675a29178b49052bc72604ca1244d3f5038c493f3210126c13302ff2a60b12e8
(1) 0x1449f7a52dcbc8985409af2b55dbe2cd148b9cb177a46d64b56881e709322df1
(2) 0x4513503a86681720cde83b0c55ff67a3750fa774e98920724f922228cdcf1201
(3) 0x92ff3fd2ac2ba2286606f99b390d938b1f4368899b6b0e33e3fe3e6a4d63e5ab
(4) 0x44e729b6e8a455119ede5d88d09c002309f0d3d59d5e15ed00db257904611107
(5) 0x55263bce54e167335574ec24e772160ef97f60ce6c33baa6a0346fb01b44c176
(6) 0x46d4bab2c183d60621294da4981e6d5fad4e07c9e94b4f67b70114a776ea9840
(7) 0x5d8af64bf77a32c3c2ace1d1ced692999e059f0b93fb367ec0f769b90d489ebb
(8) 0x7df5e7b5e6242f11a6857cb9276cbd52140594ffafb9e4a5356ea65ed708478e
(9) 0xd4377ca3e987c4939255bd8a9551b5d7d193c472fdf3c934f006623b3037b75f


## 과일상점
사과 : 1ETH  
환불가능(1ETH)

현재 보유하고 있는 사과를 화면에 표현

사과는 Contract Account의 Storage에
2교시


환불
ca에서 eoa에 이더를 주는 트랜잭션을 발생시켜야한다.
상태 변경에는 2가지 방법이 있음.
1. tx발생
2. message

지금까지 tx를 만들어서 생태 값을 변경해 왔는데.
환불과 같은 경우에는 트랜잭션을 또 발생시켜야 함으로 message를 활용하여 변경한다.
```sol
payable(msg.sender).transfer(1 ether or 1 * 10 ** 18);
```
transfer는 솔리디티 내장 메서드로 CA에 있는 balance를 보내는 것. => CA계정 이더를 보내는데 사용된다. 단위는 wei이다.

이더리움에서 `Account`
`0x0000`:{
    nonce:0,
    balance:0,
    storage:'',
    codeHash:''
}
// address:0x000, account0x000:{...}









# ERC20