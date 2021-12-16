// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Anthromancer is ERC721URIStorage, ERC721Enumerable, Ownable {
    
    uint256 public tokenCounter = 0;    
    uint256 public mintPrice = 0; //Set to 0 for testing
    uint256 public totalAllowed = 11655; //777*13
    uint256 public blockInterval = 6500; //About 6500 Blocks in a day per Etherscan data
    uint256 public hmynInternval = 777;

    uint256 public currentHymn = 0;
    uint256 public currentHmynTokenRangeEnd = 777;
    uint256 public currentHmynStartBlock = 0;
    uint256 public currentHmynEndBlock = block.number; 

      constructor() ERC721("Anthromancer", "HYMN")
    {   //Intitalize Hymn Struct w/all info here in contructor
     
        idToHymn[0] = Hymn(
            1,
            "Hymn 01",
            "IPFS ADDRESS"
      );
       
       idToHymn[1] = Hymn(
            2,
            "Hymn 02",
            "IPFS ADDRESS"
      );
       idToHymn[2] = Hymn(
            3,
            "Hymn 03",
            "IPFS ADDRESS"
      );

        idToHymn[3] = Hymn(
            4,
            "Hymn 04",
            "IPFS ADDRESS"
      );

       
    }

   struct Hymn {
        uint256 _hymn;
        string _hymnName;
        string _ipfsAddress;
    } mapping(uint256 => Hymn) public idToHymn;

    //Main Mint Function
    function mintHmyn()payable public {
      require(tokenCounter < totalAllowed);
      require(msg.value == mintPrice);

     //Check block number & mint logic
      if (block.number > currentHmynStartBlock){
       _safeMint(msg.sender, tokenCounter);
       _setTokenURI(tokenCounter, idToHymn[currentHymn]._ipfsAddress);    
       tokenCounter = tokenCounter + 1;
      }

     //Alter token range logic
      //IF the # of Hymns minted is greater than or equal to the current Hmyn Range End
      //THEN adjust the currentHmyn UP by 1
      //AND move the START of the Current Hymn Range forward by the blockInterval
      //AND move the END of the Current Hymn Range forward by the blockInterval
      //AND move the Current Hmyn Range End forward by the hmynInternval
      if (tokenCounter >= currentHmynTokenRangeEnd){
          currentHymn = currentHymn + 1;
          currentHmynStartBlock = currentHmynStartBlock + blockInterval;
          currentHmynEndBlock = currentHmynEndBlock + blockInterval;
          currentHmynTokenRangeEnd = currentHmynTokenRangeEnd + hmynInternval;
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
