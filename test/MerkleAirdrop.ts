import {
  time,
  loadFixture,
} from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import hre from "hardhat";

describe("MerkleAirdrop", function () {

  async function deployMerkleAirdrop() {
  

    // Contracts are deployed using the first signer/account by default
    const [owner, otherAccount] = await hre.ethers.getSigners();

    const Airdrop = await hre.ethers.getContractFactory("Airdrop");

    const airdrop = await Airdrop.deploy();

    return {  owner, otherAccount, airdrop };
  }

  describe("Deployment", function () {
    it(" ", async function () {
      const { owner, otherAccount, airdrop  } = await loadFixture(deployMerkleAirdrop);


    });
  
  });

  describe("claimAirdrop", function () {

      it(" ", async function () {

        const { owner, otherAccount, airdrop  } = await loadFixture(deployMerkleAirdrop);

      
      });


    
    

  
  });
});
