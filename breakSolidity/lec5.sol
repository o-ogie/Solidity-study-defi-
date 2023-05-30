// SPDX-License-Identifier: MIT
pragma solidity >= 0.7.0 < 0.9.0;

contract Hello {
    /*
    public: 모든 곳에서 접근이 가능하다.
    external: public처럼 모든 곳에서 접근 가능하나, external이 정의된 자기 자신 컨트랙 내에서 접근 불가
    private: 오직 private이 정의된 자기 컨트랙에서만 가능 ( Private이 정의된 컨트랙을 상속 받은 자식도 접근 불가능 )
    internal: Private 처럼 오직 internal이 정의된 자기 컨트랙트에서만 가능하고, internal이 정의된 컨트랙트를 상속 받은 자식까지는 접근이 가능함.
    */

    //1. public
    uint256 public a = 5;

    //2. private
    uint256 private a2 = 3; // 배포를 해보면 접근이 불가능하다.

}

contract Public_example {
    uint256 public a = 3;

    function changeA(uint256 _value) public {
        a = _value;
    }

    function get_a() view external returns (uint256) {
        return a;
    }
}

contract Public_example_2 {
    Public_example instance = new Public_example();

    function changeA_2(uint256 _value) public {
        instance.changeA(_value);
    }

    function use_public_example_a() view public returns(uint256) {
        return instance.get_a();
    }
}

