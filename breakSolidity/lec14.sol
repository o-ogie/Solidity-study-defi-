// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract lec14 {
    event numberTracker(uint256 num, string str);
    event numberTracker2(uint256 indexed num, string str);

    uint256 num = 0;

    function PushEvent(string memory _str) public {
        emit numberTracker(num, _str);
        emit numberTracker2(num, _str);
        num++;
    }

}

/*
indexed
- event의 키워드이다. event내에서만 사용할 수 있는 키워드
언제 사용되냐
특정한 이벤트의 값들을 불러올때 사용한다.
500개의 이벤트를 가정할때 SW라는 이벤트만 필요할때 사용한다.

 */