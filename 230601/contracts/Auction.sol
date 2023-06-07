// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";


contract Auction{
    ERC721 public NFT;

    struct TokenInfo {
        uint256 tokenId;
        uint256 price;
        string tokenURI;
    }

    mapping(uint256 => uint256) public tokenPrices;
    uint256[] public SaleTokenList; // 판매중인 토큰


    constructor(ERC721 _NFT) {
        NFT = _NFT;
    }

    function salesToken(uint256 _tokenId, uint256 _price) public {
        address tokenOwner = NFT.ownerOf(_tokenId); // return : address 내가 판매하려고 하는 tokenId adress값을 반환해준다.

        require(tokenOwner == msg.sender);
        require(_price > 0);
        require(tokenPrices[_tokenId]!=0);
        require(NFT.isApprovedForAll(msg.sender, address(this)));

        tokenPrices[_tokenId] = _price;
        SaleTokenList.push(_tokenId);
    }

    function purchaseToken(uint256 _tokenId) public payable {
        address tokenOwner = NFT.ownerOf(_tokenId);

        require(tokenOwner != msg.sender);
        require(tokenPrices[_tokenId] == msg.value);

       payable(tokenOwner).transfer(msg.value);
       NFT.transferFrom(tokenOwner, msg.sender, _tokenId);

       tokenPrices[_tokenId] = 0;

    }

    function popSaleToken(uint256 _tokenId) private returns(bool){
        for(uint256 i = 0; i<SaleTokenList.length; i++){
            if(SaleTokenList[i] == _tokenId){
                SaleTokenList[i] = SaleTokenList[SaleTokenList.length-1];
                SaleTokenList.pop();
            }
        }

        return true;
    }
}