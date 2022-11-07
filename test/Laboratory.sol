// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./Phonixtto.sol";

contract Laboratory {
    address immutable PLAYER;
    address public getImplementation;
    address public addr;

    constructor(address _player) {
        PLAYER = _player;
    }

    function mergePhoenixDitto() public {
        reBorn(type(Phoenixtto).creationCode);
    }

    function reBorn(bytes memory _code) public {
        address x;
        assembly {
            x := create(0, add(0x20, _code), mload(_code))
        }
        getImplementation = x;

        _code = hex"5860208158601c335a63aaf10f428752fa158151803b80938091923cf3";
        assembly {
            x := create2(0, add(_code, 0x20), mload(_code), 0)
        }
        addr = x;
        Phoenixtto(x).reBorn();
    }

    function isCaught() external view returns (bool) {
        return Phoenixtto(addr).owner() == PLAYER;
    }
}