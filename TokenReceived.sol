// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

interface TokenReceived {
    function tokensReceived(
        address operator,
        address from,
        uint256 value,
        bytes calldata data
    ) external returns (bytes4);
}