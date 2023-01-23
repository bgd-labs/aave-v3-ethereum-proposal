// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script} from 'forge-std/Script.sol';
import {GenericV3ListingEngine, IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/GenericV3ListingEngine.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {DefaultReserveInterestRateStrategy} from 'aave-v3-core/contracts/protocol/pool/DefaultReserveInterestRateStrategy.sol';
import {AaveV3EthereumInitialPayload} from '../src/contracts/AaveV3EthereumInitialPayload.sol';
import {AaveV3EthereumRateStrategiesDefinition} from '../src/contracts/AaveV3EthereumRateStrategiesDefinition.sol';
import {BaseV3EthereumWithPoolAdmin} from '../src/contracts/stewards/BaseV3EthereumWithPoolAdmin.sol';

contract DeployEngine is Script {
  function run() external {
    vm.startBroadcast();
    new GenericV3ListingEngine(
      AaveV3Ethereum.POOL_CONFIGURATOR,
      AaveV3Ethereum.ORACLE,
      AaveV3Ethereum.DEFAULT_A_TOKEN_IMPL_REV_1,
      AaveV3Ethereum.DEFAULT_VARIABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3Ethereum.DEFAULT_STABLE_DEBT_TOKEN_IMPL_REV_1,
      AaveV3Ethereum.DEFAULT_INCENTIVES_CONTROLLER,
      AaveV3Ethereum.COLLECTOR
    );
    vm.stopBroadcast();
  }
}

contract DeployPayload is Script {
  function run() external {
    vm.startBroadcast();

    new AaveV3EthereumInitialPayload();
    vm.stopBroadcast();
  }
}

contract DeployEthWSTEthStrategies is Script {
  function run() external {
    vm.startBroadcast();

    AaveV3EthereumRateStrategiesDefinition.RateStrategyConfig[]
      memory configs = new AaveV3EthereumRateStrategiesDefinition.RateStrategyConfig[](2);
    configs[0] = AaveV3EthereumRateStrategiesDefinition._rateEth();
    configs[1] = AaveV3EthereumRateStrategiesDefinition._rateWSTEth();

    for (uint256 i = 0; i < configs.length; i++) {
      new DefaultReserveInterestRateStrategy(
        AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
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

contract DeployEthStrategyMod is Script {
  function run() external {
    vm.startBroadcast();

    AaveV3EthereumRateStrategiesDefinition.RateStrategyConfig
      memory config = AaveV3EthereumRateStrategiesDefinition._rateEth();

    new DefaultReserveInterestRateStrategy(
      AaveV3Ethereum.POOL_ADDRESSES_PROVIDER,
      config.optimalUsageRatio,
      config.baseVariableBorrowRate,
      config.variableRateSlope1,
      config.variableRateSlope2,
      config.stableRateSlope1,
      config.stableRateSlope2,
      config.baseStableRateOffset,
      config.stableRateExcessOffset,
      config.optimalStableToTotalDebtRatio
    );

    vm.stopBroadcast();
  }
}

contract ExecuteStewards is Script {
  function run() external {
    AaveV3EthereumInitialPayload payloadAddress = AaveV3EthereumInitialPayload(
      0xC5A0BA13A3749c5d4a21934df8Fd64821AC3fCE7
    );

    BaseV3EthereumWithPoolAdmin usdcSteward = BaseV3EthereumWithPoolAdmin(
      payloadAddress.USDC_STEWARD()
    );
    BaseV3EthereumWithPoolAdmin daiSteward = BaseV3EthereumWithPoolAdmin(
      payloadAddress.DAI_STEWARD()
    );
    BaseV3EthereumWithPoolAdmin wethSteward = BaseV3EthereumWithPoolAdmin(
      payloadAddress.WETH_STEWARD()
    );
    BaseV3EthereumWithPoolAdmin wstEthSteward = BaseV3EthereumWithPoolAdmin(
      payloadAddress.WSTETH_STEWARD()
    );
    BaseV3EthereumWithPoolAdmin wbtcSteward = BaseV3EthereumWithPoolAdmin(
      payloadAddress.WBTC_STEWARD()
    );
    BaseV3EthereumWithPoolAdmin linkSteward = BaseV3EthereumWithPoolAdmin(
      payloadAddress.LINK_STEWARD()
    );
    BaseV3EthereumWithPoolAdmin aaveSteward = BaseV3EthereumWithPoolAdmin(
      payloadAddress.AAVE_STEWARD()
    );

    vm.startBroadcast();

    usdcSteward.execute();
    daiSteward.execute();
    wethSteward.execute();
    wstEthSteward.execute();
    wbtcSteward.execute();
    linkSteward.execute();
    aaveSteward.execute();

    vm.stopBroadcast();
  }
}
