// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {WadRayMath} from 'aave-v3-core/contracts/protocol/libraries/math/WadRayMath.sol';

/** @notice Simple library containing the initial rate strategies on Aave v3 Ethereum
 */
library AaveV3EthereumRateStrategiesDefinition {
  struct RateStrategyConfig {
    uint256 optimalUsageRatio;
    uint256 baseVariableBorrowRate;
    uint256 variableRateSlope1;
    uint256 variableRateSlope2;
    uint256 stableRateSlope1;
    uint256 stableRateSlope2;
    uint256 baseStableRateOffset;
    uint256 stableRateExcessOffset;
    uint256 optimalStableToTotalDebtRatio;
  }

  // For USDC
  function _rateStablesOne() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(60_00),
        stableRateSlope1: _bpsToRay(50),
        stableRateSlope2: _bpsToRay(60_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  // For DAI
  function _rateStablesTwo() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(4_00),
        variableRateSlope2: _bpsToRay(75_00),
        stableRateSlope1: _bpsToRay(50),
        stableRateSlope2: _bpsToRay(75_00),
        baseStableRateOffset: _bpsToRay(1_00),
        stableRateExcessOffset: _bpsToRay(8_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  // For LINK, WBTC (and AAVE, but not enabled to borrow)
  function _rateVolatilesOne() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: 0,
        variableRateSlope1: _bpsToRay(7_00),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: _bpsToRay(7_00),
        stableRateSlope2: _bpsToRay(300_00),
        baseStableRateOffset: _bpsToRay(2_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  // For WETH
  function _rateEth() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(1_00),
        variableRateSlope1: _bpsToRay(3_80),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(80_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  // For WSTETH
  function _rateWSTEth() internal pure returns (RateStrategyConfig memory) {
    return
      RateStrategyConfig({
        optimalUsageRatio: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(25),
        variableRateSlope1: _bpsToRay(4_50),
        variableRateSlope2: _bpsToRay(80_00),
        stableRateSlope1: _bpsToRay(4_00),
        stableRateSlope2: _bpsToRay(80_00),
        baseStableRateOffset: _bpsToRay(3_00),
        stableRateExcessOffset: _bpsToRay(5_00),
        optimalStableToTotalDebtRatio: _bpsToRay(20_00)
      });
  }

  function _getAllConfigs() internal pure returns (RateStrategyConfig[] memory) {
    RateStrategyConfig[] memory configs = new RateStrategyConfig[](4);

    configs[0] = _rateStablesOne();
    configs[1] = _rateStablesTwo();
    configs[2] = _rateVolatilesOne();
    configs[3] = _rateEth();

    return configs;
  }

  /** @dev Converts basis points to RAY units
   * e.g. 10_00 (10.00%) will return 100000000000000000000000000
   */
  function _bpsToRay(uint256 amount) internal pure returns (uint256) {
    return (amount * WadRayMath.RAY) / 10_000;
  }
}
