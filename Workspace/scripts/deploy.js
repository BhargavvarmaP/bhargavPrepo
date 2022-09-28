const hre = require("hardhat");

async function main() {


  const IPLNFT = await hre.ethers.getContractFactory("IPLNFT");
  const IPLnft = await IPLNFT.deploy();

  await IPLnft.deployed();

  console.log("Deployed Address of NFT is : ",IPLnft.address);

}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
