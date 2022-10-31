const {ethers} = require("hardhat");
async function main() {
    
    const tokenAddress = "0x3c7e51C6048eB2FbA9675865072Aa01855ae56c9";
    const Deposit_5slabs = await ethers.getContractFactory("Deposit_5Slabs");
    const deposit_5slabs = await Deposit_5slabs.deploy(tokenAddress);
    await deposit_5slabs.deployed();
    
    console.log("Deployed Address  is : ",deposit_5slabs.address);
}
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });
  