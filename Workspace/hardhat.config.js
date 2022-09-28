require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  defaultNetwork: "ropsten",
  networks: {
    hardhat: {
    },
    ropsten: {
      url: "https://ropsten.infura.io/v3/494d651065cf4c159794e084f06ec4d5",
      accounts: ['0cf837e2ab1552a45de172c1231da8fc6bad1c25484dc4ecfabff5550f3b7afb']
    },
    goerli: {
      url: "https://eth-goerli.g.alchemy.com/v2/eDxvdMpABSihT2SD2cISYdwz7pJ27fKe",
      accounts: ['16160d12613270493d5a3e74e7aeef1dbc211bfc62b2c735e1440722b26f49a9']
    }
  },
  etherscan:{
    apiKey:'Q297XPNJ5XV6F4R9UJ8U81UT98ZPUIBHYG'
  },
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200
      }
    }
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts"
  }
};
