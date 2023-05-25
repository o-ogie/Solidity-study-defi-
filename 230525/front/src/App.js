import useWeb3 from "./hooks/web3";
import Counter from "./pages/Counter"

const App = () => {
  const [account, web3] = useWeb3()

  if(!account) return <>메타 마스크 연결 후 사용이 가능합니다.</>

  return<>
    <h1>Hello Counter</h1>
    <Counter web3={web3} account={account}/>
  </>
}

export default App;
