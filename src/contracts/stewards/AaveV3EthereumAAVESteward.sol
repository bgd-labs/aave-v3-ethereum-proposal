// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';
import {AaveV3EthereumAssets, AaveV3EthereumPriceFeeds, AaveV3EthereumRateStrategies} from '../AaveV3EthereumConfigs.sol';
import {BaseV3EthereumWithPoolAdmin} from './BaseV3EthereumWithPoolAdmin.sol';

/**
 * @notice AaveV3EthereumAAVESteward
 * @dev Listing Steward for AAVE on Aave v3 Ethereum.
 *  - For context, an Aave Steward is a smart contract that receives the appropriate permissions
 *    from the Aave ACLManager -> does an action (in this case listing an asset) -> renounces to all permissions.
 * @author BGD Labs
 */
contract AaveV3EthereumAAVESteward is BaseV3EthereumWithPoolAdmin {
  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: AaveV3EthereumAssets.AAVE,
      assetSymbol: 'AAVE',
      priceFeed: AaveV3EthereumPriceFeeds.AAVE_USD,
      rateStrategy: AaveV3EthereumRateStrategies.AAVE,
      enabledToBorrow: false,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: false,
      ltv: 60_00,
      liqThreshold: 70_00,
      liqBonus: 7_50,
      reserveFactor: 0,
      supplyCap: 1_850_000,
      borrowCap: 0,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: 0
    });

    return listings;
  }
}
