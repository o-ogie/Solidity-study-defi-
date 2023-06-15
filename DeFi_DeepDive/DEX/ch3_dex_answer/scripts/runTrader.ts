import { ethers } from "hardhat";
import { toEther, fromEther, MAX_UINT } from "../test/utils/functions";


async function main() {
  const owner = "0xe6Ffe66498BADF7437dAddEa9fa22E88C7B4e073"
  const whaleToken = await ethers.getContractAt("IERC20", "0x15308179057A1d5e56C61a612b1EADfA5F669Aad")
  const wklay = await ethers.getContractAt("IERC20", "0x043c471bEe060e00A56CcD02c0Ca286808a5A436")
  
  const trader = await ethers.getContractAt("Trader", "0x411c090A276468D14BB495738ed6baEF046D1DB1");
  const factory = await ethers.getContractAt("IUniswapV2Factory", "0x90B06a1B5920E45c5f0aC3D701728669527bF275");
  const chef = await ethers.getContractAt("IMasterChef", "0x5bc059C6fAC255702Ea697415f82e44c5ec3CB76")

  // show token info 
  console.log(`WHLE: ${fromEther(await whaleToken.balanceOf(owner))}`)
  console.log(`KLAY: ${fromEther(await ethers.provider.getBalance(owner))}`)

  // approve token
  // await whaleToken.approve(trader.address, MAX_UINT)

  // addLiquidity
  // await trader.addLiquidityKlay(whaleToken.address, toEther(100), {value: toEther(10)})

  // swap WHLE -> Klay
  // await trader.swapExactKlayToToken([wklay.address, whaleToken.address], {value: toEther(5)})

  // Klay-WHLE LP
  // const klayWhaleLpAddress = await factory.getPair(whaleToken.address, wklay.address)
  // const klayWhaleLp = await ethers.getContractAt("IERC20", klayWhaleLpAddress)
  // console.log(`KLAY-WHLE LP: ${fromEther(await klayWhaleLp.balanceOf(owner))}`)

  // deposit
  // await klayWhaleLp.approve(trader.address, MAX_UINT)
  // await trader.deposit(1, toEther(1))
  // console.log(`deposit amount: ${fromEther(await trader.depositBalance(1))}`)

  // pending reward
  // console.log(`pending reward: ${fromEther(await trader.pendingReward(1))}`)

  // withdraw
  // await trader.withdraw(1, toEther(1))

  // claimReward
  // await trader.claimReward()
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
