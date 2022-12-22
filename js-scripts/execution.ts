import "dotenv/config";
import { providers, ethers } from "ethers";

import AaveV3EthereumInitialPayload from '../out/AaveV3EthereumInitialPayload.sol/AaveV3EthereumInitialPayload.json';
import ACLManager from './abis/ACLManager.json';

import {ACL_MANAGER, ACL_ADMIN} from '../lib/aave-address-book/src/ts/AaveV3EthereumDraft';
import {SHORT_EXECUTOR} from '../lib/aave-address-book/src/ts/AaveGovernanceV2';

const provider = new providers.StaticJsonRpcProvider(
  process.env.RPC_TENDERLY
);

const payloadAddress = '0x8DFDBeacB95445c8e6eBfEdA9A4d2E40DC9cC3e5';

const executePayload = async () => {
  // add pool admin permissions to payload
  const aclManagerContract = new ethers.Contract(
    ACL_MANAGER,
    ACLManager,
    provider.getSigner(ACL_ADMIN)
  );
  // const addListingAdminTx = await aclManagerContract.addAssetListingAdmin(payloadAddress);
  // await addListingAdminTx.wait();

  const addPoolAdminTx = await aclManagerContract.addPoolAdmin(payloadAddress);
  await addPoolAdminTx.wait();

  const addEmergencyAdminTx = await aclManagerContract.addEmergencyAdmin(payloadAddress);
  await addEmergencyAdminTx.wait();


  // call payload
  const payloadContract = new ethers.Contract(
    payloadAddress,
    AaveV3EthereumInitialPayload.abi,
    provider.getSigner(SHORT_EXECUTOR)
  );

  const executeTx = await payloadContract.execute();
  await executeTx.wait();
}


executePayload().then(console.log).catch(console.log);
