import CounterContract from'../contracts/Counter.json'
import {useState} from 'react'
import { useEffect } from 'react'

const Counter = ({web3, account}) => {
    const [count,setCount] = useState(0)
    const [deployed, setDeployed] = useState(null)
    const get = async () => {
        if(deployed === null) return alert("deployed가 없음")

        const value = await deployed.methods.get().call()
        setCount(value)
    }
    const increment = async() => {
        if(deployed === null) return alert("deployed가 없음")

        const result = await deployed.methods.increment().send({
            from: account,
        })
        deployed.methods.get().call().then((value)=>{
            setCount(value)
            console.log(value)
        })

    }
    const decrement = async() => {
        if(deployed === null) return alert("deployed가 없음")

        const result = await deployed.methods.decrement().send({
            from: account,
        })

        deployed.methods.get().call().then((value)=>setCount(value))
    }

    useEffect(() => {
        if(!deployed) setDeployed(new web3.eth.Contract(
            CounterContract.abi,
            //   CounterContract.networks[5].address
            "0x2BD2Ddf7b294cAB58D94b1A1e4fe4bF0EFA09ab4"
          ));
        // 로그를 받아서 데이터로 상태값을 변경함 -> 다른 사람이 상태 값을 변경했을때 이벤트로 log데이터를 받음.
        web3.eth.subscribe('logs',{address:"0x2BD2Ddf7b294cAB58D94b1A1e4fe4bF0EFA09ab4"}).on("data",(log)=>{
            const params = [
                {
                  "indexed": false,
                  "internalType": "uint256",
                  "name": "count",
                  "type": "uint256"
                }
            ]
            console.log(log.data)

            const value = web3.eth.abi.decodeLog(params, log.data)
            console.log(value)

            setCount(value.count)
        })
      }, []);

    return <>
        <div>
            <h2>Counter: {count}</h2>
            <button onClick={increment}>+</button>
            <button onClick={decrement}>-</button>
        </div>
    </>
}

export default Counter