const express = require("express")
const cors = require("cors")
const Web3 = require('web3')
require('dotenv').config();
const { PROJECT_ID } = process.env;
const app = express()
const CounterContract = require("./contracts/Counter.json")

const web3 = new Web3(`https://goerli.infura.io/v3/${PROJECT_ID}`)

app.use(cors())
app.use(express.json())


app.post("/increment",(req,res)=>{
    const {from} = req.body
    const {abi} = CounterContract

    const deployed = new web3.eth.Contract(abi, "0x2BD2Ddf7b294cAB58D94b1A1e4fe4bF0EFA09ab4")
    const data = deployed.methods.increment().encodeABI()
    res.json({
        from,
        to:"0x2BD2Ddf7b294cAB58D94b1A1e4fe4bF0EFA09ab4",
        data,
    })
})

app.listen(3005,()=>{
    console.log('BE SERVER START')
})


// 서명 3가지 방법
// 1. front에서 바로 Transaction 날리기
// 2. back에서 Transaction 객체를 받아서 sendTransaction하기
// 3. back에서 바로 sendTransaction 하기.