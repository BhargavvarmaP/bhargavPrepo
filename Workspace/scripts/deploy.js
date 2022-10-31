const hre = require("hardhat");

async function main() {


  const YeleboToken = await hre.ethers.getContractFactory("YeleboToken");
  const Yelebotoken = await YeleboToken.deploy();

  await Yelebotoken.deployed();

  console.log("Deployed Address of YeleboToken is : ",Yelebotoken.address);

}
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
