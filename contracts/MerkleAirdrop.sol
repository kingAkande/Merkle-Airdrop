// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Airdrops {

    address public bAYCaddress = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
    bytes32 public merkleRoot;
    address public owner;

    mapping (address => bool) public alreadyClaimed;

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Not the owner");
        _;
    }

    event SuccessfulClaim(address indexed user, uint _tokenId);

    function claimAirdrop(uint _tokenId, bytes32[] calldata _merkleProof) external {
        // Ensure the contract holds the specified token
        require(IERC721(bAYCaddress).ownerOf(_tokenId) == address(this), "Contract does not own this token");

        // Verify the merkle proof
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, _tokenId));
        require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), "Invalid Merkle Proof");

        // Ensure the user has not already claimed
        require(alreadyClaimed[msg.sender] == false, "Airdrop already claimed");

        // Transfer the token to the user
        IERC721(bAYCaddress).safeTransferFrom(address(this), msg.sender, _tokenId);

        // Mark as claimed
        alreadyClaimed[msg.sender] = true;

        emit SuccessfulClaim(msg.sender, _tokenId);
    }

    function updateMerkleRoot(bytes32 _merkleRoot) external onlyOwner {
        merkleRoot = _merkleRoot;
    }

    function withdrawRemainingTokens(uint _tokenId) external onlyOwner {
        // Ensure the contract holds the specified token
        require(IERC721(bAYCaddress).ownerOf(_tokenId) == address(this), "Contract does not own this token");

        // Transfer the token back to the owner
        IERC721(bAYCaddress).safeTransferFrom(address(this), owner, _tokenId);
    }
}
