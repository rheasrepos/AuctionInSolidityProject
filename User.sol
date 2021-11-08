// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.9;

contract User {
    
    struct userInfo {
        string password;
        uint256 balance;
    }
    
    address user;
    mapping (address => userInfo) users;
    
    constructor() {
        user = msg.sender;
    }
    
    modifier existingUser() {
        require (userExists(), "User does not exist.");
        _;
    }
    
    modifier notExistingUser() {
        require (!userExists(), "User already exists.");
        _;
    }
    
    function userExists() public view returns (bool) {
        if (keccak256(abi.encodePacked(users[user].password)) != keccak256(abi.encodePacked(""))) {
            return true;
        }
        
        return false;
    }
    
    function createUser(string memory password) public notExistingUser {
        users[user].password = password;
        users[user].balance = 0;
    }
    
    function depositFunds(uint256 amount) public existingUser {
        users[user].balance = users[user].balance + amount;
    }
    
    function withdrawFunds(uint256 amount) public existingUser {
        if (users[user].balance >= amount) {
            users[user].balance = users[user].balance - amount;
        }
    }
    
    function checkBalance() public view returns (uint256) {
        return users[user].balance;
    }
    
    
    
}