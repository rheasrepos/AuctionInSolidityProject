// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.9;
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Auction {
    
    IERC721 public nft;
    uint256 public nftID;
    
    address payable public immutable seller;
    
    uint256 public endTime;
    uint256 public currentPrice;
    address public topBidder;
    
    constructor() {
        seller = payable (msg.sender);
    }
    
    function setup (IERC721 _nft, uint _nftID, uint256 startPrice, uint256 hoursFromNow) public {
        require (startPrice > 0, "Invalid start price.");
        nft = IERC721(_nft);
        nftID = _nftID;
        currentPrice = startPrice;
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
    
    // function bid(address bidder, uint256 price) public beforeEnd {
    //     require (price > currentPrice, "Insufficient funds.");
    //     topBidder = bidder;
    //     currentPrice = price;
    // }
    
    function directBid(uint256 price) public beforeEnd {
        require (price > currentPrice, "Insufficient funds.");
        topBidder = msg.sender;
        currentPrice = price;
    }
    
    function end() public payable afterEnd {
        //nft.approve(topBidder, nftID);
        nft.safeTransferFrom(address(this), topBidder, nftID);
        seller.transfer(currentPrice);
        
    }
    
    function endEarly() public payable {
        //nft.approve(topBidder.getAddress(), nftID);
        nft.safeTransferFrom(address(this), topBidder, nftID);
        seller.transfer(currentPrice);
    }
    
}