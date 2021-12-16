// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Anthromancer is ERC721URIStorage, ERC721Enumerable, Ownable {
    
    uint256 public tokenCounter = 1; //Reserving Token 0 for The Fool

    uint256 public mintPrice = 0; //Set to 0 for testing
    uint256 public mintPriceLate = 0; //Set to 0 for testing

    uint256 public totalAllowed = 10102; //777*13+1 (Plus 1 for the Fool)
    uint256 public blockInterval = 65; //About 6500 Blocks in a day per Etherscan data, 65 block temp for test
    uint256 public hmynInternval = 7; //Final will be 777

    uint256 public currentHymn = 1; //Set to 1 to avoid The Fool; not absolutely needed to make data align this way, but is the better design pattern
    uint256 public currentHmynEnd = 777;
    uint256 public currentHmynStartBlock = 0;
    uint256 public currentHmynEndBlock = block.number; 

      constructor() ERC721("Anthromancer", "HYMN")
    {   //Intitalize Hymn Struct w/all info here in contructor

    //Vairbles in struct:
    //_hymn
    //_hymnName
    //_ipfsAddress
    //_hmynEndBlock
    //_hymnsMinted;
     
      idToHymn[0] = Hymn(
            0,
            "The Fool",
            "IPFS ADDRESS",
            999999999999, //Placeholder. Not read at all my by the Main Mint function, as that starts reading from position 1 in the array, thanks to the Token Counter being set at 1. This allows position 0 in all data storage (token or array) to be The Fool. Design patern consistency.
            0
      );
       idToHymn[1] = Hymn(
            1,
            "Fireyes",
            "IPFS ADDRESS",
            block.number + blockInterval, //Hymn 1 Mint Period End Block is the block number upon deployment plus the block interval
            0
      );
        idToHymn[2] = Hymn(
            2,
            "Meatwar",
            "IPFS ADDRESS",
            block.number + (blockInterval * 2), //Hymn 2 Mint Period End Block is the block number upon deployment plus the block interval x2
            0
      );
       idToHymn[3] = Hymn(
            3,
            "Optimo",
            "IPFS ADDRESS",
            block.number + (blockInterval * 3), //Hymn 3 Mint Period End Block is the block number upon deployment plus the block interval x3
            0
      );
       idToHymn[4] = Hymn(
            4,
            "Lasers",
            "IPFS ADDRESS",
            block.number + (blockInterval * 4), //Hymn 4 Mint Period End Block is the block number upon deployment plus the block interval x4
            0
      );
       idToHymn[5] = Hymn(
            5,
            "Dragoon",
            "IPFS ADDRESS",
            block.number + (blockInterval * 5), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            0
      );  
    }

   struct Hymn {
        uint256 _hymn;
        string _hymnName;
        string _ipfsAddress;
        uint256 _hmynEndBlock;
        uint256 _hymnsMinted;
    } mapping(uint256 => Hymn) public idToHymn;

    //Main Mint Function
    function mintHmyn()payable public {
      require(tokenCounter < totalAllowed);
      require(msg.value == mintPrice, "Please send the Mint Price.");

    //
      if (tokenCounter >= currentHmynEnd){ //IF the # of Hymns minted is greater than or equal to the current Hmyn Range End
          currentHymn = currentHymn + 1; //Adjust the currentHmyn UP by 1
          currentHmynStartBlock = currentHmynEndBlock + 1; //Move the currentHmynStartBlock forward to the where the previous ended
          currentHmynEndBlock = currentHmynEndBlock + blockInterval; //Move the currentHmynEndBlock forward by the blockInterval
          tokenCounter = currentHmynEnd + 1; //Move the tokenId assigned up to the correct number for the New Hmyn 
          currentHmynEnd = currentHmynEnd + hmynInternval; //Move the Current Hmyn Range End forward by the hmynInterval
      }

     //Check block number logic & mint logic
      if (block.number > currentHmynStartBlock && block.number < currentHmynEndBlock){
       _safeMint(msg.sender, tokenCounter);
       _setTokenURI(tokenCounter, idToHymn[currentHymn]._ipfsAddress);    
       tokenCounter = tokenCounter + 1;
       idToHymn[currentHymn]._hymnsMinted = idToHymn[currentHymn]._hymnsMinted + 1;
      }

     //Alter token range logic

    }

    //Late Mint Function
     function mintLateHmyn(uint hmynNumber)payable public {
      require (block.number > idToHymn[hmynNumber]._hmynEndBlock, "This Hmyn has not yet Dropped."); //REQUIRE that the current block number is greater than the End Block of the Hymn being requested for Mint 
      require (idToHymn[hmynNumber]._hymnsMinted < 778, "This Hmyn has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than 777 of it minted
      require(totalSupply() < totalAllowed); //REQUIRE that the total supply of the token (not the current iterated count) is less than the Total Allowed Tokens
      require(msg.value == mintPriceLate, "Please send the Mint Price."); //REQUIRE the message value is the Late Mint Price
      _safeMint(msg.sender, idToHymn[hmynNumber]._hymnsMinted); //MINT a Token to the user with a TokenId based on the current Hmyn Count (Read: Minted) of the Hmyn being requested for Mint
      _setTokenURI(idToHymn[hmynNumber]._hymnsMinted, idToHymn[hmynNumber]._ipfsAddress); //ASSIGN DATA to that same TokenId based on the same Hmyn being requested for that Hmyn's storage location
      idToHymn[hmynNumber]._hymnsMinted + 1; //ITERATE UP the count of Hmyns minted   

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
