// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Anthromancer is ERC721URIStorage, ERC721Enumerable, Ownable {
    
    uint256 public tokenCounter = 0;    
    uint256 public mintPrice = 0; //Set to 0 for testing
    uint256 public mintPriceLate = 0; //Set to 0 for testing
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
            "IPFS ADDRESS",
            777,
            0
      );
       
      

       
    }

   struct Hymn {
        uint256 _hymn;
        string _hymnName;
        string _ipfsAddress;
        uint256 _hmynEndBlock;
        uint256 _totalMinted;
    } mapping(uint256 => Hymn) public idToHymn;

    //Main Mint Function
    function mintHmyn()payable public {
      require(tokenCounter < totalAllowed);
      require(msg.value == mintPrice);

     //Check block number logic & mint logic
      if (block.number > currentHmynStartBlock){
       _safeMint(msg.sender, tokenCounter);
       _setTokenURI(tokenCounter, idToHymn[currentHymn]._ipfsAddress);    
       tokenCounter = tokenCounter + 1;
       idToHymn[currentHymn]._totalMinted = idToHymn[currentHymn]._totalMinted + 1;
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

    //Late Mint Function
    //REQUIRE that the current block numnber is greater than the End Block of the Hymn being requested for Mint 
    //REQUIRE that the Hymn being requested for Mint has not yet had more than 777 of it minted
    //REQUIRE that the total supply of the token (not the current iterated count) is less than the Total Allowed Tokens
    //REQUIRE the message value is the Late Mint Price
    //MINT a Token to the user with a TokenId based on the current Hmyn Count (Read: Minted) of the Hmyn being requested for Mint
    //ASSIGN DATA to that same TokenId based on the same Hmyn being requested for that Hmyn's storage location
    //ITERATE UP the count of Hmyns minted   
    function mintLateHmyn(uint hmynNumber)payable public {
      require (block.number > idToHymn[hmynNumber]._hmynEndBlock);
      require (idToHymn[hmynNumber]._totalMinted < 778);
      require(totalSupply() < totalAllowed);
      require(msg.value == mintPriceLate);
       _safeMint(msg.sender, idToHymn[hmynNumber]._totalMinted);
       _setTokenURI(idToHymn[hmynNumber]._totalMinted, idToHymn[hmynNumber]._ipfsAddress); 
       idToHymn[hmynNumber]._totalMinted + 1;    
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
