# NFT ERC721


## ERC20


## ERC721 / NFT
NFT를 만든다는 것은 객체를 만드는 것
{
    속성: 값,
    ...
}

객체를 찍어내고 내용은 마음대로 가능하다.
내용에 제약이 없다보니 다양해지고 규격이생김
{
    id:"",
    metadataURL:"http://asd.asdfasdf.com/asdfasdf/example.json"
}

### metadata
Type: JSON...(웹서버에 저장된) => 호스트 값을 넣어줘야함.
metadataURL을 생성하기 전에 서버에 JSON파일이 올라가 있어야 한다.


###  deploy
배포를 쉽게하기 위해서 truffle을 사용했음.
웹IDE도 있는데 => REMIX

### remix IDE 툴로 개발하기.
```sh
npx truffle init
npm install -g @remix-project/remixd
remixd -s . --remix-ide https://remix.ethereum.org

npm init -y
npm install @openzeppelin/contracts
```

## owners
```json
{
    "1":"0x0001",
    "2":"0x0002",
    "3":"0x0003",
    "4":"0x0004",
}
```


## balance
```json
{
    "0x0001":1,
    "0x0002":2,
    "0x0003":1,
    "0x0004":1,
}
```

BTC는 utxo out의 값으로 잔액을 계산한다. 그러기 위해서는 모든 블럭와 트랜잭션을 가져야함.
ETH는 Account가 utxo의 역할을 하고 마찬가지로 모든 블럭과 트랜잭션을 가지고 있어야 한다.
account는 ca와 eoa로 나뉘는데, ca가 트랜잭션을 발생시킨 account이고 이중에 ntf를 발행한 ca를 필터링한다.




Available Accounts
==================
(0) 0x597EB90588382295cfcCd60dE11232aad1E3E8da (100 ETH)
(1) 0xD97F74d54F07c3A63631b02b0B75bC81ca4E0517 (100 ETH)
(2) 0x3b0098Fb701aE14489C91349af72fA0D9812663D (100 ETH)
(3) 0x06f02C8F344536De84B024fdbF03C449054050c9 (100 ETH)
(4) 0x32108Be656932685aE05b95A92F30038C549ebD7 (100 ETH)
(5) 0xD9c1955bcad8323eAE27F329f17CBa4f63a1eD2E (100 ETH)
(6) 0xac4FB797918d9b6C854bfd092944Af9AcAd0C1aa (100 ETH)
(7) 0x2d17D7466cd9406cd99C703CbFE366298Bf2b9Ba (100 ETH)
(8) 0xa877a04d2473778D2745d70884171b0112d1F908 (100 ETH)
(9) 0xB04871Bc9F132120ec6A3917bF92809aB1a33CE7 (100 ETH)

Private Keys
==================
(0) 0x4f65b974a8d8e858c368fc48c6e682a1b48fc67350f98214eeabc02d1b73f34f
(1) 0x3c828eb5973a35ca2acd0754cafdd79fb3715445ce27e42abe00039559608ee3
(2) 0x08a238b456ab9dfdf25d8d006e0817a8bda5c5f6b1d7152b88e2c2067a27973f
(3) 0x5081132da921e36639565c5d2f0189e2aa450219f1a8fad1ce4d4e19b12f07e5
(4) 0xe9ebe50096fb36141556e42765f8a8884e64acbf3cf8b66cc7db6f822a8a4b1c
(5) 0xc85b12edf3839fe84727ca6e296e59c0dd6865dc01dfaed9475930f9f2911bcb
(6) 0x365ed2e03623080372b63a3a55a5bdf8a744bb10b79ce3e9805780183c7bc868
(7) 0xdb897fdae92cc4820cbffdabe4fec15df278caaa39afe7aeeed93bb8278e3bbf
(8) 0xc32ecc795d78dd75a1f175cedee271854e29c1e5793a47068c0f4f0893ee53eb
(9) 0xb28f1214436efe0d5f19e79eec8e81767bcd8ffe97d2bfd92a8928f96a4693d7