// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Anthromancer is ERC721URIStorage, ERC721Enumerable, Ownable {
    
    uint256 public tokenCounter = 0;    
    uint256 public mintPrice = 0;
    uint256 public totalAllowed = 11655;
    uint256 public blockInterval = 6500;
    
      constructor() ERC721("Anthromancer", "HYMN")
    {   //Intitalize Hymn Struct w/all info here in contructor
     
        idToHymn[0] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + blockInterval,
            "IPFS ADDRESS"
      );
       
       idToHymn[1] = Hymn(
            2,
            "Hymn 02",
            778,
            1554,
            block.number + blockInterval + 1,
            block.number + (blockInterval* 2),
            "IPFS ADDRESS"
      );
       idToHymn[2] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number + ((blockInterval * 2) + 1),
            block.number + (blockInterval * 3),
            "IPFS ADDRESS"
      );

        idToHymn[3] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

             idToHymn[4] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

             idToHymn[5] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

             idToHymn[6] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

             idToHymn[7] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

             idToHymn[8] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

             idToHymn[9] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

             idToHymn[10] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

        idToHymn[11] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

        idToHymn[12] = Hymn(
            1,
            "Hymn 01",
            0,
            777,
            block.number,
            block.number + 4480,
            "IPFS ADDRESS"
      );

       
    }

   struct Hymn {
        uint256 _hymnId;
        string _hymnName;
        uint256 _tokenStart;
        uint256 _tokenEnd;
        uint256 _blockStart;
        uint256 _blockEnd;
        string _ipfsAddress;
    } mapping(uint256 => Hymn) public idToHymn;

    uint256 public currentHymnId = 0;
    uint256 public currentHmynRange = block.number;
    uint256 public currentHmynStart = 0;

    //Main Mint Function
    function mintHmyn()payable public {
    
      
      require(tokenCounter < totalAllowed);
      require(msg.value == mintPrice);

      if (block.number > currentHmynStart){
       _safeMint(msg.sender, tokenCounter);
       _setTokenURI(tokenCounter, "tempURI");    
   
     
       tokenCounter = tokenCounter + 1;
      }

      if (tokenCounter >= 777){
          currentHmynStart = 7;
      }
      
        
     
    }
 
    //Backup Mint Function to mint Hmyns whose block range has passed and which were not minted out in that time
    function mintHmynBackup()payable public {
    
      
      require(tokenCounter < totalAllowed);
      require(msg.value == mintPrice);

      if (block.number > currentHmynStart){
       _safeMint(msg.sender, tokenCounter);
       _setTokenURI(tokenCounter, "tempURI");    
   
     
       tokenCounter = tokenCounter + 1;
      }

      if (tokenCounter >= 777){
          currentHmynStart = 7;
      }
      
        
     
    }
 
 
 
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
     {
        super._beforeTokenTransfer(from, to, tokenId);
     }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
     }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
     {
        return super.tokenURI(tokenId);
     }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
     {
        return super.supportsInterface(interfaceId);
     }



}
