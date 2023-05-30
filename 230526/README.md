```sh
npm init -y
npx truffle init
npm install dotenv @truffle/hdwallet-provider
npx ganache-cli
```





# ERC Ethereum Requests for Coments

Token과 Coin의 차이
메인 넷의 유무

Token - Smart Contract

Token을 만들때 정해진 규칙대로 만들어 줘야한다.
ERC숫자 숫자번째에 관한걸 채택하여 사용함.

ERC20 - 토큰
ERC721 - NFT
ERC1155 - NFT

ABI가 다 정해져 있고 같아야한다. 물론 내부적 추가 기능은 구현이 가능함.

2명있어야 거래가 가능하다.
누구는 amount, balance라고 한다.


```typescript
interface balance {
    address:string
    amount:number
}

interface Token{
    name:string
    balances:Balance[]
    transfer(to,value){}
}

const IngToken:Token = {
    name:'ingToken',
    balances:[
        {
            address:'A',
            amount:50
        },
        {
            address:'B',
            amount:10
        }
    ]
}

// A
ingToken.transfer(B,50)
```

생성자 함수는 EVM이 최초로 한번 실행한때 한번 실행된다. => 배포 할때 한번 배포도 한번만 가능함. 또 배포하면 다른 컨트랙트이다.

npx truffle console
web3.eth.getTransaction("txhash")

SimpleStore.deployed().then(data=>instance=data)
instance.methods

## mapping

배열 or 객체
```js
const a = ['web7722','asdfasdf']
            a[1]        a[2]

const b = {name:'ingoo',id:"web7722"}
```

```solidity
mapping(number=>string) public a;

a[0] = web7722;
a[1] = asdfasdf;

mapping(string=>string) public b;
b

mapping(address>uing256) public c;


```
mapping을 사용하는 이유는 군집형 데이터를 사용하고 싶어서이다.

# EIP Ethereum Improvement Proposals




Available Accounts
==================
(0) 0xA0a51b8648AF5CE73865663B4fCF9Fee916CFA64 (100 ETH)
(1) 0x25cA518a11965FF3FF2cC9139a5B1558D2f33bb8 (100 ETH)
(2) 0xc60E2A7Bd50b68d812FE3f66DB85BbCb61139FcF (100 ETH)
(3) 0x3E1AF380ca7981E8C7b0Cb7E2B56f8562bd52451 (100 ETH)
(4) 0x4ab84A8e74E82ec56135FD414Be19750063F2aa0 (100 ETH)
(5) 0x26a9f7559Df7dc3D3C9eaA9C0b2F8174f5B04F58 (100 ETH)
(6) 0x491131367E615ae8f12BF58C23c2A419aBd9daB4 (100 ETH)
(7) 0x11Bb1BEd3D24D69EF4ddf0BB754A3da355772677 (100 ETH)
(8) 0x1E5Bcfed5587894eE8F06fB142d2e7FFb17e5428 (100 ETH)
(9) 0x02e5522E16BB566b3ACde9Ad8F47489D2738Bb2A (100 ETH)

Private Keys
==================
(0) 0x352aeb32e9c174765019dd78af5febfce2f59369aa70a9c3e25905bf6b783187
(1) 0xb1537b632f62fe2c34c0fdae38bb547b7806a0ed3b13c9a57017524bb7d45677
(2) 0x03039dda13a2f80cb5145bd89f3fd0f818ed0b2a72dbd68aef412b7edd244f19
(3) 0x0b86b48fb72849b5e850ad0f7ffd52a0997074478faaddd7e335f1ba54289ece
(4) 0xc008ca020baacf61018f733ca71200b90bf6d6bd15885e3aa109e4bc5315dd7c
(5) 0x184bc4a6ea371610899c3346306ad688b989f7d4b5753cbf6455c04805f89ae3
(6) 0xee015128a8643bf269a68bd9da8017e3a4e7737e84267803f039f7547527cb65
(7) 0x43e1f1e6e5607b09f39bbf72dd187d9e4d34d200e14523b04d65c66fde9735f0
(8) 0xb6eca52ebf185061c205ad82b3008a5b007e36faa198cf8bc0a03add0e5b6eb4
(9) 0xe3edeae3bce9f7d3b29709aa7efdbdecfc7c73c9e5b507a1ec201f1b15250e9e

HD Wallet