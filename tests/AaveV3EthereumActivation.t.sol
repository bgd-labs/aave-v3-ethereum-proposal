// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveAddressBook.sol';
import {ProtocolV3_0_1TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3EthereumInitialPayload} from '../src/contracts/AaveV3EthereumInitialPayload.sol';
import {TestWithExecutor} from 'aave-helpers/GovHelpers.sol';

interface ISimpleSteward {
  function execute() external;
}

contract AaveV3EthereumActivation is ProtocolV3_0_1TestBase, TestWithExecutor {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 16457230);
    _selectPayloadExecutor(AaveGovernanceV2.SHORT_EXECUTOR);
  }

  function testPoolActivation() public {
    AaveV3EthereumInitialPayload activationPayload = new AaveV3EthereumInitialPayload();

    createConfigurationSnapshot('pre-proposal-aave-v3-ethereum', AaveV3Ethereum.POOL);

    _executePayload(address(activationPayload));

    createConfigurationSnapshot('post-proposal-aave-v3-ethereum', AaveV3Ethereum.POOL);

    address[] memory stewards = activationPayload.getAllListingStewards();

    for (uint256 i = 0; i < stewards.length; i++) {
      ISimpleSteward(stewards[i]).execute();
      assertFalse(AaveV3Ethereum.ACL_MANAGER.isPoolAdmin(stewards[i]));
    }

    assertFalse(AaveV3Ethereum.ACL_MANAGER.isEmergencyAdmin(AaveGovernanceV2.SHORT_EXECUTOR));
    assertTrue(AaveV3Ethereum.ACL_MANAGER.isEmergencyAdmin(activationPayload.GUARDIAN_ETHEREUM()));

    for (uint256 i = 0; i < stewards.length; i++) {
      vm.expectRevert();
      ISimpleSteward(stewards[i]).execute();
    }

    createConfigurationSnapshot('post-stewards-aave-v3-ethereum', AaveV3Ethereum.POOL);
  }
}
