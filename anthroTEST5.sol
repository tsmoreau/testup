// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";

contract Anthromancer is ERC721URIStorage, ERC721Enumerable, ERC721Holder, Ownable {

    uint256 public mintPrice = 100000000000000; //Set to 0 for testing
    uint256 public blockInterval = 1; //About 6400 Blocks in a day per Etherscan data, 23 Blocks set for Test, ~5mins
    uint256 public hymnInterval = 7; //Final will be 777, can be thought of as # of tokens allowed per type
    string public baseURI = "ipfs://QmeHGPsjDXraLBudLgMhb2ZVnLQfyTPKGcvcHY1h5kQYeb/"; //Hash of uploaded assests folder needs added
    uint256 public deployBlock = block.number;

      constructor() ERC721("Anthromancer", "HYMN")
    {   //Intitalize Hymn Struct w/all info here in contructor

     //Variables in struct:
      //_hymn;
      //_hymnName;
      //_ipfsExension;
      //_hymnEndBlock;
      //_hymnTokenRangeStart;
      //_hymnTokenCounter;
      //_hymnsMinted;
     
      idToHymn[0] = Hymn(
            0,
            "The Fool",
            "0.json",
            999999,
            0,
            0,
            0
      );
       idToHymn[1] = Hymn(
            1,
            "Fireyes",
            "1.json",
            block.number + blockInterval,
            1, 
            1,
            0
      );
        idToHymn[2] = Hymn(
            2,
            "Meatwar",
            "2.json",
            block.number + (blockInterval * 2), 
            1 + hymnInterval,
            1 + hymnInterval,
            0
      );
       idToHymn[3] = Hymn(
            3,
            "Optimo",
            "3.json",
            block.number + (blockInterval * 3), 
            1 + (hymnInterval * 2),
            1 + (hymnInterval * 2),
            0
      );
       idToHymn[4] = Hymn(
            4,
            "Seasons",
            "4.json",
            block.number + (blockInterval * 4), 
            1 + (hymnInterval * 3),
            1 + (hymnInterval * 3),
            0
      );
       idToHymn[5] = Hymn(
            5,
            "Dragoon",
            "5.json",
            block.number + (blockInterval * 5), 
            1 + (hymnInterval * 4),
            1 + (hymnInterval * 4),
            0
      ); 
       idToHymn[6] = Hymn(
            6,
            "Kintsukuroi",
            "6.json",
            block.number + (blockInterval * 6), 
            1 + (hymnInterval * 5),
            1 + (hymnInterval * 5),
            0
      );  
      idToHymn[7] = Hymn(
            7,
            "Primary",
            "7.json",
            block.number + (blockInterval * 7), 
            1 + (hymnInterval * 8),
            1 + (hymnInterval * 8),
            0
      ); 
      idToHymn[8] = Hymn(
            8,
            "Avarice",
            "8.json",
            block.number + (blockInterval * 8), 
            1 + (hymnInterval * 9),
            1 + (hymnInterval * 9),
            0
      ); 
      idToHymn[9] = Hymn(
            9,
            "The Shade",
            "9.json",
            block.number + (blockInterval * 9), 
            1 + (hymnInterval * 10),
            1 + (hymnInterval * 10),
            0
      );  
      idToHymn[10] = Hymn(
            10,
            "Arcanum",
            "10.json",
            block.number + (blockInterval * 10), 
            1 + (hymnInterval * 11),
            1 + (hymnInterval * 11),
            0
      );    
      idToHymn[11] = Hymn(
            11,
            "Visionaire",
            "11.json",
            block.number + (blockInterval * 11), 
            1 + (hymnInterval * 12),
            1 + (hymnInterval * 12),
            0
      );     
      idToHymn[12] = Hymn(
            12,
            "Druid",
            "12.json",
            block.number + (blockInterval * 12), 
            1 + (hymnInterval * 13),
            1 + (hymnInterval * 13),
            0
      );     
      idToHymn[13] = Hymn(
            13,
            "Zodiac",
            "13.json",
            block.number + (blockInterval * 13), 
            1 + (hymnInterval * 14),
            1 + (hymnInterval * 14),
            0
      );
       idToHymn[14] = Hymn(
            14,
            "The Fox",
            "14.json",
            999999,
            1 + (hymnInterval * 15),
            1 + (hymnInterval * 15),
            0
      );
    }

   //Hymn Data
   struct Hymn {
        uint256 _hymn;
        string _hymnName;
        string _ipfsExension;
        uint256 _hymnEndBlock;
        uint256 _hymnTokenRangeStart;
        uint256 _hymnTokenCounter;
        uint256 _hymnsMinted;
    } mapping(uint256 => Hymn) public idToHymn;

   //Tokens Minted per User during Sale
    struct tokenCounter {
       uint256 hold;
       uint256[15] count;
    } mapping (address => tokenCounter) public addressToCount;
    
   //Auction Info Storage
    struct Bids {
       address bidderAddress;
       uint256 bidAmount;
    } mapping (address => Bids) public addressToBid;

      address[5] public topBidders;
      uint256 public topBid;
      uint256 public auctionStartBlock;
      uint256 public auctionEndBlock;

    function foolAuctionBid()public payable {
       //Require Auction to have Started, AND not be Over
       require(block.number > auctionStartBlock && block.number < auctionEndBlock,
       "You are bidding outside the Auction Window");
       //Require Bid is Highest of all so far
       require (msg.value > topBid,
       "Your Bid is Lower than the current Top Bid");

       //Asssign Bid Info
       addressToBid[msg.sender].bidderAddress = msg.sender;
       addressToBid[msg.sender].bidAmount = msg.value;
       topBid = msg.value;

       //Refund Bid to Last Bidder from Top 5
       payable(topBidders[4]).transfer(addressToBid[topBidders[4]].bidAmount);

       //Remove Last Bidder from Top 5
       for (uint i = 4; i > 0; i--) {
         topBidders[i] = topBidders[i-1];
       }

       //Add New Bidder to Top 5
       topBidders[0] = msg.sender;

    }

    function foolAuctionClaim() public {
       //Require Auction to be over
       require(block.number > auctionEndBlock,
       "You cannot Claim Until Auction End");
       //Require Claimer is Top Bidder
       require(msg.sender == topBidders[0],
       "You are not the Top Bidder");
       //Approve Transfer
       approve(msg.sender, 0);
       //Transfer Top Bidder Fool Token
       transferFrom(address(this),msg.sender, 0);
       //Refund Top Bidders 2-5
      for (uint i = 1; i < 4; i++) {
         payable(topBidders[i]).transfer(addressToBid[topBidders[i]].bidAmount);
      }
    }

    function foolAuctionRemoveBid() public {
       uint bidderNumber = 9;
       for (uint i = 0; i < 4; i++) {
          if (msg.sender == topBidders[i]) {
               bidderNumber = i;
          }
       }

      require (bidderNumber < 7);

      payable(msg.sender).transfer(addressToBid[msg.sender].bidAmount);

      addressToBid[msg.sender].bidAmount = 0;

      for (uint i = bidderNumber; i < (4 - bidderNumber); i++) {
         
      }

    }

    function foolAuctionOpen(uint256 auctionBlockLength) public onlyOwner {
       require(_exists(0));
       auctionStartBlock = (block.number);
       auctionEndBlock = (block.number + auctionBlockLength);
    }

   //Single Mint
   //Input number for specific Hymn desired
   //Current Hymn and Older available to Mint
   //Current Hymn viewable via currentHymn function
   //Limit of 3 of Each Hymn total per Address
   function mintHymn(uint256 hymnNumber)payable public {

      uint256 test = (idToHymn[hymnNumber - 1]._hymnEndBlock);
      
      require (hymnNumber <= 13 && hymnNumber > 0,
        "Please enter a valid Hymn Number");
      require (addressToCount[msg.sender].count[hymnNumber] <= 2);
      require (test < block.number,
        "This Hymn has not yet Dropped.");
      require ((idToHymn[hymnNumber]._hymnsMinted) <= (hymnInterval - 1),
        "This Hymn has been Completely Minted."); 
    
      
      //Allows for Hymn 1 to be minted for free
      if (hymnNumber > 1){
      require(msg.value == mintPrice,
        "Please send the Mint Price.");
     }

      _safeMint(msg.sender, idToHymn[hymnNumber]._hymnTokenCounter); 
      _setTokenURI(idToHymn[hymnNumber]._hymnTokenCounter, idToHymn[hymnNumber]._ipfsExension); 
       idToHymn[hymnNumber]._hymnTokenCounter = idToHymn[hymnNumber]._hymnTokenCounter + 1; 
       idToHymn[hymnNumber]._hymnsMinted = idToHymn[hymnNumber]._hymnsMinted + 1; 

       addressToCount[msg.sender].count[hymnNumber] = addressToCount[msg.sender].count[hymnNumber] + 1;

   }

   //Multi Mint
   //Mints 1 Each of All Currently Available Hymns
   //Limit of 3 of Each Hymn total per Address
   //Requires msg.value of mintPrice * # of Currently Available Hymns
   //Reccomended to use via Anthromancer.io
    function mintMulti()payable public  {
       string memory name;
       uint256 hymnCount;
       uint refundCount;

       (name, hymnCount) = currentHymn();
       if (hymnCount > 13) {
          hymnCount = 14;
       }

        require(msg.value == (mintPrice * (hymnCount - 1)),
        "Please send the Multi-Mint Price.");

      for (uint i = 1; i < hymnCount ; i++) {
       if (
          idToHymn[i]._hymnsMinted <= hymnInterval - 1 &&
         (addressToCount[msg.sender].count[i] <= 2) &&
            hymnCount >= i
         ){
      _safeMint(msg.sender, idToHymn[i]._hymnTokenCounter); 
      _setTokenURI(idToHymn[i]._hymnTokenCounter, idToHymn[i]._ipfsExension); 
       idToHymn[i]._hymnTokenCounter = idToHymn[i]._hymnTokenCounter + 1; 
       idToHymn[i]._hymnsMinted = idToHymn[i]._hymnsMinted + 1;
       addressToCount[msg.sender].count[i] = addressToCount[msg.sender].count[i] + 1;
      }
      if (idToHymn[i]._hymnsMinted > hymnInterval - 1){
       refundCount++;
      }
      }
      payable(msg.sender).transfer(mintPrice * refundCount);
   }

   //Check Current Hymn
   function currentHymn() public view returns(string memory, uint)  {
      string memory hymn;
      uint hymnNumber;
      uint counter = 1 ;

      for (uint i = 0; i < 13; i++) {
      if (block.number > (deployBlock + blockInterval * i) && block.number <= (deployBlock + (blockInterval * counter))) {
         hymn = idToHymn[counter]._hymnName;
         hymnNumber = counter;
      }
      counter ++;
    }
      if (block.number > (deployBlock + blockInterval * 13)){
         hymn = "Main Sale Ended, All Hmyns Available";
         hymnNumber = 777;
    }
    return (hymn, hymnNumber);
   }
   
   //Count A User's Owned Hymns
   function countOwnedHymns(address userAddress) public view returns (uint[15] memory){
      return addressToCount[userAddress].count;
   }

   //Fool Mint - Only Owner
   function mintTheFool() public onlyOwner {
      require (idToHymn[13]._hymnsMinted <= 1);
      _safeMint(address(this), 0); 
      _setTokenURI(0, idToHymn[0]._ipfsExension);
      idToHymn[13]._hymnsMinted = idToHymn[13]._hymnsMinted + 1;
      idToHymn[13]._hymnTokenCounter = idToHymn[13]._hymnTokenCounter + 1;
   }

   //Fox Mint - Only Ower
   function mintTheFox(uint amount) public onlyOwner {
      for (uint i = 0; i < amount; i++) {
      _safeMint(msg.sender, idToHymn[14]._hymnTokenCounter); 
      _setTokenURI(idToHymn[14]._hymnTokenCounter, idToHymn[14]._ipfsExension);
      idToHymn[14]._hymnsMinted = idToHymn[14]._hymnsMinted + 1;
      idToHymn[14]._hymnTokenCounter = idToHymn[14]._hymnTokenCounter + 1;
      }
   }

   //Update IPFS Hash - onlyOwner
   //In case of need for change to images, metadata, etc
   function updateIPFSHash(string memory newIPFSHash) public onlyOwner {
      baseURI = newIPFSHash;
   }

    //Withdraw Booty - Only Owner
    function withdrawCoins() public onlyOwner{
        payable(msg.sender).transfer(address(this).balance);
    }

    //Yggdrasil card?
    //Auction


    function _baseURI() internal view override returns (string memory) {
        return baseURI;
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
