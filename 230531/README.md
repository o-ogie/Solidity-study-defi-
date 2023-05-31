# NFT (Non-Fungible-Token)
유일한 토큰이다. 라는 뜻.
중앙화에 저장할 수도 있고 Contract에 저장할 수도 있음.

1. 왜 유일한가?
NFT는 객체입니다. {} === {} flase

2. 어떻게 이미지가 보이는가?
이미지 자체를 블록체인 네트워크에 넣게되면.. 용량이 많다.
NFT에는 어떠한 것들도 넣을 수 있다고 하는데,
이유 -> NFT에 URL을 저장한다.

BlockChain네트워크에는 파일이나, 파일데이터를 저장하지 않는다.
다른 서버하나를 운용해서 파일들을 넣어두고 URL요청으로 데이터를 가져온다.

Contract에 URL을 저장하고, URL을 요청해서 데이터를 가져온다.
-> 유일한 이유. 객체이며 부여되는 key값이 유일함.

파일서버가 날라가면 이미지를 불러 올 수 없지 않나?
블록체인이지만 중앙화이지 않나?

IPFS(InterPlanetary File System)로 해결.
-> 분산형 파일 시스템에 데이터를 저장하고 인터넷으로 공유하기 위한 프로토콜.
토렌트처럼 p2p방식으로 대용량 파일과 데이터를 공유하기 위해서 사용함.

CA에서 URL에 JSON 객체를 저장한다. 
{
    "id":"1",
    "url":"http://.../*.json",
}

위 url에 들어가면 아래와 같은 메타데이터가 들어있다.
{
    name:...,
    description:...,
    image:...,
    attribute:[...],
    ...
}

## 토큰 발행
ERC20에 대해서 간단하게 발행했음. testNet에다가.

ERC20 라이브러리 사용해서 발행해볼것이다. 
`OpenZeppelin`이란?
스마트 컨트랙트가 다 되어있는 라이브러리. 납득하여 사용만 하면 된다.
solidity코드가 모여잇는 집합체.

```sh
npm init -y
npm install openzeppelin-solidity
```


import, is, interface
`import` 상속하기 위해서 사용한다. (대부분)
`상속` 다중상속이 가능하다.
`interface` 

import "path";
path에는 상대경로든 전부다 적어준다.

**상속**
```js
contract IngToken is ERC20 {
    contructor() ERC20("ingToken","ITK") {
        _mint(msg.sender, 1000 * (10**18));
    }
}
```
상속받는 객체의 생성자 함수를 실행하기 위해서는
자바스크립트에선 super()를 실행했지만
soliditi에서는 ERC20() 상속객체이름를 실행해주면 된다.

_mint(address account, uint256 amount) 함수
토큰 발행하는 함수이다.


transferFrom
approve
allowance

3개가 묶음이나 다름없다.
사용 목적은 마켓때문에 사용한다.

ex) ERC20을 대행으로 판매
NFT를 대행으로 판매.
ex) opensea

approve는 위임장 역할을 한다. 마켓에 위임함.
allowance 위임 받은 수량 데이터













Available Accounts
==================
(0) 0xC4A67D22fB47D79D5207faE2Db9dfF340A29975F (100 ETH)
(1) 0x4209d5FB5609E4Fc86d022F00c42dAE51C141914 (100 ETH)
(2) 0xc2feb89141789b0BAc482c3Da35E3A1099Ab3271 (100 ETH)
(3) 0xA4e9A5D82E802b0F68A00aCf4b6F340583e88b89 (100 ETH)
(4) 0x1951C5Dc7a81B0a1016b664226c51DB0F0EF1432 (100 ETH)
(5) 0x49b7cbe6AF927611e85AE2FAaC55b090fDB45E10 (100 ETH)
(6) 0x15661c23CdF42177d9b21beAaF4FB2776d2B75aB (100 ETH)
(7) 0xCc6Dc95c97B10Ab6e89802Fd53298d62Cf043b11 (100 ETH)
(8) 0x9c8bECf8c7FFe998D1411872d8CF63DE17d7340E (100 ETH)
(9) 0x7cCcFA00bE5F1E1507efE3fC32763ca3B6Dd38C0 (100 ETH)

Private Keys
==================
(0) 0xb66d74da0731ec6b26783e8296e847c978a2d3f491169e87c1a8929ab9ee9b10
(1) 0xe5882110cdb34e61c11899080e2d7cca9918bda4f93098a505dae7df2e89fedb
(2) 0x3ceee34fb88a7e3c6c8d0778302234a2e8018593a842e903c0212a883dee5267
(3) 0x56e55fdb5ce95985253ff42929688ae4136e8ff4c36c18aab621ea017e81c240
(4) 0x3209f829d11b80a4288b6ed39740a718b6eb2f8fd812ec91d296eef80b298527
(5) 0xbd853cd651b7fad00fc2344568eb8f5d2793dba0894bd54b331e4b7092ed7c78
(6) 0xc003628884423dcddf379436aed2578d16bda08f27d12c04e4f432cea8af006d
(7) 0xf0f0337d7e83d20b1c99518c3be3e104449b6dab403a55e119795a56951c1531
(8) 0x86899dbc48b306704cf284f70b6208e2f54238a0a34b6986beea9264e2c5a9af
(9) 0x527b6ed50df9fd80ee341d8c38e030c72af375c5732db03b256289f170a426a4

