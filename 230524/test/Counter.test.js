const Counter = artifacts.require("Counter")

// npx truffle test
contract("Counter", (account)=>{
    console.log(account)
    let instance
    describe("Counter Contract", () => {
        it("instance 생성", async()=>{
            instance = await Counter.deployed()
            console.log(instance)
            // expect(typeof instance).to.equel("object")
        })

        it("getValue", () =>{
            const value = instance.getValue()
            console.log(value)
        })

        it("increment", async() => {
            await instance.increment()

            const value = await instance.getValue()
            console.log(value.toNumber())
        })

        it("decrement", async()=>{
            await instance.decrement()
            const value = await instance.getValue()
            console.log(value.toNumber())
        })
    })
})