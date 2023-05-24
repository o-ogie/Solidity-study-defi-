import { useEffect, useState } from "react";
import Web3 from "web3"
// 궁극적 목적은 데이터를 반환한다.
// 데이터를 만들때 hook함수를 활용한다.
const useWeb3 = () => {
    const [user, setUser] = useState({
        account:"",
        balance:"",
    })

    const [web3, setWeb3] = useState(null)

    useEffect(()=>{
        if(window.ethereum){
            winwdow.ethereum.request({
                method:"eth_requestAccounts"
            }).then(data=>{
                const web3Provider = new Web3(window.ethereum)
                setWeb3(web3Provider)
                setUser({
                    ...user,
                    account:data,
                    balance: await web3Provider.utils.toWei(await web3Provider.eth.getBalance(data))
            })
            }).catch((error)=>{
                console.log(error.message)
            })
        }else{
            alert("메타마스크 설치 ㄱ")
        }
    },[])

    return{
        account,
    }
}

export default useWeb3

// react
// class -> function
// hook

// 커스텀훅
// 내 마음대로 훅 함수를 사용을 하지만, return이 jsx가 아닌 것들.