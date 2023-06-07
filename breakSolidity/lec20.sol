// struc 구조체

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract lec20{
    struct Character{
        uint256 age;
        string name;
        string job;
    }
    
    mapping(uint256=>Character) public CharacterMapping;
    Character[] public CharacterArray;
    
    function createCharacter(uint256 _age,string memory _name,string memory _job) pure public returns(Character memory) {
        return Character(_age,_name,_job);
    }
    
    function createChracterMapping(uint256 _key, uint256 _age,string memory _name,string memory _job )  public returns(Character memory) {
       CharacterMapping[_key] = Character(_age,_name,_job);
    // test:   Character memory charStruct = Character(27, "testName", "baeksoo");
    //    return charStruct;
    }
    
    function getChracterMapping(uint256 _key)  public view returns(Character memory){
       return CharacterMapping[_key];
    }
    
    function createChracterArray(uint256 _age,string memory _name,string memory _job ) public {
       CharacterArray.push(Character(_age,_name,_job));
    }
    
    function getChracterArray(uint256 _index)  public view returns(Character memory){
       return CharacterArray[_index];
    }
}

/*
타입 생성과 비슷하다.

Character 형식의 데이터를 만드려면
위에 struct로 정의한 고조와 같아야한다.
Character(age, name, job)처럼
구조체에 순서대로 값을 넣을 수 있다.
*/