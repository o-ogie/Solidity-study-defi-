// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Lottery {
    struct BetInfo{
        uint256 answerBlockNumber;
        address payable better;
        bytes challenges;
    }

    uint256 private _tail;
    uint256 private _head;
    mapping (uint256 => BetInfo) private _bets;

    address public owner;

    uint256 constant internal BLOCK_LIMIT = 256;
    uint256 constant internal BET_BLOCK_INTERVAL = 3;
    uint256 constant internal BET_AMOUNT = 5 * 10 ** 15;
    uint256 private _pot;

    event BET(uint256 index, address better, uint256 amount, bytes challenges, uint256 answerBLockNumber);
    constructor() public {
        owner = msg.sender;
    } 

    function getPot() public view returns(uint256 value) {
        return _pot;
    }

    // BET
    /**
     * @dev 배팅을 한다. 유저는 0.005 ETH를 보내야하고, 배팅용 1byte 글자를 보낸다.
     * 큐에 지정된 정본느 이 후 distribute 함수에서 해결된다. 
     * @param challenges 유저가 베팅하는 글자
     ** @return 함수가 제대로 수행되었는지 확인해주는
     */
    function bet(bytes memory challenges) public payable returns(bool result) {
        // check the proper ether is sent
        require(msg.value == BET_AMOUNT, "Not enough ETH");

        //push bet to the queue
        require(pushBet(challenges),"Fail to add a new Bet Info");

        // emit event
        emit BET(_tail -1, msg.sender, msg.value, challenges, block.number + BET_BLOCK_INTERVAL);
        return true;
    }
        // save the bet to the queue

    // Distribute
        // check the answer
        

    function getBetInfo(uint256 index) public view returns (uint256 answerBlockNumber, address better, bytes memory challenges){
        BetInfo memory b = _bets[index];
        answerBlockNumber = b.answerBlockNumber;
        better = b.better;
        challenges = b.challenges;
    }

    function pushBet(bytes memory challenges) public returns(bool){
        BetInfo memory b;
        b.better = payable(msg.sender);
        b.answerBlockNumber = block.number + BET_BLOCK_INTERVAL; 
        b.challenges = challenges;

        _bets[_tail] = b;
        _tail++;

        return true;
    }

    function popBet(uint256 index) public returns (bool) {
        delete _bets[index];
        return true;
    }
}