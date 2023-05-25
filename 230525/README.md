# TESTNET
MainNet과 ChainId만 다를뿐 로직이나 동작은 같게 돌아간다.

1번이 MainNet
2,3,4,5,6,7 TestNet

Ganache         TestNet과의 차이점
로컬             NetWork
1TX -> 1Block   Txs~30초


testNet에 연결하는 방법
- 이미 network를 유지하고 있는 서버에 연결하기 위해서는
url을 알아야하는데 알려진게 없다.

1. 내 컴퓨터를 노드로 만드는 방법.
노드를 실행해서 주변 노드를 탐색해서 연결한다. 내컴퓨터가 되었기 때문에 내 컴퓨터에 요청하여 블록체인서버에 접근할 수 있다.
// 블록체인 서버에 블록 데이터들을 다운할때까지 사용하지 못함...420GB이상


2. Node Provider 중앙화API서버 이용. 
 - infura
 - Alchemy


API https://goerli.infura.io/v3/8b31cfb2f2b3472081dd6243295b44ea

npx truffle init
npx truffle migrate --network georli


0xc94dC1f84184d814eAA0657F9B4C7d8f99E6E163

txhash : 0x8ba8cf40f16692240597d5f1ca11e02c707ed530d2d8ffd0031f0facda72b75b

CA: 0x23a1a06f6B1137f8d9f08a7e0Ef6921670D4806a

```js
web3.eth.getTransaction("TX Hash")
web3.eth.getTransactionReceipt("")

```


# DAPP
백엔드에서는 트랜잭션 데이터를 만들어주고 서명은 wallet서버에서 진행하여 blockchain node에 요청한다.