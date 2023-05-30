import AppleShopContract from "../contracts/AppleShop.json"
import {useEffect, useState} from "react"

const AppleShop = ({ web3, account }) => {
    const [deployed, setDeployed] = useState(null)
    const [apple, setApple] = useState(0)

    const buy = async () => {
        await deployed.methods.buy().send({
            from: account,
            to: "0x5E5D0fF07BE3056B9aDaA7cE008164a8019e40a3", // 생략가능 
            value: web3.utils.toWei("1","ether"),
        })
    }

    const sell = async () => {
        await deployed.methods.sell().send({
            from:account
        })
    }

    useEffect(()=>{
        if(!deployed) return
        deployed.methods.get().call().then(setApple)

    },[deployed])

     useEffect(()=>{
        // Call
        if(!web3) return

        const instance = new web3.eth.Contract(AppleShopContract.abi, "0x5E5D0fF07BE3056B9aDaA7cE008164a8019e40a3")
        setDeployed(instance)
     },[])

    return (
        <>
            <h2>사과 가격 : 1ETH</h2>
            <div>
                내가 가진 사과 갯수 : {apple} <button onClick={buy}>구매</button>
            </div>
            <div>
                총 사과 판매 가격 {apple}ETH <button onClick={sell}>판매</button>
            </div>
        </>
    )
}

export default AppleShop