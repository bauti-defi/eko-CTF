// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Phoenixtto {
    address public owner;
    bool private _isBorn;

    function reBorn() external {
        if (_isBorn) return;

        _isBorn = true;
        owner = address(this);
    }

    function capture(string memory _newOwner) external {
        if (!_isBorn || msg.sender != tx.origin) return;

        address newOwner = address(uint160(uint256(keccak256(abi.encodePacked(_newOwner)))));
        if (newOwner == msg.sender) {
            owner = newOwner;
        } else {
            selfdestruct(payable(msg.sender));
            _isBorn = false;
        }
    }
}