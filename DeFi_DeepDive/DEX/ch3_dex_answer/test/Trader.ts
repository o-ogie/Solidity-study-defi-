import '@nomiclabs/hardhat-ethers'
import { ethers } from 'hardhat'
import { BigNumber, Contract } from 'ethers'
import { loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import * as mlog from 'mocha-logger'
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'
import { Tokens, Contracts } from './utils/constants'
import functions, { MAX_UINT, assertClose, assertGte, assertEqual, mineBlock } from './utils/functions';

const toEther = functions.toEther
const fromEther = functions.fromEther


describe ("Ch3. Trader TEST", async () => {
    let tester:SignerWithAddress, user1:SignerWithAddress, user2:SignerWithAddress
    let trader: Contract
    let router: Contract
    let factory: Contract
    let chef: Contract
    let whale: Contract, fish: Contract, wklay: Contract
    let whaleKlayLp: Contract, whaleFishLp: Contract

    const initTest = async () => {
        [tester, user1, user2] = await ethers.getSigners()
        const impersonatedOwner = await ethers.getImpersonatedSigner(Contracts.OWNER);

        // tokens
        whale = await ethers.getContractAt("IERC20", Tokens.WHLE)
        fish = await ethers.getContractAt("IERC20", Tokens.FISH)
        wklay = await ethers.getContractAt("IERC20", Tokens.WKLAY)
        await whale.connect(impersonatedOwner).mint(tester.address, toEther(1000))
        await fish.connect(impersonatedOwner).mint(tester.address, toEther(50000))

        // contracts
        router = await ethers.getContractAt("IUniswapV2Router02", Contracts.ROUTER)
        factory = await ethers.getContractAt("IUniswapV2Factory", Contracts.FACTORY)
        chef = await ethers.getContractAt("IMasterChef", Contracts.CHEF)
        
        const traderFactory = await ethers.getContractFactory("Trader")
        trader = await traderFactory.deploy();
    }

    describe('Liquidity', async () => {
        it('addLiquidityKLAY (WHLE - KLAY LP)', async () => {
            await loadFixture(initTest)
            const amountIn = toEther(10)
            const amountInKLAY = toEther(5)
            const beforeWhale = await whale.balanceOf(tester.address)
            
            await whale.approve(trader.address, amountIn)
            const beforeKLAY = await ethers.provider.getBalance(tester.address)
            const tx = await trader.addLiquidityKlay(whale.address, amountIn, {value: amountInKLAY})
            
            // calc gas fee
            const receipt = await tx.wait()
            const gasFee = tx.gasPrice.mul(receipt.gasUsed)
            
            const afterWhale = await whale.balanceOf(tester.address)
            const afterKLAY = await ethers.provider.getBalance(tester.address)
            const lpAddress = await factory.getPair(Tokens.WHLE, Tokens.WKLAY)
            const lp = await ethers.getContractAt("IERC20", lpAddress)
            
            assertGte(await lp.balanceOf(tester.address), BigNumber.from(0))
            assertEqual(beforeWhale.sub(afterWhale), amountIn)
            assertEqual(beforeKLAY.sub(afterKLAY).sub(gasFee), amountInKLAY)
        })
        it('addLiquidity (WHLE - FISH LP)', async () => {
            await loadFixture(initTest)
            const amountInWhale = toEther(10)
            const amountInFish = toEther(100)
            const beforeWhale = await whale.balanceOf(tester.address)
            const beforeFish = await fish.balanceOf(tester.address)
            
            await whale.approve(trader.address, amountInWhale)
            await fish.approve(trader.address, amountInFish)
            await trader.addLiquidity(whale.address, fish.address, amountInWhale, amountInFish)
            
            const afterWhale = await whale.balanceOf(tester.address)
            const afterFish = await fish.balanceOf(tester.address)
            const lpAddress = await factory.getPair(Tokens.WHLE, Tokens.FISH)
            const lp = await ethers.getContractAt("IERC20", lpAddress)
            
            assertGte(await lp.balanceOf(tester.address), BigNumber.from(0))
            assertEqual(beforeWhale.sub(afterWhale), amountInWhale)
            assertEqual(beforeFish.sub(afterFish), amountInFish)
        })

        describe('after addLiquidity', async () => {
            const initTestAfterAddLiquidity = async () => {
                await loadFixture(initTest)
                const amountInWhale = toEther(100)
                const amountInFish = toEther(5000)
                const amountInKLAY = toEther(200)
                
                // approve
                await whale.approve(trader.address, MAX_UINT)
                await fish.approve(trader.address, MAX_UINT)
                
                // add liquidity
                await trader.addLiquidityKlay(whale.address, amountInWhale, {value: amountInKLAY})
                await trader.addLiquidity(whale.address, fish.address, amountInWhale, amountInFish)

                let lpAddress = await factory.getPair(Tokens.WHLE, Tokens.FISH)
                whaleFishLp = await ethers.getContractAt("IERC20", lpAddress)
                lpAddress = await factory.getPair(Tokens.WHLE, Tokens.WKLAY)
                whaleKlayLp = await ethers.getContractAt("IERC20", lpAddress)
            }

            it('removeLiquidity', async () => {
                await loadFixture(initTestAfterAddLiquidity)

                const liquidity = await whaleFishLp.balanceOf(tester.address)
                await whaleFishLp.approve(trader.address, liquidity)
                
                // estimation
                const estWhale = (await whale.balanceOf(whaleFishLp.address)).mul(liquidity).div(await whaleFishLp.totalSupply())
                const estFish = (await fish.balanceOf(whaleFishLp.address)).mul(liquidity).div(await whaleFishLp.totalSupply())
                
                const beforeWhale = await whale.balanceOf(tester.address)
                const beforeFish = await fish.balanceOf(tester.address)
                await trader.removeLiquidity(whale.address, fish.address, liquidity)

                const afterWhale = await whale.balanceOf(tester.address)
                const afterFish = await fish.balanceOf(tester.address)

                assertEqual(afterWhale.sub(beforeWhale), estWhale)
                assertEqual(afterFish.sub(beforeFish), estFish)
                assertEqual(await whaleFishLp.balanceOf(tester.address), BigNumber.from(0))
            })
            it('removeLiquidityKlay', async () => {
                await loadFixture(initTestAfterAddLiquidity)
                const liquidity = await whaleKlayLp.balanceOf(tester.address)
                await whaleKlayLp.approve(trader.address, liquidity)
                
                // estimation
                const estWhale = (await whale.balanceOf(whaleKlayLp.address)).mul(liquidity).div(await whaleKlayLp.totalSupply())
                const estKlay = (await wklay.balanceOf(whaleKlayLp.address)).mul(liquidity).div(await whaleKlayLp.totalSupply())

                const beforeWhale = await whale.balanceOf(tester.address)
                const beforeKlay = await ethers.provider.getBalance(tester.address)
                const tx = await trader.removeLiquidityKlay(whale.address, liquidity)
                const receipt = await tx.wait()
                const gasFee = tx.gasPrice.mul(receipt.gasUsed)

                const afterWhale = await whale.balanceOf(tester.address)
                const afterKlay = await ethers.provider.getBalance(tester.address)

                assertEqual(afterWhale.sub(beforeWhale), estWhale)
                assertEqual(afterKlay.sub(beforeKlay).add(gasFee), estKlay)
                assertEqual(await whaleKlayLp.balanceOf(tester.address), BigNumber.from(0))
            })

            describe('tokenSwap', async () => {
                beforeEach(async () => {
                    await loadFixture(initTestAfterAddLiquidity)
                })
                it('swapExactTokenToToken (10 WHLE -> ?? FISH)', async () => {
                    const amountIn = toEther(10)
                    const path = [whale.address, fish.address]
                    
                    // estimate
                    const amountsOut = await router.getAmountsOut(amountIn, path)
                    const estFish = amountsOut[amountsOut.length - 1]

                    await whale.approve(trader.address, amountIn)

                    const beforeWhale = await whale.balanceOf(tester.address)
                    const beforeFish = await fish.balanceOf(tester.address)
                    await trader.swapExactTokenToToken(amountIn, path)
                    const afterWhale = await whale.balanceOf(tester.address)
                    const afterFish = await fish.balanceOf(tester.address)

                    assertEqual(beforeWhale.sub(afterWhale), amountIn)
                    assertEqual(afterFish.sub(beforeFish), estFish)
                    mlog.log(`10 WHLE = ${fromEther(estFish)} FISH`)
                })
                it('swapTokenToExactToken (?? WHLE -> 100 FISH)', async () => {
                    const amountOut = toEther(100)
                    const path = [whale.address, fish.address]
                    
                    // estimate
                    const amountsIn = await router.getAmountsIn(amountOut, path)
                    const estAmountIn = amountsIn[0]

                    await whale.approve(trader.address, estAmountIn)

                    const beforeWhale = await whale.balanceOf(tester.address)
                    const beforeFish = await fish.balanceOf(tester.address)
                    await trader.swapTokenToExactToken(amountOut, estAmountIn, path)
                    const afterWhale = await whale.balanceOf(tester.address)
                    const afterFish = await fish.balanceOf(tester.address)

                    assertEqual(beforeWhale.sub(afterWhale), estAmountIn)
                    assertEqual(afterFish.sub(beforeFish), amountOut)
                    mlog.log(`${fromEther(estAmountIn)} WHLE = 100 FISH`)
                })
                it('swapExactKlayToToken (10 KLAY -> ?? FISH)', async () => {
                    const amountIn = toEther(10)
                    const path = [wklay.address, whale.address, fish.address]
                    
                    // estimate
                    const amountsOut = await router.getAmountsOut(amountIn, path)
                    const estFish = amountsOut[amountsOut.length - 1]

                    const beforeKlay = await ethers.provider.getBalance(tester.address)
                    const beforeFish = await fish.balanceOf(tester.address)
                    const tx = await trader.swapExactKlayToToken(path, {value: amountIn})
                    const receipt = await tx.wait()
                    const gasFee = tx.gasPrice.mul(receipt.gasUsed)

                    const afterKlay = await ethers.provider.getBalance(tester.address)
                    const afterFish = await fish.balanceOf(tester.address)

                    assertEqual(beforeKlay.sub(afterKlay).sub(gasFee), amountIn)
                    assertEqual(afterFish.sub(beforeFish), estFish)
                    mlog.log(`10 KLAY = ${fromEther(estFish)} FISH`)
                })
                it('swapKlayToExactToken (?? KLAY -> 100 FISH)', async () => {
                    const amountOut = toEther(100)
                    const path = [wklay.address, whale.address, fish.address]
                    
                    // estimate
                    const amountsIn = await router.getAmountsIn(amountOut, path)
                    const estAmountIn = amountsIn[0]

                    const beforeKlay = await ethers.provider.getBalance(tester.address)
                    const beforeFish = await fish.balanceOf(tester.address)
                    const tx = await trader.swapKlayToExactToken(amountOut, path, {value: estAmountIn})
                    const receipt = await tx.wait()
                    const gasFee = tx.gasPrice.mul(receipt.gasUsed)

                    const afterKlay = await ethers.provider.getBalance(tester.address)
                    const afterFish = await fish.balanceOf(tester.address)

                    assertEqual(beforeKlay.sub(afterKlay).sub(gasFee), estAmountIn)
                    assertEqual(afterFish.sub(beforeFish), amountOut)
                    mlog.log(`${fromEther(estAmountIn)} KLAY = 100 FISH`)
                })
            })
        })
    })

    describe('Farm', async () => {
        beforeEach(async () => {
            await loadFixture(initTest)
            const amountInWhale = toEther(500)
            const amountInFish = toEther(50000)
            const amountInKLAY = toEther(1000)
            
            // approve
            await whale.approve(trader.address, MAX_UINT)
            await fish.approve(trader.address, MAX_UINT)
            
            // add liquidity
            await trader.addLiquidity(whale.address, fish.address, amountInWhale, amountInFish)
            await trader.addLiquidityKlay(whale.address, amountInWhale, {value: amountInKLAY})

            let lpAddress = await factory.getPair(Tokens.WHLE, Tokens.FISH)
            whaleFishLp = await ethers.getContractAt("IERC20", lpAddress)
            
            lpAddress = await factory.getPair(Tokens.WHLE, Tokens.WKLAY)
            whaleKlayLp = await ethers.getContractAt("IERC20", lpAddress)

            // show LP balance & pid
            for (let lp of [whaleKlayLp, whaleFishLp]) {
                const balance = await lp.balanceOf(tester.address)
                const pid = await chef.getPid(lp.address)
                
                mlog.log(`pid    : ${pid}`)
                mlog.log(`balance: ${fromEther(balance)}`)
                mlog.log(`------------------------------\n`)
            }
        })
        it('deposit LP', async () => {
            const amount = await whaleFishLp.balanceOf(tester.address)
            
            await whaleFishLp.connect(tester).approve(trader.address, MAX_UINT)
            await trader.connect(tester).deposit(1, amount)

            const depositBalance = await trader.depositBalance(1)
            assertEqual(depositBalance, amount)
        })
        describe.only('after deposit', async () => {
            beforeEach(async () => {
                const amount = await whaleKlayLp.balanceOf(tester.address)
            
                await whaleKlayLp.connect(tester).approve(trader.address, MAX_UINT)
                await trader.connect(tester).deposit(1, amount)
    
                const depositBalance = await trader.depositBalance(1)
                assertEqual(depositBalance, amount)
            })
            it('withdraw LP', async () => {
                const depositBalance = await trader.depositBalance(1)
                const withdrawAmount = depositBalance.div(2)
                
                const beforeBalance = await whaleKlayLp.balanceOf(tester.address)
                await trader.connect(tester).withdraw(1, withdrawAmount)
                const afterBalance = await whaleKlayLp.balanceOf(tester.address)
                assertEqual(afterBalance.sub(beforeBalance), withdrawAmount)
            })
            it('farming', async () => {
                // fastforward block
                const blocks = 100
                await mineBlock(blocks)

                const pending = await trader.pendingRewardAll()
                
                const beforeWhale = await whale.balanceOf(tester.address)
                await trader.connect(tester).claimReward()
                const afterWhale = await whale.balanceOf(tester.address)
                
                mlog.log(`pending: ${fromEther(pending)} WHLE`)
                mlog.log(`claimed: ${fromEther(afterWhale.sub(beforeWhale))} WHLE`)
                assertClose(afterWhale.sub(beforeWhale), pending.mul(blocks + 1).div(blocks), 1e10.toString())   
            })
        })
    })
})