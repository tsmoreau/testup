// SPDX-License-Identifier: MIT
//    ___          __  __                                                                 
//   /   |  ____  / /_/ /_  _________  ____ ___  ____ _____  ________  _____              
//  / /| | / __ \/ __/ __ \/ ___/ __ \/ __ `__ \/ __ `/ __ \/ ___/ _ \/ ___/              
// / ___ |/ / / / /_/ / / / /  / /_/ / / / / / / /_/ / / / / /__/  __/ /                  
///_/  |_/_/ /_/\__/_/ /_/_/   \____/_/ /_/ /_/\__,_/_/ /_/\___/\___/_/                   
//__  __                __                _ __   ______            __                  __ 
//\ \/ /___ _____ _____/ /________ ______(_) /  / ____/___  ____  / /__________ ______/ /_
// \  / __ `/ __ `/ __  / ___/ __ `/ ___/ / /  / /   / __ \/ __ \/ __/ ___/ __ `/ ___/ __/
// / / /_/ / /_/ / /_/ / /  / /_/ (__  ) / /  / /___/ /_/ / / / / /_/ /  / /_/ / /__/ /_  
///_/\__, /\__, /\__,_/_/   \__,_/____/_/_/   \____/\____/_/ /_/\__/_/   \__,_/\___/\__/  
//  /____//____/                                                                          

pragma solidity ^0.8.2;

/// @title Reward contract for Original Anthromancer Kickstarter Backers
/// @author tsmoreau
/// @notice Contract is designed to be minted from only by owner
/// @dev Tokens are minted by owner and transferred via transferToBacker
/// @dev Designed to be used in combination with a relayer for distribution

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Burnable.sol";

contract Yggdrasil is ERC1155, Ownable, ERC1155Burnable {
    constructor()
        ERC1155("ipfs://QmZL6Swfj6j86FU5eg16F293fVYeYjkzphfxvuXVrBT83J")
    {}

    /// @notice Total token supply
    /// @dev Altered by mint & burn functions
    uint256 supply;

    /// @notice Address of the relayer used for token distribution
    address public relayerAddress;

    /// @notice Address used for token minting and storage
    address public anthroWalletAddress;

    /// @notice Getter function for front-ends
    function totalSupply() public view returns(uint256) {
        return (supply);
    }

    /// @notice Set relayer address, can only be used by Owner
    function setRelayerAddress(address relayer) public onlyOwner {
        relayerAddress = relayer;
        setApprovalForAll(relayer, true);
    }

    /// @notice Set anthromancer wallet address, can only be used by Owner
    function setAnthroWalletAddress(address anthroWallet) public onlyOwner {
        anthroWalletAddress = anthroWallet;
    }

    /// @notice Main mint function, can only be used by Owner
    function mintBatch(uint total)
        public
        onlyOwner{

         uint[] memory tokenId = new uint[](1);
        tokenId[0] = 1;  

        uint[] memory amount = new uint[](1);
        amount[0] = total;
        

        supply = supply + total;
        
        _mintBatch(msg.sender, tokenId, amount, abi.encodePacked("1"));
    }

    /// @notice Main distro function, can only be used by Owner & Relayer
    function transferToBacker(address backerAddress) public {
        require (msg.sender == owner() || msg.sender == relayerAddress);
        _safeTransferFrom(anthroWalletAddress, backerAddress, 1, 1, abi.encodePacked("1"));
    }
    
    /// @notice Burn token function, can only be used by Token Owner or Approved
    function burn(
        address account,
        uint256 id,
        uint256 value
    ) public override virtual {
        require(
            account == _msgSender() || isApprovedForAll(account, _msgSender()),
            "ERC1155: caller is not owner nor approved"
        );

        _burn(account, id, value);
        supply= supply - value;
    }
}
