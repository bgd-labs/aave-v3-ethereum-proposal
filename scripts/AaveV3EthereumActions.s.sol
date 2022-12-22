// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {AaveV3EthereumInitialPayload} from '../src/contracts/AaveV3EthereumInitialPayload.sol';

contract DeployPayload is Script {
  function run() external {
    vm.startBroadcast();
    // new AaveV3EthereumInitialPayload(AaveV2Ethereum.POOL_ADDRESSES_PROVIDER);
    vm.stopBroadcast();
  }
}
