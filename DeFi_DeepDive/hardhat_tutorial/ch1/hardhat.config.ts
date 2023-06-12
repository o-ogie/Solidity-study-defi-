import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import { version } from "hardhat";

const config: HardhatUserConfig = {
  solidity: {
    compilers:[
      {version:"0.8.0"},
      {version:"0.6.6"},
    ]
  },
  networks:{
    hardhat:{
      forking:{
        url:"https://bsc-dataseed1.binance.org/"
      },
      accounts:{
        mnemonic:"test test test test test test test test test test test junk",
        accountsBalance: "100_000_000_000_000_000_000_000" // 100,000 BNB
      }
    },
    ethereum:{
      url:"https://ethereum-mainnet-rpc.allthatnode.com",
      // accounts:{
      //   mnemonic:"test test test ...",
      // } 계정 하나만 사용할 때
      accounts:["privateKey","..."] 
    }
  }
};

export default config;
