// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


contract Father {
    event FatherName(string name);

    function who() public virtual{
        emit FatherName("LeeSang");
    }
}

contract Mother {
    event MotherName(string name);
    function who() public virtual{
        emit MotherName("Kimhyun");
    }
}

contract Son is Father, Mother {

    function who() public override(Father, Mother){
        super.who();
    } // log에는 MotherName의 데이터가 담겨있다. 상속의 순서때문. 상속의 가장 오른쪽(최신)이 덮는다고 생각하면 된다.
}