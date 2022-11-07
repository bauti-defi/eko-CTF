
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

import "./Stonks.sol";
import "./Laboratory.sol";
import "./PelusaCracker.sol";
import "./Pelusa.sol";


contract Playground is Test {

    uint256 SALT = 0x000000000000000000000000000000000000000000000000000000000000000f;
    address owner = 0xD5730BbD7a24FF2AA447281e315885bb02b1aCAC;

    Pelusa pelusa;
    bytes _bytecode;

    address deployer;

    function setUp() public {
        deployer = makeAddr("[Deployer]");
        vm.prank(deployer, deployer);
        pelusa = new Pelusa();
        _bytecode = getBytecode(address(pelusa), calcOwner(deployer, blockhash(block.number)));
    }

    function testFindSalt(
        uint salt
    ) public {
        vm.assume(passes(deployer, _bytecode, salt));
        console.logUint(salt);
    }

    function testSingle() public {
        uint256 salt = SALT;
        bytes memory code = _bytecode;

        address crackerAddr;
        vm.prank(deployer, deployer);
        assembly{
            crackerAddr := create2(0, add(code, 0x20), mload(code), salt)

            if iszero(extcodesize(crackerAddr)) {
                revert(0, 0)
            }
        }

        console2.logAddress(pelusa.player());
        console2.logBool(pelusa.isGoal());

        pelusa.shoot();

        assertEq(pelusa.goals(), 2);
    }

    function testHandOfGod() public {
        assertTrue(uint256(bytes32(abi.encodePacked(uint256(22_06_1986)))) == 22_06_1986);
    }

    function testAddress() public {
        assertTrue(passes(deployer, _bytecode, SALT));
    }

    function testCalcOwner() public {
        address deployer = 0x843c756Ba3dfb22e7ac0BeF4F231756679102bb5;
        console2.logAddress(calcOwner(deployer, bytes32(0x77f4be9260151ff5835a77c1711e29cc59905a898071f57ef62a70ec6315d78a)));
    }

    function calcOwner(address deployer, bytes32 _blockhash) public returns (address) {
        return address(uint160(uint256(keccak256(abi.encodePacked(deployer, _blockhash)))));
    }

    function testRealDeployerSalt(uint256 _salt) public {
        vm.assume(passes(vm.addr(vm.envUint("PRIVATE_KEY")), _bytecode, _salt));
        console2.logUint(_salt);
    }

    // 1. Get bytecode of contract to be deployed
    // NOTE: _target is a constructor parameter of PelusaCracker
    function getBytecode(address _target, address _owner) public pure returns (bytes memory) {
        bytes memory bytecode = type(PelusaCracker).creationCode;

        return abi.encodePacked(bytecode, abi.encode(_target, _owner));
    }

    // 2. Compute the address of the contract to be deployed
    // NOTE: _salt is a random number used to create an address
    function passes(address _deployer, bytes memory bytecode, uint _salt)
        public
        view
        returns (bool)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(bytes1(0xff), _deployer, _salt, keccak256(bytecode))
        );

        // NOTE: cast last 20 bytes of hash to address
        return uint160(uint(hash)) % 100 == 10;
    }


}
