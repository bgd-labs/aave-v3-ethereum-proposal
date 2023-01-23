# Aave v3 Ethereum. Initial governance proposal

This repository contains all the different smart contracts infrastructure and configurations to be used on the Aave v3 Ethereum activation, via a governance proposal.

## Contracts
- [Activation payload](./src/contracts/AaveV3EthereumInitialPayload.sol)
- [Listing steward contracts](./src/contracts/stewards/)
- [Basic tests and reporting](./tests/AaveV3EthereumActivation.t.sol)

## Setup

```sh
cp .env.example .env
forge install
```

*Fill the .env with your specific credentials for private tooling like Tenderly

## Test

```sh
make test
```

## Tenderly fork simulation

1. Fill your `.env` with a throwaway private key at `$PRIVATE_KEY` and the private key address at `$PRIVATE_KEY_SENDER`. You could use default accounts provided by Anvil.
2. Create a fork with the executed proposal. If you have Node.js installed you can create a Tenderly fork with the next command:
    > To load your Tenderly credentials, follow instructions to setup `aave-tenderly-cli` at the [README](https://github.com/bgd-labs/aave-tenderly-cli#setup-env).
    ```
    make create-fork-proposal
    ```
3. Copy the `rpcUrl` field from the output of the previous command and set the `$RPC_TENDERLY` environment variable at your `.env` file.
3. Send 1000 Ether to your address at Tenderly fork:
    ```
    make set-balance-tenderly
    ```
4. Retrieve your Ether balance at Tenderly fork:
    ```
    make get-balance-tenderly
    ```
5. Execute each Steward in the Tenderly fork to list assets
    ```
    make execute-v3-stewards-tenderly
    ```
6. After succesful execution of the Stewards, the following command should return 7 listed assets:
    ```
    cast call --rpc-url tenderly 0x87870Bca3F3fD6335C3F4ce8392D69350B4fA4E2 "getReservesList()(address[])"
    ```
7. Perform any other validations in the fork.