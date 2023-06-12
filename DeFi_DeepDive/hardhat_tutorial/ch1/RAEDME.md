```shell
npx hardhat
```

**hardhat project 폴더 구조**
contract 폴더
일반적인 컨트랙트 파일, 인터페이스, 라이브러리 등 솔리디티 파일들을 모아놓은 폴더

script 폴더
컨트랙트 배포나 이미 배포된 컨트랙트의 특정 함수를 실행하는 등 메인넷에 트랜잭션을 보내기위한 코드를 작성하는 폴더

test 폴더
컨트랙트 test코드를 작성하는 폴더.


**hardhat.config.ts**
프로젝트 전반적인 환경설정의 내용을 담고 있음.
이 파일을 통해 컨트랙트를 배포할 네트워크나 어떤 지갑을 사용할 것인지에 대한 정보를 설정할 수 있고
컴파일 버전 등 설정이 가능하다.

## hardhat 환경 설정
크게 2가지로 나눌 수 있다.

1. 솔리디티의 컴파일 버전설정
한 가지 이상의 컴파일 버전을 사용할 상황이 발생할 수 있다.
다른 오픈소스에 작성된 컨트랙트나, 새로운 컨트랙트를 작성할 때 옛날의 버전이 필요할 수가 있다.
```sol
pragma solidity 0.6.0;

contract OldContract {
    constructor() public{}

    function foo() external{}
}
```
이런 솔리디티 코드를 작성하면 버전 문제때문에 컴파일이 진행되지 않는다.
hardhat.config.ts파일에 환경 설정을
```json
solidity: {
    compilers:[
      {version:"0.8.0"},
      {version:"0.6.6"},
    ]
  }
```
compilers에 version을 추가해주면 다른 버전으로 컴파일이 가능하다.


2. 네트워크 버전 설정
컨트랙트를 배포하거나 테스트넷을 진행할 때, 특정 메인넷의 환경을 가지고 진행하게 되는데 이때 네트워크에 연결을 하기 위해서는 노드의 url정보를 알아야한다.

노드는 사설업체에서 지원하는 유로 노드도 있지만 public노드를 제공하기도 한다.
대표적으로
이더리움 퍼블릭노드, 바이낸스 스마트체인, 클레이튼 퍼블릭 노드 등등...
All That Node 사이트에서 확인이 가능하다.

```json
networks:{
    ethereum:{
      url:"https://ethereum-mainnet-rpc.allthatnode.com",
      accounts:""
      // accounts:{
      //   mnemonic:"test test test ...",
      // } 계정 하나만 사용할 때
      accounts:["privateKey","..."] 
    }
  }
```
accounts 설정 부분에서는 설정법을 2가지로 나눌 수 있다.
1. mnemonic 구문으로 입력
```json
account:{
    mnemonic:"test test test ..."
}
```
객체로 니모닉 구문을 입력하는 방법.
test로 진행할 경우 그냥 의미없는 구문을 넣어줘도 된다.


2. PrivateKey로 입력.
```json
account:[privateKey...]
```
계정의 PrivateKey들을 배열 형태로 입력해준다.
계정을 하나만 사용 할때는 하나만 넣으면 된다.


## fork 기능
hardhat이 지원하는 강력한 기능 중 하나.
메인넷에 있는 노드정보를 hardhat이 fork를 해와서 컴퓨터의 가상환경에 노드를 띄울 수 있따.
컨트랙트롤 배포하고 테스트넷을 진행할 때 가스비용이 발생하는데, 이러한 비용을 절감할 수 있다.

fork 설정법은
```json
networks:{
    hardhat:{
      forking:{
        url:"https://ethereum-mainnet-rpc.allthatnode.com"
      },
    //   blockNumber:777,
    accounts:{
        menemonic:"test test test test ... junk",
        accountsBalance: "1000",
    }
    },
}
```
blockNumber는 특정 블록의 번호의 블럭을 조회하고 싶을때 지정하여 확인할 수 있다.

accounts는 테스트진행할 계정, 테스트 용이기때문에 mnemonic에 아무 값이나 넣어둔다.
accountsBalance는 테스트를 진행할 때 테스트 환경에서 사용할 native Coin을 할당할 수 있다.
Coin은 fork한 메인넷의 native Coin을 따라간다.
ex) 이더 메인넷이면 이더리움.



# 컨트랙트 배포 및 테스트

컨트랙트 테스트 이유
1. 무결성 검증
 - 한번 배포된 컨트랙트를 수정 불가. 테스트를 통해 충분히 컨트랙트가 정상적으로 동작하는지 확인

2. 불필요한 비용 절약
- 메인넷에 배포를 하기 위해선 일정량의 가스비 + @ 필요
- 로컬 테스트를 통해 배포 과정에서 발생하는 비용 절약

3. 다양한 시나리오 테스트
- 다수의 유저가 사용할 때, 일정 시간이 흐르고 난 뒤 등
다양한 상황에서도 컨트랙트가 의도한 대로 동작하는지 검장 가능


컨트랙트 테스트 과정

컨트랙트 배포 환경 설정 ---> 테스트 스크립트 작성 ---> 테스트 스크립트 실행


## 컨트랙트 배포 환경 설정
```json
networks:{
    hardhat:{
      forking:{
        url:"https://bsc-dataseed1.binance.org/"
      },
      accounts:{
        mnemonic:"test test test test test test test test test test test junk",
        accountsBalance: "100_000_000_000_000_000_000_000" // 100,000 BNB
      }
    },
  }
```
로컬에서 테스트를 진행할 것이기 때문에 forking부분을 설정해준다.

## 테스트 스크립트 작성

### 테스트 스크립트 분석
테스트 초기 환경 설정
- 컨트랙트 초기값 설정
- signer(게정, 지갑) 생성
- 컨트랙트 배포

describe
- 대분류 테스트

it
- 소분류 테스트

expect
- 결과  값 검증

jest와 비슷 한 것같다. Mocha를 사용한다.


