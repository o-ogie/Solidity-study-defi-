# Ethereum

백서
- 시스템을 어떻게 구현했고 어떠한 형태이며, 원리, 개념 등등 시스템에 관하여 저술해놓은 것.
- 백서를 기반으로 제작한다.

이더리움 백서
 - https://github.com/ethereum/wiki/wiki (한국어:https://github.com/ethereum/wiki/wiki/%5BKorean%5D-White-Paper)

이더리움의 공동 창립자 비탈릭 부테린이 작성하였다.
이더리움 개발하는 


**차세대 스마트 컨트랙트와 탈중앙화된 어플리케이션 플랫폼**

`비트코인` 보면 결제에 포커스가 맞춰져 있음.
`이더리움` 결제에만 포커스가 맞춰져 있는게 아님.

이더리움은 블록체인 생태계를 활용해서 어플리케이션을 쉽게 만들 수 있는 플랫폼

 
 이더리움이 제공하려는 것은 `튜링완전(turing-complete)` 프로그래밍 언어가 심어진 블록체인이다.
 
 > 튜링 안전?
    - 계산 가능한 문제를 해결할 수 있는 모든기계의 공통된 능력
    - 연산 가능한건지 불가능 한건지.
    - 계산이 된다면 계산하고 안된다면 안함.으로 정리할 수 잇음.
 > 앨런 튜링


## 목차

- 역사 (비트코인)
    - 상태변환 시스템으로써 비트코인
    - 채굴
    - 머클트리
    - 스크립팅

- 이더리움
    - 이더리움 Account
    - 이더리움 Transaction
    - 이더리움 상태 변환 함수
    - 이더리움 코드실행
    - 이더리움 블록체인과 채굴

### 역사
POS 넘어간 이유?

POW는 누구나 채굴을 할 수 있기때문에... 그룹을 맺어 나눠 가지는 경우가 생긴다.
그룹이 커질수록 블록체인의 생태계를 장악하게 되는 것이다 라는 생각에서 나온 것임.
                                    
전력 소비 낭비
c  y 
  ## 상태
쇼핑몰 구현

1. 상품테이블
2. 유져테이블
3. 오더테이블 (State)

## 스크립팅
`Smart Contract` 뜻을

A -> B 

C:의 서명도 필요하다. (중개역할)

1. 튜링불안전성
연산이 되지 않음. 따라서 중앙에서 연산을 해줄 서버같은게 필요한데 이를 이더리움이 한다?

2. 다양한 값을 표현할 수 없다.
3. 블록체인을 해독할 수 없다. 

## 이더리움
이더리움의 목적은 분산 어플리케이션 제작을 위한 대체 `프로토콜`을 만드는 것이다.
`Dapp`

`c`라는 사람이 은행역활을 할 수 있느냐
> 이더리움은 블록체인 플랫폼의 역활을 하고있기 때문.
> 이 플랫폼의 역핧을 하기 위해서 튜링안전성

### 이더리움 Account

이더리움에서는 **상태** **Account**

state               transaction         state
00001:10btc         a -> c :2btc        00001:2btc


```typescript
interface Account{
    nonce:number        // 각 트랜잭션에 오직 한번만 처리되는것( 이중 지불 막기위함 )
    balance:string      // 이더 잔액
    storageRoot:string  // 
    codeHash:string     // 스마트컨트랙트 코드
}
// nonce 비트코인의 nonce와 다름.
```

```typescript
class Counter {
    private count:number =0
    contructor(){}

    getCount(){
        return this.count
    }

    setCount(_count){
        this.count = _count
    }
}

const counter = new Counter()
counter.setCount(5)
console.lg(counter.count)
```
```solidity
pragma solidity ^8.0.0;

contranct Count{
    uint256 value;

    function getValue() public view returns(uint256){
        return value
    }

    function setValue(uint256 _value) public {
        value = _value
    }
}
```

```typescript
const 0x00001 = { // account
    nonce:0,
    balance:10
}
```

0x00001이 트랜잭션을 발생시키면 0x00001, 0x00002의 상태가 바뀐다.
비트코인처럼 트랙잭션의 txout이 쌓여서 계산하는게 아니라 상태값이 바로 바뀌게 된다.


1 ETH = 10e+18 = 100000000000000000

1 ETH => 다른 사람에게 보낼 때
1*(10**18)

wei 최소단위

`Account` 납득하기

- EOA (Externally Owned Account) : 서명을 가지고 트랜잭션을 발생시킬 수 있는 Account
    nonce, balance를 사용
- CA (ContractAccount) : Contract가 담겨있는 계정
    - 위 Account Interface의 규격을 다 사용함.
    - tx를 발생시킬 수 없다. => 프라이빗 키가 존재하지 않음.

## 메세지와 트랜잭션
이더리움에서는
Signature(서명)이 있는
Receipt(영수증)을 `Transaction`이라고 말함.

Signature(서명)이 없는
Receipt(영수증)을 `Message`이라고 말함.

```typescript
interface Message {
    form?:string
    to:string
    value?:number

    hash?:string
    nonce?:number

    gas?:number
    gasPrice?:number

    data?:string //ca
}


// SignatureInput <-->
interface Transaction extends Message {
    v: number
    r: string
    s: string
}
```


가스 측정방식
30000만큼 비용 발생함.
gasPrice : 1L 당 1716
gas : 총 주유량 17.4825 (30000/1716) 21000이 디폴트 값으고, 이후로 증가함.

총 수수료 : gas * gasPrice

스마트 컨트랙트는 연사을 할때마다 가스가 발생한다.
1byte당 5가스정도.
트랜잭션을 3byte만큼 발생한다면 21015가스가 발생한다. 여기에 gasPrice를 곱한 값이 총 수수료
 