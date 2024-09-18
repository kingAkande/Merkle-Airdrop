// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract Airdrop{

    address bAYCaddress = 0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D;
    bytes32 merkleRoot;
    address owner;

   

    mapping (address => bool) public alreadyClaimed;


    constructor( bytes32 _merkleRoot) {

        merkleRoot = _merkleRoot;
        owner = msg.sender;

    }

    modifier onlyOwner() {

        require( owner == msg.sender, "not owner");
        _;

    }

    event SuccessfulClaim(address indexed user , uint _amount );
    

    function claimAirdrop( uint _amount, bytes32[] calldata _merkleProof) external  {

        require(IERC721(bAYCaddress).balanceOf(address(this)) > 0 , "not enough balance"  );
        
        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, _amount));

        require(alreadyClaimed[msg.sender] == true , "shole nie ni");

        MerkleProof.verify(_merkleProof,merkleRoot,leaf);

        IERC721( bAYCaddress ).transfer(msg.sender ,_amount );

        alreadyClaimed[msg.sender]= true;

        emit SuccessfulClaim(msg.sender , _amount );

    }

   

    function uPdateMerkleRoot(bytes32 _merkleRoot) private onlyOwner {

        merkleRoot = _merkleRoot;

    }



    function withdrawRemainingToken() private {

     require(IERC721(tokenAddress).balanceOf(address(this)) > 0 , "not enough balance"  );

        uint256 tokenbalance = IERC721(bAYCaddress).balanceOf(address(this)) ;
        
        IERC721(bAYCaddress).transfer(owner,tokenbalance);
    }

    


}