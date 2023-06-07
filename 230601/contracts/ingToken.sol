// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "../node_modules/@openzeppelin/contracts/access/Ownable.sol";
import "../node_modules/@openzeppelin/contracts/utils/Strings.sol";

contract IngToken is ERC721Enumerable, Ownable{

    uint256 public result =1;
    uint256 public mint_price = 1 ether;
    uint256 constant public MAX_TOKEN_COUNT = 100;
    mapping(uint256 => string) metadatas;
    constructor(string memory _name, string memory _symbol) ERC721(_name, _symbol){}
    // constructor() ERC721("ingNFT","INT"){}   

    struct TokenData {
        uint256 Rank;
        uint256 Type;
    }

    mapping(uint256 => TokenData) public tokenDatas;
    /*
        {
            1 : {
                Rank:1,
                Type:2
            },
        }
    */

    function _minting() public payable {
        require(msg.value >= mint_price);
        require(MAX_TOKEN_COUNT > totalSupply());

        uint256 tokenId = totalSupply() + 1;

        TokenData memory data = getRandomNum(msg.sender, tokenId);
        tokenDatas[tokenId] = data;

        payable(Ownable.owner()).transfer(msg.value);
        _mint(msg.sender, tokenId);
    }

    function tokenURI(uint256 _tokenId) public view override returns(string memory) {
        // return metadatas[_tokenId];

        string memory Rank = Strings.toString(tokenDatas[_tokenId].Rank);
        string memory Type = Strings.toString(tokenDatas[_tokenId].Type);

        return string(abi.encodePacked("https://gateway.pinata.cloud/ipfs/QmPwjnvWYN4etA5eW4yAbWCTy2ukEC1Jj5417VLGyH5XpU/",Rank,"/",Type,".json"));
    }

    function getRandomNum(address _msgSender, uint256 tokenId) private pure returns(TokenData memory){
        TokenData memory data;
        // keccak256
        // msg.sender + tokenId
        uint256 randomNum = uint(keccak256(abi.encodePacked(_msgSender, tokenId)))%100; // 뒷 두글자
        // 0~99까지 유사 랜덤 수를 만들고.
        // 0~24 Rank1
        // 25~49 Rank2
        // 50~74 Rank3
        // 75~99 Rank4
        // Type은 수를 4로 나눈 나머지 값으로 0은 1, 1은 2, 2는 3, 3은 4로 하던지...

        if (randomNum < 5) {
            if (randomNum == 1) {
                data.Rank = 4;
                data.Type = 1;
            } else if (randomNum == 2) {
                data.Rank = 4;
                data.Type = 2;
            } else if (randomNum == 3) {
                data.Rank = 4;
                data.Type = 3;
            } else {
                data.Rank = 4;
                data.Type = 4;
            }
        } else if (randomNum < 13) {
            if (randomNum < 7) {
                data.Rank = 3;
                data.Type = 1;
            } else if (randomNum < 9) {
                data.Rank = 3;
                data.Type = 2;
            } else if (randomNum < 11) {
                data.Rank = 3;
                data.Type = 3;
            } else {
                data.Rank = 3;
                data.Type = 4;
            }
        } else if (randomNum < 37) {
            if (randomNum < 19) {
                data.Rank = 2;
                data.Type = 1;
            } else if (randomNum < 25) {
                data.Rank = 2;
                data.Type = 2;
            } else if (randomNum < 31) {
                data.Rank = 2;
                data.Type = 3;
            } else {
                data.Rank = 2;
                data.Type = 4;
            }
        } else {
            if (randomNum < 52) {
                data.Rank = 1;
                data.Type = 1;
            } else if (randomNum < 68) {
                data.Rank = 1;
                data.Type = 2;
            } else if (randomNum < 84) {
                data.Rank = 1;
                data.Type = 3;
            } else {
                data.Rank = 1;
                data.Type = 4;
            }
        }
        
        /*  같은 확률일때
            data.Rank = randomNum // 25;
            data.Type = randomNum % 4;
        */
        return data; 
    }


}

/**
solidity는 데이터를 저장할때 storage라는 공간에 저장한다.
function a(uint256 i) public {}
i를 저장할때 storage에 저장할지 메모리에 저장할지 지정할 수 있는데
storage에 저장하면 비용이 많이 든다.
가능한 memory에 저장해도 되는건 memory에 저장하는게 좋다.
 */