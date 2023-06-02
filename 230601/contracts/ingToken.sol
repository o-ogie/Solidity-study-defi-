// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract IngToken is ERC721{

    uint256 public result =1;
    mapping(uint256 => string) metadatas;
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){}
    // constructor() ERC721("ingNFT","INT"){}   

    function _minting(uint256 _tokenId) public {
        _mint(msg.sender, _tokenId);
    }

    function tokenURI(uint256 _tokenId) public pure override returns(string memory) {
        // return metadatas[_tokenId];
        return "https://gateway.pinata.cloud/ipfs/QmPwjnvWYN4etA5eW4yAbWCTy2ukEC1Jj5417VLGyH5XpU/1/1.json";
    }

}

/**
solidity는 데이터를 저장할때 storage라는 공간에 저장한다.
function a(uint256 i) public {}
i를 저장할때 storage에 저장할지 메모리에 저장할지 지정할 수 있는데
storage에 저장하면 비용이 많이 든다.
가능한 memory에 저장해도 되는건 memory에 저장하는게 좋다.
 */