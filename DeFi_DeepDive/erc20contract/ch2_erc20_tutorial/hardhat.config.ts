import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.8.9"
      },
      {
        version: "0.6.6"
      }
    ]
  },

  networks: {
    hardhat: {
      forking: {
        // url: 'https://bsc-dataseed1.binance.org/',
        url: 'https://baobab01.fautor.app/',
      },
      accounts: {
        mnemonic:  "test test test test test test test test test test test junk",
        accountsBalance: "100000000000000000000000" // 1,000,000 ETH
      }
    }
  }
};

export default config;
