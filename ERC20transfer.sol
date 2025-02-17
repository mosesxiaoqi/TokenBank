// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./ERC20.sol";  
import "./TokenReceived.sol"; 

abstract contract ERC20Transfer is ERC20 {

    error TransferFailed(address receiver, uint256 value);
    error InvalidReceiveAddress(address receiver);

    function transferWithCallback(address _to, uint256 _amount) public returns (bool) {
        if (!transfer(_to, _amount)) {
            revert TransferFailed(_to, _amount);
        }

        checkTransferReceived(msg.sender, msg.sender, _to, _amount, "");

        return true;
    }

    function checkTransferReceived(
        address operator, //发起转账操作的地址 通常是调用 transferWithCallback 函数的地址
        address from,  // 代币的发送者地址
        address to,   // 代币的接收者地址
        uint256 value,
        bytes memory data
    ) internal {
        if (to.code.length == 0) {
            revert InvalidReceiveAddress(to);
        }

        try TokenReceived(to).tokensReceived(operator, from, value, data) returns (bytes4 result) {
            require(result == TokenReceived.tokensReceived.selector, "Invalid callback");
        } catch {
            revert InvalidReceiveAddress(to);
        }
        
    }
}