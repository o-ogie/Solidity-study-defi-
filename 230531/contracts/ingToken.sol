// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract IngToken is ERC20 {

    constructor() ERC20("ingToken","ITK") {
        _mint(msg.sender, 1000 * (10 ** 18));
    }
}

// 스왑 컨트랙트
// 1ETH <--> 100ITK