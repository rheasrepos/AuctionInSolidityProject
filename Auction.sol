// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.9;

contract Auction {
    
    address creator;
    uint256 highestBid;
    
    constructor() {
        creator = msg.sender;
    }
    
    modifier isOwner() {
        require (msg.sender == creator, "User is not creator.");
        _;
    }
    
    modifier sufficientFunds() {
        require (balance >= highestBid, "Insufficient funds.");
        _;
    }
    
}