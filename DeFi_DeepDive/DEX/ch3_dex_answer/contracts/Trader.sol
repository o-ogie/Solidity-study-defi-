// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./interfaces/IERC20.sol";
import "./interfaces/IUniswapV2Router02.sol";
import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IMasterChef.sol";
import "hardhat/console.sol";

contract Trader {
    // contracts
    address constant FACTORY = 0x90B06a1B5920E45c5f0aC3D701728669527bF275;
    address constant ROUTER = 0x0D827eaDe12e5f296e3Dd0e08fc38ad990dC1142;
    address constant CHEF = 0x5bc059C6fAC255702Ea697415f82e44c5ec3CB76;

    // tokens
    address constant WKLAY = 0x043c471bEe060e00A56CcD02c0Ca286808a5A436;
    address constant WHLE = 0x15308179057A1d5e56C61a612b1EADfA5F669Aad;
    
    constructor() {}

    receive () external payable {}

    // ------------- VIEW ------------- 

    function pendingReward(uint pid) external view returns (uint) {
        return IMasterChef(CHEF).pendingwhale(pid, address(this));
    }

    function pendingRewardAll() external view returns (uint) {
        uint poolLength = IMasterChef(CHEF).poolLength();
        uint reward;
        for (uint i = 1; i < poolLength; i++) {
            reward += IMasterChef(CHEF).pendingwhale(i, address(this));
        }
        return reward;
    }

    function depositBalance(uint pid) external view returns (uint) {
        return IMasterChef(CHEF).userInfo(pid, address(this)).amount;
    }

    // ------------- LIQUIDITY ------------- 

    function addLiquidityKlay(address token, uint amountDesired) payable external {
        IERC20(token).transferFrom(msg.sender, address(this), amountDesired);

        IERC20(token).approve(ROUTER, type(uint).max);
        IUniswapV2Router01(ROUTER).addLiquidityETH{value: msg.value}(token, amountDesired, 0, 0, msg.sender, block.timestamp + 10);
    }

    function addLiquidity(address tokenA, address tokenB, uint amountA, uint amountB) external {
        // 유저로부터 토큰을 전달 받는다. msg.sender-유저, address(this) 현재 CA
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountA);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountB);

        // Approve
        // IERC20(tokenA).approve(ROUTER, amountA);
        // IERC20(tokenB).approve(ROUTER, amountB);
        approveToken(tokenA, ROUTER);
        approveToken(tokenB, ROUTER);

        // addLiquidity
        IUniswapV2Router01(ROUTER).addLiquidity(tokenA, tokenB, amountA, amountB, 0, 0, msg.sender, block.timestamp + 10);
        // Router에 addLiquidity 함수를 실행하게 되면 Router는 amountA, amountB만큼 토큰을 가져가게 된다.
        // 현재 컨트랙트에서 Router가 토큰을 마음대로 가져가면 안되기 때문에 Approve를 해주어야 한다.
    }

    function removeLiquidity(address tokenA, address tokenB, uint liquidity) external {
        // 해제하고자 하는 풀에 있는 두 토큰의 address, LPtoken의 수량 liquidity
        address lp = IUniswapV2Factory(FACTORY).getPair(tokenA, tokenB);// tokenA, tokenB가 있는 pool address
        IERC20(lp).transferFrom(msg.sender, address(this), liquidity);

        approveToken(lp, ROUTER);
        IUniswapV2Router01(ROUTER).removeLiquidity(tokenA, tokenB, liquidity, 0, 0, msg.sender, block.timestamp + 10);
    }

    function removeLiquidityKlay(address token, uint liquidity) external {
        address lp = IUniswapV2Factory(FACTORY).getPair(token, WKLAY);
        IERC20(lp).transferFrom(msg.sender, address(this), liquidity);

        approveToken(lp, ROUTER);
        IUniswapV2Router01(ROUTER).removeLiquidityETH(token, liquidity, 0, 0, msg.sender, block.timestamp + 10);
    }

    // ------------- SWAP ------------- 

    function swapExactTokenToToken(uint amountIn, address[] calldata path) external { // 주는 토큰에 대한 스왑함수
        // [A-B-C..] A토큰이 스왑할 토큰이기 때문에 path의 첫째 값이 inputToken이 된다.
        address inputToken = path[0];

        // transferFrom으로 inputToken을 받아온다.
        IERC20(inputToken).transferFrom(msg.sender, address(this), amountIn);

        approveToken(inputToken, ROUTER);

        // Swap
        IUniswapV2Router01(ROUTER).swapExactTokensForTokens(amountIn, 0, path, msg.sender, block.timestamp + 10);
    }

    function swapTokenToExactToken(uint amountOut, uint amountInMax, address[] calldata path) external { // 돌려받는 토큰에 대한 스왑 함수.
        uint[] memory amountsIn = IUniswapV2Router01(ROUTER).getAmountsIn(amountOut, path);
        uint amountIn = amountsIn[0];
        require(amountInMax >= amountIn, "exceed amountInMax");

        address inputToken = path[0];

        IERC20(inputToken).transferFrom(msg.sender, address(this), amountIn);

        approveToken(inputToken, ROUTER);
        IUniswapV2Router01(ROUTER).swapTokensForExactTokens(amountOut, amountIn, path, msg.sender, block.timestamp + 10);
    }

    function swapExactKlayToToken(address[] calldata path) payable external {
        require(path[0] == WKLAY, "invalid path");
        require(msg.value > 0, "zero msg.value");
        IUniswapV2Router01(ROUTER).swapExactETHForTokens{value: msg.value}(0, path, msg.sender, block.timestamp + 10);
    }

    function swapKlayToExactToken(uint amountOut, address[] calldata path) payable external {
        require(path[0] == WKLAY, "invalid path");
        require(msg.value > 0, "zero msg.value");
        uint[] memory amountsIn = IUniswapV2Router01(ROUTER).getAmountsIn(amountOut, path);
        IUniswapV2Router01(ROUTER).swapETHForExactTokens{value: amountsIn[0]}(amountOut, path, msg.sender, block.timestamp + 10);

        // return remaining KLAY
        if (msg.value > amountsIn[0]){
            (bool success,) = (msg.sender).call{value: msg.value - amountsIn[0]}(new bytes(0));
            require(success, "fail to trasfer KLAY");
        }
    }


    // ------------- FARM ------------- 

    function deposit(uint pid, uint amount) external {
        IMasterChef.PoolInfo memory poolInfo = IMasterChef(CHEF).poolInfo(pid);
        require(address(poolInfo.lpToken) != address(0), "invalid pid");

        poolInfo.lpToken.transferFrom(msg.sender, address(this), amount);
        approveToken(address(poolInfo.lpToken), CHEF);

        IMasterChef(CHEF).deposit(pid, amount);
    }

    function withdraw(uint pid, uint amount) external {
        IMasterChef.PoolInfo memory poolInfo = IMasterChef(CHEF).poolInfo(pid);
        require(address(poolInfo.lpToken) != address(0), "invalid pid");


        IMasterChef(CHEF).withdraw(pid, amount);
        poolInfo.lpToken.transfer(msg.sender, amount);
    }

    function harvest() public {
        uint poolLength = IMasterChef(CHEF).poolLength();
        for (uint i = 1; i < poolLength; i++) {
            IMasterChef(CHEF).deposit(i, 0);
        }
    }

    function claimReward() external {
        harvest();
        uint reward = IERC20(WHLE).balanceOf(address(this));
        if (reward > 0) {
            IERC20(WHLE).transfer(msg.sender, reward);
        }
    }

    // ------------- UTILS ------------- 

    function approveToken(address token, address spender) private {
        if (IERC20(token).allowance(address(this), spender) == 0) {
            IERC20(token).approve(spender, type(uint).max);
        }
    }
}