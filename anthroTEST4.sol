// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract Anthromancer is ERC721URIStorage, ERC721Enumerable, Ownable {

    uint256 public mintPrice = 0; //Set to 0 for testing
    uint256 public mintPriceLate = 0; //Set to 0 for testing
    uint256 public blockInterval = 6; //About 6500 Blocks in a day per Etherscan data, 23 Blocks set for Test, ~5mins
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
            "ipfs://QmUGfTqULPypSWKzVveg9QCCbxLxAWWtXi3an3qPBEhDp8",
            999999,
            0,
            0,
            0
      );
       idToHymn[1] = Hymn(
            1,
            "Fireyes",
            "ipfs://QmchgmF55dGS2yoDuJK7abhmaTyc4XobJiYxcLQiGLnGMk",
            block.number + blockInterval, //Hymn 1 Mint Period End Block is the block number upon deployment plus the block interval
            1, //Think of this as the start of the Token Range, the mint funtion checks it against the hmynInterval
            1,
            0
      );
        idToHymn[2] = Hymn(
            2,
            "Meatwar",
            "ipfs://QmaE1826X1EVs7X783xUdYYB2u2UwTEQYn42ssiVW92XBE",
            block.number + (blockInterval * 2), //Hymn 2 Mint Period End Block is the block number upon deployment plus the block interval x2
            1 + hymnInterval,
            1 + hymnInterval,
            0
      );
       idToHymn[3] = Hymn(
            3,
            "Optimo",
            "ipfs://QmdjVjRkrpHX3jr2PkwqSEQfQmgPvkz5hLcHfRYRNq7uFT",
            block.number + (blockInterval * 3), //Hymn 3 Mint Period End Block is the block number upon deployment plus the block interval x3
            1 + (hymnInterval * 2),
            1 + (hymnInterval * 2),
            0
      );
       idToHymn[4] = Hymn(
            4,
            "Seasons",
            "ipfs://QmT1bNwcRXeMUhszqUJLsFmJz5jHFaFk4Zn6FonQJSsSiX",
            block.number + (blockInterval * 4), //Hymn 4 Mint Period End Block is the block number upon deployment plus the block interval x4
            1 + (hymnInterval * 3),
            1 + (hymnInterval * 3),
            0
      );
       idToHymn[5] = Hymn(
            5,
            "Dragoon",
            "ipfs://QmRjrx7SArJCFGcuQYZ4oZH49eWdhLHzJUfF9jNx1BVtuf",
            block.number + (blockInterval * 5), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 4),
            1 + (hymnInterval * 4),
            0
      ); 
       idToHymn[6] = Hymn(
            6,
            "Kintsukuroi",
            "ipfs://QmYwgjJVwdhbVJN57YaqGkArXSLKMjpeNuzctJ3YDqbzzc",
            block.number + (blockInterval * 6), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 5),
            1 + (hymnInterval * 5),
            0
      );  
      idToHymn[7] = Hymn(
            7,
            "Primary",
            "ipfs://QmTv3hTW3i6zVX16tG49X2ktLwz2gdgFSaCMiZY5qA1zRe",
            block.number + (blockInterval * 7), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 8),
            1 + (hymnInterval * 8),
            0
      ); 
      idToHymn[8] = Hymn(
            8,
            "Avarice",
            "ipfs://QmP95M8iPLzSdocakGjignTBZwpNVwQq8a2NY5y7zXFHPK",
            block.number + (blockInterval * 8), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 9),
            1 + (hymnInterval * 9),
            0
      ); 
      idToHymn[9] = Hymn(
            9,
            "The Shade",
            "ipfs://QmZL6Swfj6j86FU5eg16F293fVYeYjkzphfxvuXVrBT83J",
            block.number + (blockInterval * 9), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 10),
            1 + (hymnInterval * 10),
            0
      );  
      idToHymn[10] = Hymn(
            10,
            "Arcanum",
            "ipfs://QmXbRRJStWTnPsoTPYAKQw4LGV4R1hS1P1XjoQyhEUCE2k",
            block.number + (blockInterval * 10), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 11),
            1 + (hymnInterval * 11),
            0
      );    
      idToHymn[11] = Hymn(
            11,
            "Visionaire",
            "ipfs://QmV7cyc9Gst6s3uppmyjJReWcbVycA4CCQzA8pBbjaesUp",
            block.number + (blockInterval * 11), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 12),
            1 + (hymnInterval * 12),
            0
      );     
      idToHymn[12] = Hymn(
            12,
            "Druid",
            "ipfs://QmcXkAtk7RPj7ReaTyy99kBQs6fKJBejMF7oQ3AgrfXwTj",
            block.number + (blockInterval * 12), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 13),
            1 + (hymnInterval * 13),
            0
      );     
      idToHymn[13] = Hymn(
            13,
            "Zodiac",
            "ipfs://QmYAfj5vYQsCptGR8ExxUdf3hYA1ne41K5Xcf3ayNmfVVB",
            block.number + (blockInterval * 13), //Hymn 5 Mint Period End Block is the block number upon deployment plus the block interval x5
            1 + (hymnInterval * 14),
            1 + (hymnInterval * 14),
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

      if (block.number > (deployBlock + 0) && block.number < (deployBlock + blockInterval)) { //Mints Hymn 1 between the deployment block and X blocks later, determined the blockInterval
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
      //Hymn 4
       if (block.number > (deployBlock + blockInterval * 3) && block.number < (deployBlock + (blockInterval * 4))) { //Mints Hymn 4 between the deployment block and the 4X blocks later, determined by two multiples of the blockInterval
      require (idToHymn[1]._hymnsMinted <= hymnInterval, "Hymn 4 has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than the hymnInterval of it minted
       _safeMint(msg.sender, idToHymn[4]._hymnCounter); //Mint the token based on the individual Hymn Counter
       _setTokenURI(idToHymn[4]._hymnCounter, idToHymn[4]._ipfsAddress); //Assigns data to that token 
       idToHymn[4]._hymnCounter = idToHymn[4]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[4]._hymnsMinted = idToHymn[4]._hymnsMinted + 1; //Move the number of Hymns Minted Up by One
      }
      //Hymn 5
       if (block.number > (deployBlock + blockInterval * 4) && block.number < (deployBlock + (blockInterval * 5))) { //Mints Hymn 5 between the deployment block and the 5X blocks later, determined by two multiples of the blockInterval
      require (idToHymn[1]._hymnsMinted <= hymnInterval, "Hymn 5 has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than the hymnInterval of it minted
       _safeMint(msg.sender, idToHymn[5]._hymnCounter); //Mint the token based on the individual Hymn Counter
       _setTokenURI(idToHymn[5]._hymnCounter, idToHymn[5]._ipfsAddress); //Assigns data to that token 
       idToHymn[5]._hymnCounter = idToHymn[5]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[5]._hymnsMinted = idToHymn[5]._hymnsMinted + 1; //Move the number of Hymns Minted Up by One
      }
      //Hymn 6
       if (block.number > (deployBlock + blockInterval * 5) && block.number < (deployBlock + (blockInterval * 6))) { //Mints Hymn 6 between the deployment block and the 6X blocks later, determined by two multiples of the blockInterval
      require (idToHymn[1]._hymnsMinted <= hymnInterval, "Hymn 6 has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than the hymnInterval of it minted
       _safeMint(msg.sender, idToHymn[6]._hymnCounter); //Mint the token based on the individual Hymn Counter
       _setTokenURI(idToHymn[6]._hymnCounter, idToHymn[6]._ipfsAddress); //Assigns data to that token 
       idToHymn[6]._hymnCounter = idToHymn[6]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[6]._hymnsMinted = idToHymn[6]._hymnsMinted + 1; //Move the number of Hymns Minted Up by One
      }
      

   }

   //Late Mint Function
   function mintLateHymn(uint hymnNumber)payable public {
      require (idToHymn[hymnNumber - 1]._hymnEndBlock < block.number, "This Hymn has not yet Dropped."); //REQUIRE that the current block number is greater than the End Block of the Hymn being requested for Mint 
      
      require ((idToHymn[hymnNumber]._hymnsMinted) <= (hymnInterval - 1), "This Hymn has been completely Minted."); //REQUIRE that the Hymn being requested for Mint has not yet had more than 777 of it minted
      require(msg.value == mintPriceLate, "Please send the Mint Price."); //REQUIRE the message value is the Late Mint Price
      _safeMint(msg.sender, idToHymn[hymnNumber]._hymnCounter); //MINT a Token to the user with a TokenId based on the current Hymn Count of the Hymn being requested for Mint
      _setTokenURI(idToHymn[hymnNumber]._hymnCounter, idToHymn[hymnNumber]._ipfsAddress); //ASSIGN DATA to that same TokenId based on the same Hymn being requested for that Hymn's storage location
       idToHymn[hymnNumber]._hymnCounter = idToHymn[hymnNumber]._hymnCounter + 1; //Move the individual Hymn Counter Up by One
       idToHymn[hymnNumber]._hymnsMinted = idToHymn[hymnNumber]._hymnsMinted + 1; //Move the number of Hymns Minted Up by One
   }

   //Fool Mint Function
   function mintTheFool() public onlyOwner {
      _safeMint(msg.sender, 0); 
      _setTokenURI(0, idToHymn[0]._ipfsAddress); 
   }

   //Check Current Hymn Function
   function currentHymn() public view returns(string memory)  {
      string memory hymn;
      if (block.number > deployBlock && block.number <= (deployBlock + blockInterval)) {
         hymn = idToHymn[1]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval) && block.number <= (deployBlock + (blockInterval * 2))) {
         hymn = idToHymn[2]._hymnName;
      }
       if (block.number > (deployBlock + blockInterval * 2) && block.number <= (deployBlock + (blockInterval * 3))) {
         hymn = idToHymn[3]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 3) && block.number <= (deployBlock + (blockInterval * 4))) {
         hymn = idToHymn[4]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 4) && block.number <= (deployBlock + (blockInterval * 5))) {
         hymn = idToHymn[5]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 5) && block.number <= (deployBlock + (blockInterval * 6))) {
         hymn = idToHymn[6]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 6) && block.number <= (deployBlock + (blockInterval * 7))) {
         hymn = idToHymn[7]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 7) && block.number <= (deployBlock + (blockInterval * 8))) {
         hymn = idToHymn[8]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 8) && block.number <= (deployBlock + (blockInterval * 9))) {
         hymn = idToHymn[9]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 9) && block.number <= (deployBlock + (blockInterval * 10))) {
         hymn = idToHymn[10]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 10) && block.number <= (deployBlock + (blockInterval * 11))) {
         hymn = idToHymn[11]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 11) && block.number <= (deployBlock + (blockInterval * 12))) {
         hymn = idToHymn[12]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 12) && block.number <= (deployBlock + (blockInterval * 13))) {
         hymn = idToHymn[13]._hymnName;
      }
      if (block.number > (deployBlock + blockInterval * 13)){
         hymn = "Main Sale Ended, All Hmyns Available";
      }
      return hymn;
   }

    //Yggdrasil card?
 
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
