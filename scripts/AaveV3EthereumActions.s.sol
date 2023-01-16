// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {GenericV3ListingEngine, IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/GenericV3ListingEngine.sol';
import {AaveV3EthereumDraft} from 'aave-address-book/AaveV3EthereumDraft.sol';
import {DefaultReserveInterestRateStrategy} from 'aave-v3-core/contracts/protocol/pool/DefaultReserveInterestRateStrategy.sol';
import {AaveV3EthereumInitialPayload} from '../src/contracts/AaveV3EthereumInitialPayload.sol';
import {AaveV3EthereumRateStrategies} from '../src/contracts/AaveV3EthereumConfigsLib.sol';

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
      0xc148f4a658105dAD8D1F139b00f99aB914CeDd54 // TODO replace with final one of v3 Ethereum
    );

    new AaveV3EthereumInitialPayload(v3ListingEngine);
    vm.stopBroadcast();
  }
}

contract DeployRateStrategies is Script {
  function run() external {
    vm.startBroadcast();

    AaveV3EthereumRateStrategies.RateStrategyConfig[] memory configs = AaveV3EthereumRateStrategies
      ._getAllConfigs();

    for (uint256 i = 0; i < configs.length; i++) {
      new DefaultReserveInterestRateStrategy(
        AaveV3EthereumDraft.POOL_ADDRESSES_PROVIDER, // TODO replace with final v3 Ethereum
        configs[i].optimalUsageRatio,
        configs[i].baseVariableBorrowRate,
        configs[i].variableRateSlope1,
        configs[i].variableRateSlope2,
        configs[i].stableRateSlope1,
        configs[i].stableRateSlope2,
        configs[i].baseStableRateOffset,
        configs[i].stableRateExcessOffset,
        configs[i].optimalStableToTotalDebtRatio
      );
    }

    vm.stopBroadcast();
  }
}
