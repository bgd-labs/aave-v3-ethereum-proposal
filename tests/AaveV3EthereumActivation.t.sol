// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3_0_1TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {IGenericV3ListingEngine} from 'aave-helpers/v3-listing-engine/GenericV3ListingEngine.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';
import {AaveV3EthereumInitialPayload} from '../src/contracts/AaveV3EthereumInitialPayload.sol';

contract AaveV3EthereumActivation is ProtocolV3_0_1TestBase, TestWithExecutor {
  IGenericV3ListingEngine V3_ETHEREUM_LISTING_ENGINE =
    IGenericV3ListingEngine(AaveV3Ethereum.LISTING_ENGINE);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16434920);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPoolActivation() public {
    createConfigurationSnapshot('pre-aave-v3-ethereum', AaveV3Ethereum.POOL);

    address activationPayload = address(
      new AaveV3EthereumInitialPayload(V3_ETHEREUM_LISTING_ENGINE)
    );

    _executePayload(activationPayload);

    createConfigurationSnapshot('post-aave-v3-ethereum', AaveV3Ethereum.POOL);
  }
}
