// SPDX-License-Identifier: MIT
pragma solidity >= 0.5.0 < 0.7.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/ownership/Ownable.sol";

/**
* @title ERC721 contract interface
*
* @notice Interface of common ERC721 contracts
* with allowance to mint and transfer NFT
* Using for batch minting and transfer
*/
interface ERC721 {
  // @notice Function to mint new token to given address with token URI
  // @param to The address that will own the minted token
  // @param tokenURI string The token URI of the minted token
  // @return uint256 is token id of new created token
  function mint(address to, string calldata) external returns (uint256);

  // @notice Transfers the ownership of a given token ID to another address.
  // @param from current owner of the token
  // @param to address to receive the ownership of the given token ID
  // @param tokenId uint256 ID of the token to be transferred
  function transferFrom(address from, address to, uint256 tokenId) external;

  // @dev Transfers ownership of the contract to a new account (`newOwner`).
  // Can only be called by the current owner.
  function transferOwnership(address newOwner) external;

  // @dev Returns the address of the current owner.
  function owner() external view returns (address);
}

/**
* @title ERC721 communal contract interface
*
* @notice Interface of communal ERC721 contracts
* with allowance to mint communal NFT
* Using for batch minting and transfer
*/
interface ERC721Communal {
  // @notice Function to mint new communal token to given address with token URI
  // @param to The address that will own the minted token
  // @param tokenURI string The token URI of the minted token
  // @param communal - set token communal, true or false
  // @return uint256 is token id of new created token
  function mint(address to, string calldata, bool communal) external returns (uint256);
}

// @title ERC721 Batch minting and transfer contract
//
// @notice Smart Contract provides batch minting and
// transfer functionality for ERC721 contracts.
// It will allow to mint/transfer unlimited amounts of ERC721
// tokens to single address and it reduce GAS costs approximately by 10-30%.
// Contract should be deployed first to blockchain with address of related ERC721 contract
//
// @author Andskur
contract Batch is Ownable{
  /**
  * @notice batch ERC721 minting
  * @dev mint given amount of NFT to given address
  * it will be revert if caller not the Batch contract owner
  * it will be revert if Batch contract no the owner of ERC721 contract
  * @param to The address that will own the minted tokens
  * @param tokens array of the tokens URI's of the minted tokens
  */
  function mintBatch(address erc721, address to, string[] memory tokens) public onlyOwner {
    for(uint index=0; index<tokens.length; index++){
      ERC721(erc721).mint(to, tokens[index]);
    }
  }

  /**
  * @notice batch communal ERC721 minting
  * @dev mint given amount of communal NFT to given address
  * it will be revert if caller not the Batch contract owner
  * it will be revert if Batch contract no the owner of ERC721 contract
  * @param to The address that will own the minted tokens
  * @param tokens array of the tokens URI's of the minted tokens
  */
  function mintBatchCommunal(address erc721, address to, string[] memory tokens) public onlyOwner {
    for(uint index=0; index<tokens.length; index++){
      ERC721Communal(erc721).mint(to, tokens[index], true);
    }
  }

  /**
  * @notice batch ERC721 transfer
  * @dev transfer given amount of NFT to given address
  * it will be revert if contract don't have allowance to given tokens ID's
  * it will be revert if Batch contract no the owner of ERC721 contract
  * @param to The address that will own the transferred tokens
  * @param tokens array of the tokens ID's of the transferred tokens
  */
  function transferBatch(address erc721, address to, uint256[] memory tokens) public {
    for(uint index=0; index<tokens.length; index++){
      ERC721(erc721).transferFrom(msg.sender, to, tokens[index]);
    }
  }

  /**
  * @notice Return contract ownership
  * @dev transfer ownership od ERC721 contract to given address
  * @param to address to returned ownership
  */
  function returnOwnership(address erc721, address to) public onlyOwner {
    ERC721(erc721).transferOwnership(to);
  }
}
