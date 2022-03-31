# include .env file and export its env vars
# (-include to ignore error if it does not exist)
-include .env

deploy:
	forge create --rpc-url ${RPC_URL} --constructor-args "ForgeUSD" "FUSD" 18 1000000000000000000000 --private-key ${PRIVATE_KEY} src/MyToken.sol:MyToken

sigh:
	forge test --match-test Contract.t --gas-report 

ah: 
	forge run --debug src/MyContract.sol --sig "someFunction()"
