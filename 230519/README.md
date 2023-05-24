이더리움과 비트코인이 다른 이유 탈중앙화 된 어플리케이션을 만들 때 이더리움의 힘이 발휘 된다. 이더리움이 발전되면서 블록체인 생태계가 많이 변했다.

블록체인 1.0, 2.0, 3.0 버전으로 크게 나뉜다.

1.0은 자산의 이동에 초점이 맞춰져있다. 비트코인 캐쉬, 라이트, 골드, 리플, ...
2.0이 되면서 이더리움이 시작되었다. private 블록체인이 시작되었다. 예를 들면 클레이튼...
프라이빗은 노드의 개수를 현저히 줄여서 보안성을 높임 (코다?, 하이퍼랫져 프로젝트)
프라이빗 블록체인 네트워크가 중앙화에 가깝다라고 하여, 블록체인이라고 할 수 없다는 의견이 많다.
트랜잭션 내용에 검증된 중개자가 있다. (은행과 비슷하다. 하지만 중개자가 기관이나 중앙화된 곳이 아닌 검증된 중개자 )
코드가 들어오면 실행해준다.???
3.0이 되면서 layer2 에 대한 개념이 생겼다. 사이드 체인이라는 느낌이다. 블록체인 고질병인 속도를 개선하고, 블록체인을 넘어 자산을 관리하고 싶
피어들끼리 연결을 해서 통신하는 것이 아닌 layer2시스템에 요청응답을 해서 값을 얻어서 네트워크에 추가한다.
폴리곤은 이더리움관련 layer2이다.
L2가 프라이빗에 가깝다 (노드가 적다..)
public, private가 공존하는 것이 좋다.
이더리움의 가장 큰 붐 ICO, NFT, DeFi 모두 이더리움의 스마트컨트랙트를 기반으로 파생되었다. 스마트 컨트랙트도 결국은 트랜잭션이다. 이 배경을 알기위해서 비트코인을 공부했었고, 요즘 블록체인의 대부분이 이더리움으로 되어있기 때문에, 이더리움을 잘 배워야한다.

이더리움 개발

블록
account
message or transaction
fee(Gas)
ETH 단위
...
이더리움 개발을 위한 툴

Geth : go-ethereum ( golang으로 개발한 것. ) - chainId를 알기위해서

메인넷이냐 테스트넷이냐에 따라서 chainId가 다르다.
나만사용하고 싶을 때, chainId를 수정해서 사용할 수 있다.
chainId가 다르면 연결하지 않는다.
Ganache : 나혼자 로컬에서 작업할 때, 굳이 네트워크에 연결되어있을 필요가 없기 때문에, 경량화된 ganache를 이용해서 개발을 진행하고 테스트넷에서 테스트 한 후에 메인넷으로 올린다.

ganache -> testnet -> mainnet
mainnet에 한번 올리면 수정을 할 수 없기 때문에 테스트를 진행하고 올리는 것이 좋다.
모두 같은 코드로 돌아간다.
web3, ethers : 블록체인 노드들한테 요청할 내용에 대해서 정리해놓은 라이브러리 : 쉽게 노드들에게 요청 할 수 있도록 도와주는 것.

web3 : 이더리움제단에서 직접 만든 라이브러리,
ethers : 사설에서 만듬 하지만 역할은 같다.
기능은 ethers가 좋을지언정 근본은 이더리움에서 직접 만든 web3가 낫다고 생각한다.
truffle. hardhat : 스마트컨트랙트를 쉽게 사용할 수 있도록 도와주는 프레임워크

remix : 에디터 remix (next.js의 remix 아님)
솔리디티 문법공부

솔리디티 깨부수기 라고 유튜브에 검색해서 정독..
크립토 좀비
Ganache

나의 local PC에서 ethereum을 실행시키는 아주 작은 프로그램

설치방법, 실행방법은 NodeJS에서도 가능하다. CLI 형태, GUI 형태가 있다.

$ npm install -g ganache-cli
$ ganache-cli

$ npx ganache-cli

# window
$ npx ganache-cli -h 0.0.0.0
rpc

POST 127.0.0.1:8545

{
    "jsonrpc": "2.0",
    "method": "web3_clientVersion",
    "params": []
}
curl -X POST -d '{"jsonrpc": "2.0","method": "web3_clientVersion","params": []}' http://127.0.0.1:8545

curl : 셀로 요청 보내는 것이다.

가나쉬로 연습하는 요청이지만 이더리움에 실제로 요청하는 것과 같은 형태이다.

jsonrpc api

https://ethereum.org/ko/developers/docs/apis/json-rpc/
100eth 1eth는 wei 단위로 10**18 이다.

getBalance로 계정에 든 값을 요청하면

{
    "jsonrpc": "2.0",
    "result": "0x56bc75e2d63100000"
}
을 응답받는다ㅏ.

0x56bc75e2d63100000 을 10진수로 변환하면 100000000000000000000로 변환되고 이는 100*(10**18)이다.

노드들이 가지고 있는 정보를 가져오기 위해서 요청을 보내야하고 그렇기 때문에 rpc 통신이 필수적이다.

{
    "from": "0x68ff7899d99D607C1e323a8a341ceEAb42395Ded",
    "to": "0xd521B59D3E38a35a0e38Df1c6ad658736eC29392",
    "value": "1000000000000000000"
}
EOA, CA

위에서 거래한 내용은 EOA 형태의 계정이다. 컨트렉트 계정이 아니다.

요청을 할 수 있는 공간이라면 어디서든 블록체인에 대한 정보를 가지고 있을 수 있다. backend->blockchain으로 요청할 수 있다.

rpc 통신 메서드를 많이 아는 것은 좋지만 그 메서드가 블록에 어떤 역할을 하는지 알아야한다.

web3.js

간단하게 확인하기위해서 html에 cdn으로 추가해서 확인해본다.

<script src="https://cdn.jsdelivr.net/npm/web3@1.10.0/dist/web3.min.js"></script>
console.log(Web3)
// 어디 네트워크로 보낼 건지 설정한다.
// axios.create()같은 역할...
const web3 = new Web3("http://127.0.0.1:8545")
console.log(web3)

web3.eth.getAccounts().then(console.log) // 일반 rpc 통신으로 요청해서 응답을 받은 내용 중 result만 꺼내서 준다.
Smart contract

Account

nonce
balacne
codeHash
로컬에서 이더리움네트워크에 요청을 한다. (message로 요청을 한다.) 요청한 메세지를 이용해서 account 를 만들어서 준다. 이게 CA이다. 컨트렉트 배포 : 컨트렉트 배포 프로세스

solidity 작성
solidity compile
message data라는 속성에 compile 된 내용을 보낸다. (sendTransaction.. data:"code..compile..")
코드작성하기

counter

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter{
    uint256 value;

    constructor(){}

    function setValue(uint256 _value) public {
        value = _value;
    }

    function getValue() public view returns(uint256) {
        // 상태변수를 변화시키지 않고 바로 출력하기 위해서 view를 쓴다.
        return value;
    }

}
컴파일하기

$ npx solc --bin --abi ./counter.sol
배포하기

CA -> Message 너가 가지고 있는데 value가 몇이니?

CA 생성까지가 컨트렉트 배포 나중에 CA에 요청해서 가지고 있는 value를 확인하는 것이 call

이더리움 네트워크에 보내주는 것 까지가 오늘 수업.