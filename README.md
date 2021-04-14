# ERC721 Batch contract
Smart Contract provides batch minting and
transfer functionality for ERC721 contracts.
It will allow to mint/transfer unlimited amounts of ERC721
tokens to single address and it reduce GAS costs approximately by 10-30%.
Contract should be deployed first to blockchain with address of related ERC721 contract

## How it Works
For first, you need to deploy Batch contract to Ethereum network.

### Batch minting:
 1. Transfer Ownership to Batch contract from ERC721 contract by its calling ```transferOwnership``` method
    1. For Communal ERC71 - call ``mintBatchCommunal`` method on Batch contract
    2. For standard ERC71 - call ``mintBatch`` method on Batch contract
 2. You can revoke ERC721 contract Ownership by calling ``returnOwnership`` method on Batch contract

### Batch transfer:
 1. Call ``setApprovalForAll`` method on ERC721 contract to allow token transfer to Batch contract
 2. Call ``transferBatch`` method on Batch contract

## Author

* **Andrey Skurlatov** - [andskur](tps://github.com/andskur)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
