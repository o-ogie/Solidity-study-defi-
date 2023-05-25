# Truffle

배포
call, send
abi나 send부분이 간단해진다.


```sh
npx truffle init
```

```sh
npx truffle compile
```

truffle 5.5.27? 버전 이후로는 migration.json파일이 없다.

testnet에 배포를 한다는 것은 
testnode를 가지고 있다는 뜻이다.
이더리움 노드를 가지고 있지 않기 때문에
provider와 같은 플랫폼을 활용해야함.

testnet도 하나의 노드이다 다만 메인넷과 체인아이디가 다를 뿐이다.
돌아가는 구조나 로직은 같다.



-------truffle console-------
> Counter
> Counter.deployed
> Counter.address


web3를 사용하는 이유
-> 노드에 요청청을 하기위해서. rpc형태로 통신을 함.
Counter에 web3가 포함된 객체가 만들어진 것이다.
web3가 가지고 있는 유틸이던지 다 포함되어 있다.

```js
const Web3 = require('web3')
const web3 = new Web3('127.0.0.1:8545')
// 위 과정을 다해서 포함시킴.
```

deploy 진행 후 call 이라는 것을 진행해보자.

```js
Counter.deployed().then(instance=> counter = instance)
```
전역 변수에 counter라고 만들어서 instance를 대입한 것이다.

```sh
counter.getValue()
counter.icreament()
```



-------------------------

후에 코드를 바꾼다면 abi, bytecode 등 다 바뀌게 된다
매번 수정하기 힘들고 하기때문에
test코드를 진행 후 마지막에 다시 배포한다