# Solidity

## Data Type
 - **boolean**
 ```js
    bool public b = false;
    // !, ||, ==, &&
    bool public b1 = !b; // true
    bool public b2 = false || true; // true
    bool public b3 = false == true; // false
    bool public b4 = flase && true; // false
```

 - **btyes** 1~32(뒤에 숫자는 그 바이트만큼 저장을 하겠다는 뜻)
 ```js
bytes4 public bt = 0x12345678;
bytes public bt2 = "STRING";
 ```

 - **address**
 account 와 같음 20byte
 ```js
address public addr = 0x1234567890123456789012345678901234567890;
 ```
 - uint, int8
 흔히 아는 int형과 비슷하다. 단지 차이가 있는데
 int8
 - -2^8 ~ 2^7

uint
 - 0 ~ 2^8-1
```js
int8 public int = 4;
uint256 public uint = 132213;
uint8 public uint2 = 256; //error
uint8 public uint3 = 255; // pass
```

## Reference Type
 - string
 - Arrays
 - struct


## GAS
1ETH = 10^18 wei = 10^9Gwei
1wei = 10^-18

Gwei
- 가스를 낼때 사용하는 단위
가스
 - 스마트 컨트랙을 사용할때 지불하는 비용
 - 스마트 컨트랙을 얼마나 길게 복잡하게 만들수록 높게 측정됨.

// 이더를 보내는 함수를 사용했을 때 21000이라는 가스가 소비되도록 저의가 되어있음.

```js
uint 256 public value = 1 ether;
uint 256 public value2 = 1 wei;
uint 256 public value3 = 1 gwei;
```

gas는 디도스와 같은 공격을 방지할 수 있다.
악의적으로 스마트 컨트랙트를 반복적으로 발생시키거나
서버를 다운시킬 수 잇는 스마트 컨트랙을 만든다고 했을 때
가스를 요구하기 때문에 비용적인 측면에서 부담이 된다.


함수 정의 법
```js
function 함수명 () 접근제어자 {
    ...코드
}
```
