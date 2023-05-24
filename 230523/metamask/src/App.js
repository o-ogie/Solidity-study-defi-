// import {useEffect, useState} from "react"
// import Web3 from "web3"

// /**
//  * Typescript에서
//  * window객체는 any 타입을 사용하자... 가변적으로 늘어나는 객체임.
//  * 
//  * for(i=0; i<10; i++){}
//  * console.log(i)
//  * 
//  * i는 window.i가 생략되어 선언된 것으로 10이 출력이 된다.
//  * 단, let이나 const로 i가 선언이 되었을 경우 블럭 스코프 영향을 받아서 undefined가 출력된다.
//  * 
//  * for (var i =0; i<10; i++){}
//  * console.log(i)
//  * 도 마찬가지로 10이 출력이 되지만 window객체에 생성이 아닌 var로 인한 호이스팅 최상위 선언부로 이동이되어 10이 되는 것이다.
//  */

// const App = () => {
//   const [account, setAccount] = useState(null)
//   const [web3, setWeb3] = useState(null)


//   useEffect(()=>{
//     // window.ethereum.request({
//     //   method:'eth_chainId',
//     // }).then(console.log)
//     // window.ethereum은 metamask가 실행되고 있는 브라우저에 생성된다.
//     ;(async()=>{
//       const [data] = await window.ethereum.request({
//         method:'eth_requestAccounts',
//       })
//       console.log(web3)
//       setWeb3(new Web3(window.ethereum))
//       setAccount(data)
//     })()
//     // window.ethereum.request({
//     //   method:'eth_requestAccounts',
//     // }).then(([data])=>{
//     //   console.log(data)
//     //   setAccount(data)
//     // })
//   },[])

//   // window.ethereum.wallet_addEthereumChain
//   //params

//   const handleClick = (e) => {
//     console.log("click 확인", web3)
//     web3.eth.getBalance(account).then(console.log)
//   }

//   const handleSubmit = (e) => {
//     e.preventDefault()

//     const from = e.target.received.valure
//     const value = e.target.amount.value

//     const tx = {
//       to:account,
//       from,
//       value,
//     }
//     console.log(tx)
//   }

//   return (
//     <>
//       {account || "로그인 전 입니다."}
//       <button onClick={handleClick}>balance</button>

//       <br/>
//       <form onSubmit={handleSubmit}>
//         <input type="text" id="received" placeholder="받을 계정" />
//         <input type="number" id="amount" placeholder="보낼 금액" />
//         <button type="submit">전송</button>
//       </form>

//     </>  
//   );
// }

// export default App;

import {useEffect, useState} from "react"
import Web3 from "web3"
import useWeb3 from "./hooks/web3.hook"

/**
 * Typescript에서
 * window객체는 any 타입을 사용하자... 가변적으로 늘어나는 객체임.
 * 
 * for(i=0; i<10; i++){}
 * console.log(i)
 * 
 * i는 window.i가 생략되어 선언된 것으로 10이 출력이 된다.
 * 단, let이나 const로 i가 선언이 되었을 경우 블럭 스코프 영향을 받아서 undefined가 출력된다.
 * 
 * for (var i =0; i<10; i++){}
 * console.log(i)
 * 도 마찬가지로 10이 출력이 되지만 window객체에 생성이 아닌 var로 인한 호이스팅 최상위 선언부로 이동이되어 10이 되는 것이다.
 */

const App = () => {
  const [count, setCount] = useState(0)
  const {user, web3} = useWeb3() // useWeb3내부의 상태가 변경되면서 한번 더 실행된다.
  console.log(account)

  if(account === null) return "값이 존재하지 않습니다."

  const handleClick = async(e)=>{
    e.preventDefault()
    const to = e.targer.received.value
    const value = web3.utils.toWei(e.target.amount.value)
    const tx = {
      form: account,
      to,
      value
    }
    web3.ethe.sendTransaction(tx).then(console.log)
  }


    const increment = async() => {
      const incrementData = abi.find((data)=>data.name ==="increment")
      const data = web3.eth.abi.encodeFunectionCall(incrementdata, [])

        const from = user.account
        const to = ""
        const tx = {
          from,
          to,
          data,
        }
        const result = await web3.the.sendTransaction(tx)
        setCount(web3.utils.toBN(result).toString(10))
    }
    const decrement = () => {}

    useEffect(()=>{
      console.log('Effect')

      if(web3 === null) return
      //call
      web3.eth.call({
        // storage
      })
    },[])


    return (
    <>
      <form>
        <input type="text" id="received" placeholder="받을 계정" />
        <input type="number" id="amount" placeholder="보낼 금액" />
        <button type="submit">전송</button>
      </form>

      <form>
        <h2>카운터</h2>
        <button onClick={increment}>증가</button>
        <button onClick={decrement}>감소</button>
      </form>

    </>  
  )
}

export default App
