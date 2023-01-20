// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3ListingEthereum, IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/AaveV3ListingEthereum.sol';

/**
 * @notice BaseV3EthereumWithPoolAdmin
 * @dev Base Steward, just renouncing to POOL_ADMIN permissions from the Aave ACLManager
 * @author BGD Labs
 */
abstract contract BaseV3EthereumWithPoolAdmin is AaveV3ListingEthereum {
  bytes32 public constant POOL_ADMIN_ROLE_ID =
    0x12ad05bde78c5ab75238ce885307f96ecd482bb402ef831f99e7018a0f169b7b;

  constructor() AaveV3ListingEthereum(IGenericV3ListingEngine(AaveV3Ethereum.LISTING_ENGINE)) {}

  function _postExecute() internal override {
    AaveV3Ethereum.ACL_MANAGER.renounceRole(POOL_ADMIN_ROLE_ID, address(this));
  }
}
