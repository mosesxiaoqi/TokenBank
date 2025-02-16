// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.24 <0.9.0;

import "./IERC20.sol";
import "./IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    uint256 private _totalSupply;
    address private owner;

    mapping(address => uint256) private balances;
    mapping(address => mapping(address => uint256)) private allowances;

    constructor() {
        _name = "SharyToken";
        _symbol = "TONG";
        _decimals = 18;
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

    function transfer(address _to, uint256 _amount) external returns (bool) {
        _transfer(msg.sender, _to, _amount);
        return true;  
    }
    
    function transferFrom(address _from, address _to, uint256 _amount) public returns (bool success) {
        uint256 currentAllowance = allowance(_from, msg.sender);
        require(currentAllowance >= _amount, "ERC20: transfer amount exceeds allowance");
        _approve(_from, msg.sender, currentAllowance - _amount);
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
}