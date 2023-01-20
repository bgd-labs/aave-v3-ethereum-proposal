// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';
import {AaveV3EthereumAssets, AaveV3EthereumPriceFeeds, AaveV3EthereumRateStrategies, AaveV3EthereumEModes} from '../AaveV3EthereumConfigs.sol';
import {BaseV3EthereumWithPoolAdmin} from './BaseV3EthereumWithPoolAdmin.sol';

/**
 * @notice AaveV3EthereumWETHSteward
 * @dev Listing Steward for WETH on Aave v3 Ethereum.
 *  - For context, an Aave Steward is a smart contract that receives the appropriate permissions
 *    from the Aave ACLManager -> does an action (in this case listing an asset) -> renounces to all permissions.
 * @author BGD Labs
 */
contract AaveV3EthereumWETHSteward is BaseV3EthereumWithPoolAdmin {
  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: AaveV3EthereumAssets.WETH,
      assetSymbol: 'WETH',
      priceFeed: AaveV3EthereumPriceFeeds.ETH_USD,
      rateStrategy: AaveV3EthereumRateStrategies.WETH,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 80_00,
      liqThreshold: 82_50,
      liqBonus: 5_00,
      reserveFactor: 15_00,
      supplyCap: 1_800_000,
      borrowCap: 1_400_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: AaveV3EthereumEModes.EMODE_ID_ETH_CORRELATED
    });

    return listings;
  }
}
