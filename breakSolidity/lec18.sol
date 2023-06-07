// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;
 
contract lec18{
    
    
    uint256[] public ageArray;
    uint256[10] public ageFixedSizeArray;
    string[] public nameArray= ["Kal","Jhon","Kerri"]; // 배열의 값을 미리 정의를 할 수 있다.
  
    function AgeLength()public view returns(uint256) {
        return ageArray.length;
    }
    
    function AgePush(uint256 _age)public{
        ageArray.push(_age);
    }
    function AgeChange(uint256 _index, uint256 _age)public{
        ageArray[_index] = _age;
    }
    function AgeGet(uint256 _index)public view returns(uint256){
        return ageArray[_index];
    }
    function AgePop()public {
        ageArray.pop();
    }
    
    function AgePop(uint256 _index)public {
        delete ageArray[_index];
    }


}
/*
Array에서는 length가 존재한다.
mapping에서는 존재하지 않음. 하지만 solidity에서는 mapping을 더 선호하고 권장하고 있음.
그 이유는 array의 좋은 점은 값들의 순환인데, 오히려 이게 문제가 될 수 있다는 것이다.
=> Ddos 공격에 취약함.

삭제하는 법
- delete
- pop

pop
- 가장 최신의 값을 삭제한다.(마지막 배열)

delete
- 선택한 인덱스의 value를 지울 수 있지만 메모리가 지워지는게 아니라 0으로 채워진다.
=> 배열의 길이는 그대로이다.
 */