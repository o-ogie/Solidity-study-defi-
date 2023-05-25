import CounterContract from'../contracts/Counter.json'
import {useState} from 'react'
import { useEffect } from 'react'

const Counter = ({web3, account}) => {
    const [count,setCount] = useState(0)
    const [deployed, setDeployed] = useState(null)
    const get = async () => {
        if(deployed === null) return alert("deployed가 없음")

        const value = await deployed.methods.getValue().call()
        console.log(value)
        setCount(value)
    }
    const increment = async() => {
        if(deployed === null) return alert("deployed가 없음")

        const result = await deployed.methods.increment().send({
            from: account,
        })
        deployed.methods.getValue().call().then((value)=>setCount(value))

    }
    const decrement = async() => {
        if(deployed === null) return alert("deployed가 없음")

        const result = await deployed.methods.decrement().send({
            from: account,
        })

        deployed.methods.getValue().call().then((value)=>setCount(value))
    }

    useEffect(()=>{
        if(web3 === null || account === null) return

        // web3.eth.Contract === deployed()
        const Deployed = new web3.eth.Contract(CounterContract.abi, CounterContract.networks[1684897600629].address)

        setDeployed(Deployed)
        Deployed.methods.getValue().call().then((value)=>{
            setCount(value)
        })
        // Deployed.methods.increment()
        // 1. ABI 파일에서 Increment 인코딩
        // 2. 인코딩한 데이터를 가지고 TX객체를 생성한다.
        // 3. send()한다.

        // Deployed.methods.getValue().call().then(console.log)
    },[])

    return <>
        <div>
            <h2>Counter: {count}</h2>
            <button onClick={increment}>+</button>
            <button onClick={decrement}>-</button>
        </div>
    </>
}

export default Counter