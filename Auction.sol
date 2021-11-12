// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.9;
import "User.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Auction {
    
    event Win(address winner, uint256 amount);
    
    event Buy(address winner, uint256 amount);
    
    IERC721 public immutable nft;
    uint256 public immutable nftID;
    
    address payable public seller;
    address public winner;
    
    address creator;
    uint256 highestBid;
    uint256 endTime;
    uint256 startPrice;
    uint256 currentPrice;
    User topBidder;
    
    
    constructor(
        IERC721 _nft,
        uint _nftID,
        uint256 _startPrice,
        uint256 hoursFromNow
    ) {
        require (_startPrice > 0, "Invalid start price.");
        seller = payable (msg.sender);
        nft = IERC721(_nft);
        nftID = _nftID;
        startPrice = _startPrice;
        currentPrice = _startPrice;
        endTime = block.timestamp + (hoursFromNow * 1 hours);
    }
    
    


    
    modifier beforeEnd() {
        require (block.timestamp < endTime, "This auction has already ended. Too late, too slow, goodbye.");
        _;
    }
    
    modifier afterEnd() {
        require (block.timestamp > endTime, "This auction hasn't ended yet. Maybe learn to read.");
        _;
    }
    
    
    
    
    
    function bid(User bidder, uint256 price) public beforeEnd {
        require (bidder.checkBalance() > highestBid, "Insufficient funds.");
        topBidder = bidder;
        currentPrice = price;
    }
    
    function win() external payable afterEnd {
        winner = msg.sender;
        nft.transferFrom(seller, msg.sender, nftID);
        seller.transfer(msg.value);
        
        emit Win(msg.sender, msg.value);
    }
    
}