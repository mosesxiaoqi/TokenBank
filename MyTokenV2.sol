// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./ERC20.sol";
import "./ERC20transfer.sol";

contract MyToken2 is ERC20Transfer{

    constructor() ERC20("Shary2Token", "ST2", 18) {}
}