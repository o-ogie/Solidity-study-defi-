// Counter.json 안에 있는 bytecode가 필요함.

const Counter = artifacts.require("Counter")
// artifacts => JSON파일을 일컫는 것.


// 
module.exports = (deployer) => {
    console.log(deployer)
    deployer.deploy(Counter)
}


