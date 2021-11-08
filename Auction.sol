// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.9;
import "User.sol";

contract Auction {
    
    address creator;
    uint256 highestBid;
    User user;
    
    constructor() {
        creator = msg.sender;
    }
    
    modifier isOwner() {
        require (msg.sender == creator, "User is not creator.");
        _;
    }
    
    modifier sufficientFunds() {
        require (user.checkBalance() >= highestBid, "Insufficient funds.");
        _;
    }
    
}