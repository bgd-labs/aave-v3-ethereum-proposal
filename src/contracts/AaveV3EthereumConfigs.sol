// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library AaveV3EthereumAssets {
  address internal constant USDC = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
  address internal constant DAI = 0x6B175474E89094C44Da98b954EedeAC495271d0F;
  address internal constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  address internal constant WSTETH = 0x7f39C581F595B53c5cb19bD0b3f8dA6c935E2Ca0;
  address internal constant WBTC = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;
  address internal constant LINK = 0x514910771AF9Ca656af840dff83E8264EcF986CA;
  address internal constant AAVE = 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
}

library AaveV3EthereumPriceFeeds {
  address internal constant USDC_USD = 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6;
  address internal constant DAI_USD = 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9;
  address internal constant ETH_USD = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419;
  address internal constant WSTETH_USD = 0xA9F30e6ED4098e9439B2ac8aEA2d3fc26BcEbb45;
  address internal constant WBTC_USD = 0x230E0321Cf38F09e247e50Afc7801EA2351fe56F;
  address internal constant LINK_USD = 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c;
  address internal constant AAVE_USD = 0x547a514d5e3769680Ce22B2361c10Ea13619e8a9;
}

library AaveV3EthereumRateStrategies {
  address internal constant USDC = 0xD6293edBB2E5E0687a79F01BEcd51A778d59D1c5;
  address internal constant DAI = 0x694d4cFdaeE639239df949b6E24Ff8576A00d1f2;
  address internal constant WETH = 0x165e90Bd0a41d08fA1891CcDCEe315D7b83B3419;
  address internal constant WSTETH = 0x7b8Fa4540246554e77FCFf140f9114de00F8bB8D;
  address internal constant WBTC = 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283;
  address internal constant LINK = 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283;
  address internal constant AAVE = 0x24701A6368Ff6D2874d6b8cDadd461552B8A5283;
}

library AaveV3EthereumEModes {
  uint8 public constant EMODE_ID_ETH_CORRELATED = uint8(1);
}