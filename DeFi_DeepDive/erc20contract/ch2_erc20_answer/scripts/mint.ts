import { ethers } from "hardhat";

const toEther = (amount: any, unit = 'ether') => ethers.utils.parseUnits(amount.toString(), unit)

async function main() {
    const [owner] = await ethers.getSigners()

    const token = await ethers.getContractAt("MyToken", "0xd465c69dbbcf61ccfc684355436e30a1d5b26a5e")

    await token.mint(owner.address, toEther(100))
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});