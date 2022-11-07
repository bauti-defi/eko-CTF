
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import "./GoldenTicketCracker.sol";

/// @dev forge script script/Attack.s.sol:Attack --rpc-url $ETH_GOERLI_RPC_URL --broadcast

contract Attack is Script {
  
  function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        GoldenTicketCracker cracker = new GoldenTicketCracker();
        vm.stopBroadcast();


        vm.startBroadcast(deployerPrivateKey);
        cracker.crack();
        vm.stopBroadcast();
  }
   
}
