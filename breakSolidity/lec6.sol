// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract lec6 {

    /*
    view : function 밖의 변수들을 읽을 수 있으나 변경 불가능
    pure : function 밖의 변수들을 읽지 못하고, 변경도 불가능
    view와 pure 둘다 명시 안할 때 : function 밖의 변수들을 읽어서, 변경을 해야함.
    */

    // view
    uint256 public a = 1;
    function read_a() public view returns(uint256){

        return a;
        // a += 1하면 오류 발생. 수정코드 작성이 안됨.
    }

    // pure
    function read_a2() public pure returns(uint256){
        uint256 b = 1;
        return 4+2+b;
    }

    // view, pure x
    function read_a3() public returns(uint256){
        a = 13;
        return a;
    }
}


