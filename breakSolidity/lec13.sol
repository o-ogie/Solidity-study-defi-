// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract lec13 {

    event info(string name, uint256 money);

    function sendMoney() public {
        emit info("LeeSeWook", 1000);
    }

}
/*
log:[
	{
		"from": "0xd9145CCE52D386f254917e481eB44e9943F39138",
		"topic": "0x473e81062e4ff21e1cd2c2ceaa6b79bd5885f00eb22d9a844ce9fd9685f22ac7",
		"event": "info",
		"args": {
			"0": "LeeSeWook",
			"1": "1000",
			"name": "LeeSeWook",
			"money": "1000"
		}
	}
]
블럭안에 위와 같은 값들이 저장이 된다.
 */

/*
solidity에는 print가 없다. 이를 event로 가능한데
event로 값들을 출력할때 값들이 블럭 안에 저장이 된다.
따라서 언제든지 블럭에서 값을 꺼내서 사용할 수 있다.

event eventName( args value );

*/