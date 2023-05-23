import { useEffect, useState } from "react";

// 궁극적 목적은 데이터를 반환한다.
// 데이터를 만들때 hook함수를 활용한다.
const useWeb3 = () => {
    const [account, setAccount] = useState(null)

    useEffect(()=>{
        setAccount("hello")
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