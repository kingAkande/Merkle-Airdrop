import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";



const AirdropModule = buildModule("AirdropModule", (m) => {

  const Airdrop = m.contract("Airdrop");

  return { Airdrop };
});

export default AirdropModule ;
