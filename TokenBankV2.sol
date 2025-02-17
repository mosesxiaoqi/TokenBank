// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./TokenBank.sol";   // Importing the TokenBank contract
import "./TokenReceived.sol";   // Importing the TokenReceived contract

contract TokenBank2 is TokenBank, TokenReceived {
    constructor() TokenBank() {}

    event TokensReceived(
        address indexed token,
        address indexed operator,
        address indexed from,
        uint256 value,
        bytes data
    );

    function tokensReceived(
        address operator,
        address from,
        uint256 value,
        bytes calldata data
    ) external override returns (bytes4) {
        emit TokensReceived(msg.sender, operator, from, value, data);
        balances[from][msg.sender] += value;

        return this.tokensReceived.selector;
    }
}