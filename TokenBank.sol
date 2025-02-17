// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./IERC20.sol";

contract TokenBank {
    mapping(address => mapping(address => uint256)) internal balances;

    constructor() {}

    function deposit(address token, uint256 _amount) public {
        (bool success, bytes memory data) = address(token).call(abi.encodeWithSelector(IERC20.transferFrom.selector, msg.sender, address(this), _amount));
        require(success && (data.length == 0 || abi.decode(data, (bool))), "TokenBank: deposit failed");

        balances[msg.sender][token] += _amount;
    }

    function withdraw(address token, uint256 amount) public {
        require(amount > 0, "Withdraw amount must be greater than zero");
        require(balances[msg.sender][token] >= amount, "Insufficient balance");

        balances[msg.sender][token] -= amount;

        // 通过 IERC20(token) 编码 transfer 方法
        (bool success, bytes memory data) = address(token).call(
            abi.encodeWithSelector(IERC20.transfer.selector, msg.sender, amount)
        );

        require(success && (data.length == 0 || abi.decode(data, (bool))), "Transfer failed");
    }
}