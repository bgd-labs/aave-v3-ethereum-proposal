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
