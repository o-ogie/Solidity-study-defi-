const Lottery = artifacts.require("Lottery");

contract("Lottery", ([deployer, user1, user2])=>{ // ganache의 계정 10개가 순차적으로 들어온다. 10개까지 파라미터를 받을 수 있음.
    let lottery;
    beforeEach(async () => {
        console.log("Before each")

        lottery = await Lottery.new()
    })

    it("Basic test", async () => {
        console.log("Basic test")
        let owner = await lottery.owner;
        let value = await lottery.getSomeValue();
        console.log(owner);
        console.log(value);

        assert.equal(value, 5);

    })

    it("getPot should return current pot", async () => {
        let pot = await lottery.getPot();
        assert.equal(pot, 0);

    })

})