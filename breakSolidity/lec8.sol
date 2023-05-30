// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract A {
    uint256 public a = 5;

    function change(uint256 _value) public {
        a = _value;
    }
}

contract B {
    A instance = new A();

    function get_A() public view returns(uint256){
        return instance.a();
    }

    function change_A(uint256 _value) public {
        instance.change(_value);
    }
}

// 인스턴스를 쓰는 이유는 하나의 컨트랙트에서 다른 컨트랙트에 접근하기 위해 사용한다.
