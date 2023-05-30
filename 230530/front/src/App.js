import AppleShop from "./pages/appleShop";
import useWeb3 from "./hooks/useWeb3";

const App = () => {
  const [account,web3] = useWeb3()

  if(!account || !web3) return <>
    메타마스크 연결 후 이용이 가능합니다.
  </>


  return (
    <>
      <h2>사과 가게</h2>
      <AppleShop web3={web3} account={account}/>
    </>
  )
}

export default App;
