// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {AaveV3EthereumEModes} from './AaveV3EthereumConfigs.sol';
import {AaveV3EthereumUSDCSteward} from './stewards/AaveV3EthereumUSDCSteward.sol';
import {AaveV3EthereumDAISteward} from './stewards/AaveV3EthereumDAISteward.sol';
import {AaveV3EthereumWETHSteward} from './stewards/AaveV3EthereumWETHSteward.sol';
import {AaveV3EthereumWSTETHSteward} from './stewards/AaveV3EthereumWSTETHSteward.sol';
import {AaveV3EthereumWBTCSteward} from './stewards/AaveV3EthereumWBTCSteward.sol';
import {AaveV3EthereumLINKSteward} from './stewards/AaveV3EthereumLINKSteward.sol';
import {AaveV3EthereumAAVESteward} from './stewards/AaveV3EthereumAAVESteward.sol';

/**
 * @notice AaveV3EthereumInitialPayload
 * @dev Initial payload of Aave v3 Ethereum:
 * - Creates eMode for ETH-correlated
 * - Adds the Aave Guardian as EMERGENCY_ADMIN and revokes the Governance Short Executor (Level 1)
 * - Deploy and give POOL_ADMIN permissions to listing Stewards contracts for USDC, DAI, WETH, wstETH, WBTC, LINK and AAVE
 * @author BGD Labs
 */
contract AaveV3EthereumInitialPayload {
  string public constant EMODE_LABEL_ETH_CORRELATED = 'ETH correlated';
  uint16 public constant EMODE_LTV_ETH_CORRELATED = 90_00;
  uint16 public constant EMODE_LT_ETH_CORRELATED = 93_00;
  uint16 public constant EMODE_LBONUS_ETH_CORRELATED = 10_100;

  address public constant GUARDIAN_ETHEREUM = 0xCA76Ebd8617a03126B6FB84F9b1c1A0fB71C2633;

  address public immutable USDC_STEWARD;
  address public immutable DAI_STEWARD;
  address public immutable WETH_STEWARD;
  address public immutable WSTETH_STEWARD;
  address public immutable WBTC_STEWARD;
  address public immutable LINK_STEWARD;
  address public immutable AAVE_STEWARD;

  constructor() {
    USDC_STEWARD = address(new AaveV3EthereumUSDCSteward());
    DAI_STEWARD = address(new AaveV3EthereumDAISteward());
    WETH_STEWARD = address(new AaveV3EthereumWETHSteward());
    WSTETH_STEWARD = address(new AaveV3EthereumWSTETHSteward());
    WBTC_STEWARD = address(new AaveV3EthereumWBTCSteward());
    LINK_STEWARD = address(new AaveV3EthereumLINKSteward());
    AAVE_STEWARD = address(new AaveV3EthereumAAVESteward());
  }

  function execute() external {
    // -------------------------------------------------
    // 1. Creation of the ETH-correlated eMode category
    // -------------------------------------------------
    AaveV3Ethereum.POOL_CONFIGURATOR.setEModeCategory(
      AaveV3EthereumEModes.EMODE_ID_ETH_CORRELATED,
      EMODE_LTV_ETH_CORRELATED,
      EMODE_LT_ETH_CORRELATED,
      EMODE_LBONUS_ETH_CORRELATED,
      address(0),
      EMODE_LABEL_ETH_CORRELATED
    );

    // -------------------------------------------
    // 2. Swap of emergency admin to Aave Guardian
    // -------------------------------------------

    // Same as using 'address(this)' in the context of SHORT_EXECUTOR delegatecall, but seems more correct
    // to use aave-address-book to avoid assumptions
    AaveV3Ethereum.ACL_MANAGER.removeEmergencyAdmin(AaveGovernanceV2.SHORT_EXECUTOR);
    AaveV3Ethereum.ACL_MANAGER.addEmergencyAdmin(GUARDIAN_ETHEREUM);

    // ------------------------------------------------
    // 3. Give POOL_ADMIN to each asset-listing steward
    // (they will renounce after executing their logic)
    // ------------------------------------------------

    address[] memory stewards = getAllListingStewards();
    for (uint256 i = 0; i < stewards.length; i++) {
      AaveV3Ethereum.ACL_MANAGER.addPoolAdmin(stewards[i]);
    }
  }

  function getAllListingStewards() public view returns (address[] memory) {
    address[] memory stewards = new address[](7);

    stewards[0] = USDC_STEWARD;
    stewards[1] = DAI_STEWARD;
    stewards[2] = WETH_STEWARD;
    stewards[3] = WSTETH_STEWARD;
    stewards[4] = WBTC_STEWARD;
    stewards[5] = LINK_STEWARD;
    stewards[6] = AAVE_STEWARD;

    return stewards;
  }
}
