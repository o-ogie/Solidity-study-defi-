const assertRevert = require("./assertRevert");
const Lottery = artifacts.require("Lottery");
const expectEvent = require("./exprectEvent")


contract("Lottery", ([deployer, user1, user2])=>{ // ganache의 계정 10개가 순차적으로 들어온다. 10개까지 파라미터를 받을 수 있음.
    let lottery;
    let betAmount = 5*10**15
    let bet_block_interval  = 3
    beforeEach(async () => {
        console.log("Before each")

        lottery = await Lottery.new()
    })

    it("Basic test", async () => {
        console.log("Basic test")
        let owner = await lottery.owner;
        // let value = await lottery.getSomeValue();
        console.log(owner);
        // console.log(value);

        // assert.equal(value, 5);

    })

    it("getPot should return current pot", async () => {
        let pot = await lottery.getPot();
        assert.equal(pot, 0);

    })

    describe("Bet", ()=>{
        it("should fail when the bet money is not 0.005 ETH",async()=>{
            // Fail transcation
            await assertRevert(lottery.bet("0xab", {from : user1, value:4000000000000000}))

            // transaction object {chainId, value, to, from, gas(Limit), gasPrice}
        })
        it("should put the bet to the bet queue with 1 bet",async()=>{
            // bet
            let receipt = await lottery.bet("0xab", {from : user1, value:betAmount})
            // console.log(receipt)

            let pot = await lottery.getPot()
            assert.equal(pot, 0)

            //check contract balnace == 0.005
            let contractBalance = await web3.eth.getBalance(lottery.address)
            assert.equal(contractBalance, 5*10**15)

            // check bet info
            let currentBlockNumber = await web3.eth.getBlockNumber();
            let bet = await lottery.getBetInfo(0)
            assert.equal(bet.answerBlockNumber, currentBlockNumber + bet_block_interval)
            assert.equal(bet.better, user1)
            assert.equal(bet.challenges, "0xab")
            
            
            // check log
            // console.log(receipt)
            await expectEvent.inLogs(receipt.logs, "BET")
        })
    })

})