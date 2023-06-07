// Array, mapping의 주의할 점.
// SPDX-License-Identifier:GPL-30
pragma solidity >= 0.7.0 < 0.9.0;

contract lec19{
   uint256 num = 89;
   mapping(uint256 => uint256) numMap;
   uint256[] numArray;
   
   function changeNum(uint256 _num) public{
       num = _num;
   }
   function showNum() public view returns(uint256){
      return num;
   }
   
   function numMapAdd() public{
       numMap[0] = num;
   }
   function showNumMap() public view returns(uint256){
       return numMap[0];
   }
   function UpdateMap() public{
       numMap[0] = num;
   }
   
   function numArrayAdd() public{
       numArray.push(num);
   }
   function showNumArray() public view returns(uint256){
       return numArray[0];
   }
   function updateArray() public {
       numArray[0] = num;
   }
   
}

/*
mapping과 Array는
값을 reference타입으로 저장하는게 아니라
캡쳐 형식으로 값만 저장한다.
저장하기 위해서는 따로 처리를 해줘야한다.
*/