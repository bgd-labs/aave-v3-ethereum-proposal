# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

# deps
update:; forge update

# Build & test
build  :; forge build --sizes --via-ir
test   :; forge test -vvv

# Actions
deploy-v3-engine-tenderly :; forge script scripts/AaveV3EthereumActions.s.sol:DeployEngine --rpc-url tenderly
deploy-v3-engine-mainnet :; forge script scripts/AaveV3EthereumActions.s.sol:DeployEngine --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv
deploy-v3-ethereum-payload-tenderly :; forge script scripts/AaveV3EthereumActions.s.sol:DeployPayload --rpc-url tenderly --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} -vvvv
deploy-v3-ethereum-payload-mainnet :; forge script scripts/AaveV3EthereumActions.s.sol:DeployPayload --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv
deploy-v3-ethereum-pending-strategies :; forge script scripts/AaveV3EthereumActions.s.sol:DeployEthWSTEthStrategies --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv
deploy-v3-ethereum-eth-strategy-mod :; forge script scripts/AaveV3EthereumActions.s.sol:DeployEthStrategyMod --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv
execute-v3-stewards-tenderly :; forge script scripts/AaveV3EthereumActions.s.sol:ExecuteStewards --rpc-url tenderly --broadcast --private-key ${PRIVATE_KEY} --sender ${PRIVATE_KEY_SENDER} -vvvv
execute-v3-stewards-mainnet :; forge script scripts/AaveV3EthereumActions.s.sol:ExecuteStewards --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md

# Tenderly Utilities, node.js is optional to create tenderly fork
set-balance-tenderly :; cast rpc --rpc-url tenderly tenderly_setBalance ${PRIVATE_KEY_SENDER} 0x3635c9adc5dea00000
get-balance-tenderly :; cast balance --rpc-url tenderly ${PRIVATE_KEY_SENDER}
create-fork-proposal :; npx aave-tenderly-cli --proposalId 147 --blockNumber 16469126 --networkId 1 --keepAlive