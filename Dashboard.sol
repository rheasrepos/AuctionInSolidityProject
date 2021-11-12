// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.9;
import "Auction.sol";

contract Dashboard {
    
    Auction[] activeAuctions;
    Auction[] expiredAuctions;
    
    function addAuction(Auction auction) public {
        activeAuctions.push(auction);
    }
    
    function endAuction(Auction auction) public {
        uint256 counter = 0;
        uint256 activeAmount = activeAuctions.length;
        
        while (activeAuctions[counter] != auction) {
            if (counter == activeAmount) {
                break;
            }
            counter++;
        }
        
        if (counter < activeAmount) {
            while (counter < activeAmount - 1) {
                activeAuctions[counter] = activeAuctions[counter + 1];
                counter++;
            }
            
            activeAuctions.pop();
            expiredAuctions.push(auction);
        }

    }
    
    
}