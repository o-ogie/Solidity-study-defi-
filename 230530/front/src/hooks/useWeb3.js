import {useState, useEffect} from "react"
import Web3 from "web3"

const useWeb3 = () => {
    const [account, setAccount] = useState(null)
    const [web3, setWeb3] = useState(null)


    useEffect(()=>{
        if(!window.ethereum) return

        window.ethereum.request({
            method:"eth_requestAccounts",
        }).then(accounts=>{
            console.log("gdgd",accounts)
            setAccount(accounts[0])
            const web3 = new Web3(window.ethereum)
            setWeb3(web3)
        },error=>{
            setAccount(null)
            setWeb3(null)
        })
    },[])


    return [account,web3]
}

export default useWeb3