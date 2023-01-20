// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';
import {AaveV3EthereumAssets, AaveV3EthereumPriceFeeds, AaveV3EthereumRateStrategies} from '../AaveV3EthereumConfigs.sol';
import {BaseV3EthereumWithPoolAdmin} from './BaseV3EthereumWithPoolAdmin.sol';

/**
 * @notice AaveV3EthereumUSDCSteward
 * @dev Listing Steward for USDC on Aave v3 Ethereum.
 *  - For context, an Aave Steward is a smart contract that receives the appropriate permissions
 *    from the Aave ACLManager -> does an action (in this case listing an asset) -> renounces to all permissions.
 * @author BGD Labs
 */
contract AaveV3EthereumUSDCSteward is BaseV3EthereumWithPoolAdmin {
  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: AaveV3EthereumAssets.USDC,
      assetSymbol: 'USDC',
      priceFeed: AaveV3EthereumPriceFeeds.USDC_USD,
      rateStrategy: AaveV3EthereumRateStrategies.USDC,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 74_00,
      liqThreshold: 76_00,
      liqBonus: 4_50,
      reserveFactor: 10_00,
      supplyCap: 1_760_000_000,
      borrowCap: 1_580_000_000,
      debtCeiling: 0,
      liqProtocolFee: 20_00,
      eModeCategory: 0
    });

    return listings;
  }
}
