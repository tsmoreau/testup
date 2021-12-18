// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Anthromancer is ERC721URIStorage, ERC721Enumerable, Ownable {

    uint256 public mintPrice = 0; //Set to 0 for testing
    uint256 public mintPriceLate = 0; //Set to 0 for testing
    uint256 public blockInterval = 23; //About 6500 Blocks in a day per Etherscan data, 23 Blocks set for Test, ~5mins
    uint256 public hymnInterval = 7; //Final will be 777
    uint256 public deployBlock = block.number; 

      constructor() ERC721("Anthromancer", "HYMN")
    {   //Intitalize Hymn Struct w/all info here in contructor

     //Vairbles in struct:
     //_hymn
     //_hymnName
     //_ipfsAddress
     //_hymnEndBlock
     //_hymnCounter;
     
      idToHymn[0] = Hymn(
            0,
            "The Fool",
            "ipfs://QmPD39gT2BYfDotb65HwVHkDoALauUwUkKWPUnHSf1UpK8",
            999999999999, //Placeholder. Not read at all my by the Main Mint function, as that starts reading from position 1 in the array, thanks to the Token Counter being set at 1. This allows position 0 in all data storage (token or array) to be The Fool. Design patern consistency.
            0,
            0,
            0
      );
       idToHymn[1] = Hymn(
            1,
            "Fireyes",
            "ipfs://QmaE1826X1EVs7X783xUdYYB2u2UwTEQYn42ssiVW92XBE",
            block.number + blockInterval, //Hymn 1 Mint Period End Block is the block number upon deployment plus the block interval
            1, //Think of this as the start of the Token Range, the mint funtion checks it against the hmynInterval
            1,
            1
      );
        idToHymn[2] = Hymn(
            2,
            "Meatwar",
            "ipfs://QmdZoFrr8csYkh9zwgdK2k3nnQFZ72pxUMjhNkPv7aZHpF",
            block.number + (blockInterval * 2), //Hymn 2 Mint Period End Block is the block number upon deployment plus the block interval x2
            1 + hymnInterval,
            1 + hymnInterval,
            1
      );
       idToHymn[3] = Hymn(
            3,
            "Optimo",
            "IPFS ADDRESS",
            block.number + (blockInterval * 3), //Hymn 3 Mint Period End Block is the block number upon deployment plus the block interval x3
            1 + (hymnInterval * 2),
            1 + (hymnInterval * 2),
            1
      );
       idToHymn[4] = Hymn(
            4,
            "Seasons",
            "IPFS ADDRESS",
            block.number + (blockInterval * 4), //Hymn 4 Mint Period End Block is the block number upon deployment plus the block interval x4
            1 + (hymnInterval * 3),
            1 + (hymnInterval * 3),
            0
      );
       idToHymn[5] = Hymn(
            5,
            "Dragoon",
            "IPFS ADDRESS",
            block.number + (blockInterval * 5), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 4),
            1 + (hymnInterval * 4),
            0
      );  
    }

   struct Hymn {
        uint256 _hymn;
        string _hymnName;
        string _ipfsAddress;
        uint256 _hymnEndBlock;
        uint256 _hymnStart;
        uint256 _hymnCounter;
        uint256 _hymnsMinted;
    } mapping(uint256 => Hymn) public idToHymn;

   //Main Mint Function
   function mintHymn() payable public{
      require(msg.value == mintPrice, "Please send the Mint Price.");

      if (block.number > deployBlock && block.number < deployBlock + blockInterval) { //Mints Hymn 1 between the deployment block and X blocks later, determined the blockInterval
      require (idToHymn[1]._hymnsMinted <= hymnInterval, "Hymn 1 has been completely Minted. Please Wait for Next Hymn"); //REQUIRE that the Hymn being requested for Mint has not yet had more than the hymnInterval of it minted
       _safeMint(msg.sender, idToHymn[1]._hymnCounter); //Mint the token based on the individual Hymn Counter
       _setTokenURI(idToHymn[1]._hymnCounter, idToHymn[1]._ipfsAddress); //Assigns data to that token 
       idToHymn[1]._hymnCounter = idToHymn[1]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[1]._hymnsMinted = idToHymn[1]._hymnsMinted + 1; //Move the number of Hymns Minted Up by One
      }

      //Hymn 2
       if (block.number > (deployBlock + blockInterval) && block.number < (deployBlock + (blockInterval * 2))) { //Mints Hymn 2 between the deployment block and the 2X blocks later, determined by two multiples of the blockInterval
       require (idToHymn[2]._hymnsMinted <= hymnInterval, "Hymn 2 has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than the hymnInterval of it minted
       _safeMint(msg.sender, idToHymn[2]._hymnCounter); //Mint the token based on the individual Hymn Counter
       _setTokenURI(idToHymn[2]._hymnCounter, idToHymn[2]._ipfsAddress); //Assigns data to that token 
       idToHymn[2]._hymnCounter = idToHymn[2]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[2]._hymnsMinted = idToHymn[2]._hymnsMinted + 1; //Move thtone number of Hymns Minted Up by One
       }

      //Hymn 3
       if (block.number > (deployBlock + blockInterval * 2) && block.number < (deployBlock + (blockInterval * 3))) { //Mints Hymn 3 between the deployment block and the 3X blocks later, determined by two multiples of the blockInterval
      require (idToHymn[1]._hymnsMinted <= hymnInterval, "Hymn 3 has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than the hymnInterval of it minted
       _safeMint(msg.sender, idToHymn[3]._hymnCounter); //Mint the token based on the individual Hymn Counter
       _setTokenURI(idToHymn[3]._hymnCounter, idToHymn[3]._ipfsAddress); //Assigns data to that token 
       idToHymn[3]._hymnCounter = idToHymn[3]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[3]._hymnsMinted = idToHymn[3]._hymnsMinted + 1; //Move the number of Hymns Minted Up by One
      }

      

   }

   //Late Mint Function
   function mintLateHymn(uint hymnNumber)payable public {
      require (block.number > idToHymn[hymnNumber]._hymnEndBlock, "This Hymn has not yet Dropped."); //REQUIRE that the current block number is greater than the End Block of the Hymn being requested for Mint 
      require (idToHymn[hymnNumber]._hymnsMinted <= hymnInterval, "This Hymn has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than 777 of it minted
      require(msg.value == mintPriceLate, "Please send the Mint Price."); //REQUIRE the message value is the Late Mint Price
      _safeMint(msg.sender, idToHymn[hymnNumber]._hymnCounter); //MINT a Token to the user with a TokenId based on the current Hymn Count of the Hymn being requested for Mint
      _setTokenURI(idToHymn[hymnNumber]._hymnCounter, idToHymn[hymnNumber]._ipfsAddress); //ASSIGN DATA to that same TokenId based on the same Hymn being requested for that Hymn's storage location
       idToHymn[hymnNumber]._hymnCounter = idToHymn[hymnNumber]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[hymnNumber]._hymnCounter = idToHymn[hymnNumber]._hymnsMinted + 1; //Move the number of Hymns Minted Up by One
   }

   //Fool Mint Function
   function mintTheFool() public onlyOwner {
      _safeMint(msg.sender, 0); 
      _setTokenURI(0, idToHymn[0]._ipfsAddress); 
   }

   //Fool Mint Function
   function currentHymn() public view returns(string memory)  {
      string memory hymn;
      if (block.number > deployBlock && block.number <= (deployBlock + blockInterval)) {
         hymn = idToHymn[1]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval) && block.number <= (deployBlock + (blockInterval * 2))) {
         hymn = idToHymn[2]._hymnName;
      }
       if (block.number > (deployBlock + blockInterval) && block.number <= (deployBlock + (blockInterval * 3))) {
         hymn = idToHymn[3]._hymnName;
      }
      return hymn;
   }

    //Igdresil card?
 
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
