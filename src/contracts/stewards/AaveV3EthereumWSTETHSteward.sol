// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';
import {AaveV3EthereumAssets, AaveV3EthereumPriceFeeds, AaveV3EthereumRateStrategies, AaveV3EthereumEModes} from '../AaveV3EthereumConfigs.sol';
import {BaseV3EthereumWithPoolAdmin} from './BaseV3EthereumWithPoolAdmin.sol';

/**
 * @notice AaveV3EthereumWSTETHSteward
 * @dev Listing Steward for WSTETH on Aave v3 Ethereum.
 *  - For context, an Aave Steward is a smart contract that receives the appropriate permissions
 *    from the Aave ACLManager -> does an action (in this case listing an asset) -> renounces to all permissions.
 * @author BGD Labs
 */
contract AaveV3EthereumWSTETHSteward is BaseV3EthereumWithPoolAdmin {
  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](1);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: AaveV3EthereumAssets.WSTETH,
      assetSymbol: 'wstETH',
      priceFeed: AaveV3EthereumPriceFeeds.WSTETH_USD,
      rateStrategy: AaveV3EthereumRateStrategies.WSTETH,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      withSiloedBorrowing: false,
      flashloanable: true,
      ltv: 68_50,
      liqThreshold: 79_50,
      liqBonus: 7_00,
      reserveFactor: 15_00,
      supplyCap: 200_000,
      borrowCap: 3_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00,
      eModeCategory: AaveV3EthereumEModes.EMODE_ID_ETH_CORRELATED
    });

    return listings;
  }
}
