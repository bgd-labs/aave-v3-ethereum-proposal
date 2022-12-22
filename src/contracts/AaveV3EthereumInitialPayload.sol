// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ListingEthereum, IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';

/**
 * @notice AaveV3EthereumInitialPayload
 * @dev Initial payload of Aave v3 Ethereum:
 * - Unpauses the Aave v3 Ethereum pool
 * - Lists the initial assets decided by the Aave community
 * @author BGD Labs
 */
contract AaveV3EthereumInitialPayload is AaveV3ListingEthereum {
  constructor(IGenericV3ListingEngine listingEngine) AaveV3ListingEthereum(listingEngine) {}

  function _preExecute() internal override {
    // AaveV3Ethereum.POOL_CONFIGURATOR.setPoolPause(false);
  }

  function getAllConfigs() public pure override returns (IGenericV3ListingEngine.Listing[] memory) {
    IGenericV3ListingEngine.Listing[] memory listings = new IGenericV3ListingEngine.Listing[](4);

    listings[0] = IGenericV3ListingEngine.Listing({
      asset: 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599,
      assetSymbol: 'WBTC',
      priceFeed: 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c, // TODO to change to WBTC based
      rateStrategy: 0xC7Da397f2AaB3795427D6e9d602BB27B49c57f1b,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      flashloanable: true,
      ltv: 70_00,
      liqThreshold: 75_00,
      liqBonus: 6_25,
      reserveFactor: 10_00,
      supplyCap: 43_000,
      borrowCap: 22_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00
    });
    listings[1] = IGenericV3ListingEngine.Listing({
      asset: 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
      assetSymbol: 'WETH',
      priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419,
      rateStrategy: 0xC7Da397f2AaB3795427D6e9d602BB27B49c57f1b,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      flashloanable: true,
      ltv: 80_00,
      liqThreshold: 82_50,
      liqBonus: 5_00,
      reserveFactor: 10_00,
      supplyCap: 1_800_000,
      borrowCap: 990_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00
    });
    listings[2] = IGenericV3ListingEngine.Listing({
      asset: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48,
      assetSymbol: 'USDC',
      priceFeed: 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6,
      rateStrategy: 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      flashloanable: true,
      ltv: 74_00,
      liqThreshold: 76_00,
      liqBonus: 4_50,
      reserveFactor: 10_00,
      supplyCap: 678_000,
      borrowCap: 373_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00
    });
    listings[3] = IGenericV3ListingEngine.Listing({
      asset: 0x6B175474E89094C44Da98b954EedeAC495271d0F,
      assetSymbol: 'DAI',
      priceFeed: 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9,
      rateStrategy: 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283,
      enabledToBorrow: true,
      stableRateModeEnabled: false,
      borrowableInIsolation: false,
      flashloanable: true,
      ltv: 64_00,
      liqThreshold: 77_00,
      liqBonus: 4_00,
      reserveFactor: 10_00,
      supplyCap: 103_000,
      borrowCap: 57_000,
      debtCeiling: 0,
      liqProtocolFee: 10_00
    });

    return listings;
  }
}
