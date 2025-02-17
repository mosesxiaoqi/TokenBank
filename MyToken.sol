// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./ERC20.sol";

contract MyToken is ERC20 {

    constructor() ERC20("SharyToken", "ST", 18) {}
}