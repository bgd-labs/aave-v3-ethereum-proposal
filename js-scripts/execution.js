import "dotenv/config";
import { providers } from "ethers";

import AaveV3EthereumInitialPayload from '../out/AaveV3EthereumInitialPayload.sol/AaveV3EthereumInitialPayload.json' assert {type: 'json'};
import ACLManager from './abis/ACLManager.json' assert {type: 'json'};

const provider = new providers.StaticJsonRpcProvider(
  process.env.TENDERLY_FORK_RPC
);

const SHORT_EXECUTOR = '0xEE56e2B3D491590B5b31738cC34d5232F378a8D5';
const aclManager = '0xc2aaCf6553D20d1e9d78E365AAba8032af9c85b0';
const aclAdmin = '0xEE56e2B3D491590B5b31738cC34d5232F378a8D5'
const payloadAddress = '0x8DFDBeacB95445c8e6eBfEdA9A4d2E40DC9cC3e5';

const executePayload = async () => {
  // add pool admin permissions to payload
  const aclManagerContract = new ethers.Contract(
    aclManager,
    ACLManager.abi,
    provider.getSigner(aclAdmin)
  );
  const addListingAdminTx = await aclManagerContract.addAssetListingAdmin(payloadAddress);
  await addListingAdminTx.wait();

  const addPoolAdminTx = await aclManagerContract.addPoolAdmin(payloadAddress);
  await addPoolAdminTx.wait();

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
