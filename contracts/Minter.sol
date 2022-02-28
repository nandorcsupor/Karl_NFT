// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Minter is ERC721URIStorage, Ownable {
    uint256 public tokenCounter;

    enum CONTRACT_STATE {
        OPEN,
        CLOSED
    }

    CONTRACT_STATE public contract_state;

    constructor() ERC721("Karl", "K") {
        tokenCounter = 0;
        contract_state = CONTRACT_STATE.OPEN;
    }

    function createCollectible(string memory tokenURI)
        public
        returns (uint256)
    {
        require(
            contract_state == CONTRACT_STATE.OPEN,
            "Sorry, the contract is closed right now!"
        );
        uint256 newTokenId = tokenCounter;
        _safeMint(msg.sender, newTokenId);
        _setTokenURI(newTokenId, tokenURI);
        tokenCounter = tokenCounter + 1;
        return newTokenId;
    }

    function startMinting() public onlyOwner {
        require(
            contract_state == CONTRACT_STATE.CLOSED,
            "Sorry, It's already Open!"
        );
        contract_state = CONTRACT_STATE.OPEN;
    }

    function stopMinting() public onlyOwner {
        require(
            contract_state == CONTRACT_STATE.OPEN,
            "Sorry, It's already closed!"
        );
        contract_state = CONTRACT_STATE.CLOSED;
    }
}
