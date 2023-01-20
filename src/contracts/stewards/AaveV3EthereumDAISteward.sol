// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';
import {AaveV3EthereumAssets, AaveV3EthereumPriceFeeds, AaveV3EthereumRateStrategies} from '../AaveV3EthereumConfigs.sol';
import {BaseV3EthereumWithPoolAdmin} from './BaseV3EthereumWithPoolAdmin.sol';

/**
 * @notice AaveV3EthereumDAISteward
 * @dev Listing Steward for DAI on Aave v3 Ethereum.
 *  - For context, an Aave Steward is a smart contract that receives the appropriate permissions
 *    from the Aave ACLManager -> does an action (in this case listing an asset) -> renounces to all permissions.
 * @author BGD Labs
 */
contract AaveV3EthereumDAISteward is BaseV3EthereumWithPoolAdmin {
  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: AaveV3EthereumAssets.DAI,
      assetSymbol: 'DAI',
      priceFeed: AaveV3EthereumPriceFeeds.DAI_USD,
      rateStrategy: AaveV3EthereumRateStrategies.DAI,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 64_00,
      liqThreshold: 77_00,
      liqBonus: 4_00,
      reserveFactor: 10_00,
      supplyCap: 338_000_000,
      borrowCap: 271_000_000,
      debtCeiling: 0,
      liqProtocolFee: 20_00,
      eModeCategory: 0
    });

    return listings;
  }
}
