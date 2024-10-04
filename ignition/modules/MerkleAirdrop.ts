import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const AirdropModules = buildModule("AirdropModules", (m) => {
  const merkleRoot = "0x5b8f6b5a5f7f8a8d9e6b1f7c8d9a3f1b7c8f8a1b2c9f3b4e5f6a7b8c9d1e2f3a";

  // Deploy the Airdrop contract, passing the merkleRoot as an argument
  const airdrop = m.contract("Airdrops", [merkleRoot]);

  return { airdrop };
});

export default AirdropModules;

/**
 * AirdropModules#Airdrops - 0x51A4Ce65E757cfC9b89428Bd52a6744b3a04895B
 * 
 *   - https://sepolia-blockscout.lisk.com//address/0x51A4Ce65E757cfC9b89428Bd52a6744b3a04895B#code
 */