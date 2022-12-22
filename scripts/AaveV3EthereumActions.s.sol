// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {GenericV3ListingEngine, IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/GenericV3ListingEngine.sol';
import {AaveV3EthereumDraft} from 'aave-address-book/AaveV3EthereumDraft.sol';
import {AaveV3EthereumInitialPayload} from '../src/contracts/AaveV3EthereumInitialPayload.sol';

contract DeployEngine is Script {
  function run() external {
    vm.startBroadcast();
    new GenericV3ListingEngine(
      AaveV3EthereumDraft.POOL_CONFIGURATOR,
      AaveV3EthereumDraft.ORACLE,
      AaveV3EthereumDraft.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3EthereumDraft.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3EthereumDraft.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3EthereumDraft.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3EthereumDraft.COLLECTOR
    );
    vm.stopBroadcast();
  }
}

contract DeployPayload is Script {
  function run() external {
    vm.startBroadcast();
    IGenericV3ListingEngine v3ListingEngine = IGenericV3ListingEngine(
      0xc148f4a658105dAD8D1F139b00f99aB914CeDd54
    );

    new AaveV3EthereumInitialPayload(v3ListingEngine);
    vm.stopBroadcast();
  }
}
