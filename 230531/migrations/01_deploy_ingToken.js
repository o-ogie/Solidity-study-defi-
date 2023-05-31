const IngToken = artifacts.require("ingToken")

module.exports = (deployed) => {
    deployed.deploy(IngToken)
}