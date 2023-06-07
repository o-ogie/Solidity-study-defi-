// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Father {
    string public familyName = "Lee";
    string public givenName = "SeWook";
    uint256 public money = 100;

    constructor(string memory _givenName) public {
        givenName = _givenName; // SeWook이라는 값은 들어가지 않는다. 배포 후 컨트랙트에는 값이 없음.
    }

    function getFamilyName() view public returns(string memory){
        return familyName;
    }

    function getGivenName() view public returns(string memory) {
        return givenName;
    }

    function getMoney() view virtual public returns(uint256){
        return money;
    }
}

contract Son is Father{

    constructor() Father("James"){}
    
    uint256 public earning = 0;
    function work() public {
        earning += 100;
    }

    function getMoney() view public override returns(uint256) {
        return money + earning;
    }
}

/*
상속의 형태는

contract son is Father(args){}

or

contract son {
    constructor() Father(args){}
}
 */