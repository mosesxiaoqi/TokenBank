// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./IERC20.sol";
import "./IERC20Metadata.sol";

abstract contract ERC20 is IERC20, IERC20Metadata {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    address private owner;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    constructor(string memory n, string memory s, uint8 d) {
        _name = n;
        _symbol = s;
        _decimals = d;
        _totalSupply = 1000000 * 10 ** uint256(_decimals);
        balances[msg.sender] = _totalSupply;
        owner = msg.sender;
    }

    function name() external view returns (string memory) {
        return _name;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function decimals() external view returns (uint8) {
        return _decimals;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balances[account];
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {   
        // write your code here     
        return allowances[_owner][_spender];
    }

    function getowner() public view returns (address) {
        return owner;
    }

    function transfer(address _to, uint256 _amount) public returns (bool) {
        _transfer(msg.sender, _to, _amount);
        return true;  
    }
    
    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {
        // msg.sender 是 _from 授权的地址，from 是转账的地址, 
        // transferFrom是调用第三方代替自己支付，
        // 所以from是自己，to是要把钱转过去的地址，在这里msg.sender是第三方
        // from想要向bank转账，需要先授权给msg.sender, 
        // 在tokenbank这个合约里，msg.sender和to是一个，相当于合约给自己赚钱
        // 正常是msg.sender代替自己给to(其他地址)转钱
        _spendAllowance(_from, msg.sender, _amount);
        _transfer(_from, _to, _amount);
        return true;
    }

    function approve(address _spender, uint256 _amount) public returns (bool success) {
        // write your code here
        _approve(msg.sender, _spender, _amount);
        return true; 
    }

    function _transfer(address _from, address _to, uint256 _amount) internal {
        require(balances[_from] >= _amount, "ERC20: transfer amount exceeds balance");
        balances[_from] -= _amount;
        balances[_to] += _amount;
        emit Transfer(_from, _to, _amount); 
    }

    function _approve(address _owner, address _spender, uint256 _amount) internal {
        allowances[_owner][_spender] = _amount;
        emit Approval(_owner, _spender, _amount);
    }

    function _spendAllowance(address _owner, address _spender, uint256 _amount) internal {
        uint256 currentAllowance = allowance(_owner, _spender);
        require(currentAllowance >= _amount, "ERC20: transfer amount exceeds allowance");
        _approve(_owner, _spender, currentAllowance - _amount);
    }
}