// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Father {
    event FatherName(string name);

    function who() public virtual{
        emit FatherName("LeeSang");
    }
}

contract Son is Father {
    event sonName(string name);

    function who() public override {
        // emit FatherName("LeeSang");
        super.who();// 위 코드와 같음
        emit sonName("LeeSe");
    }
}