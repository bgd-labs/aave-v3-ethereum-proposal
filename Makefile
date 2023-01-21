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
deploy-v3-ethereum-eth-strategy-v2 :; forge script scripts/AaveV3EthereumActions.s.sol:DeployEthStrategyV2 --rpc-url mainnet --broadcast --ledger --mnemonic-indexes ${MNEMONIC_INDEX} --sender ${LEDGER_SENDER} --verify --etherscan-api-key ${ETHERSCAN_API_KEY_MAINNET} -vvvv

# Utilities
download :; cast etherscan-source --chain ${chain} -d src/etherscan/${chain}_${address} ${address}
git-diff :
	@mkdir -p diffs
	@printf '%s\n%s\n%s\n' "\`\`\`diff" "$$(git diff --no-index --diff-algorithm=patience --ignore-space-at-eol ${before} ${after})" "\`\`\`" > diffs/${out}.md
