//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.4;

library Roles {
    
    struct Role {
        mapping (address => bool) bearer;
        mapping (address => string) addharCard;
        mapping (address => string) area;
    }
    
    function add(Role storage role, address _account, string memory _addharCard, string memory _area) internal {
        require(_account != address(0));
        require(!has(role, _account));
        
        role.bearer[_account] = true;
        role.addharCard[_account] = _addharCard;
        role.area[_account] = _area;
    }
    
    function remove(Role storage role, address _account) internal {
        require(_account != address(0));
        require(has(role, _account));
        
        role.bearer[_account] = false;
        role.addharCard[_account] = "";
        role.area[_account] = "";
    }
    
    function has(Role storage role, address account) internal view returns(bool) {
        // require(account != address(0));
        return role.bearer[account];
    }
    
}