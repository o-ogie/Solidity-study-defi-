# NFT

ERC721
IERC721_Metadata
IERC721
ERC721Enumerable


ERC721a


ERC721
표준 이벤트는 3가지가 있다.
ERC20과 다른 점은
Approval
- Token하나를 위임

ApprovalForAll
- 가지고 있는 모든 Token을 위임.


ERC20
A -> B 위임

ERC721
민팅을 통해 1~10.. tokenId가 증가하는 형태

A 1,2
B 3,4
C 5,6,7,8,9
마켓

A -> 마켓 -> B

NFT 트랜잭션은 객체의 값을 옮겨야 하는 귀찮은 과정이다.
IERC721Enumberable
- 많이 사용되는 메서드들을 모아 놓은 것이다.
                                                                                                                                                        
C의 어드레느 내용으로 토큰의 갯수를 구할 수 있나?
=> balanceOf

ex)
```js
for(let i =0; i<balanceOf(Address c); i++){
    const tokenId = tokenOfOwnerByIndex(Ardress C, i)
    // C라는 어드레스에 있는 모든 tokenId를 구할 수 있다.
}
```

# NFT market
