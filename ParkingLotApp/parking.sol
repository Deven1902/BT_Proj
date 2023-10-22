// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ParkingLot {
    struct ParkingSpot {
        uint256 id;
        bool isOccupied;
        address occupant;
        uint256 checkInTime;
    }

    address public owner;
    uint256 public parkingSpotCount = 0;
    uint256 public pricePerHour = 1 ether; // Example price
    
    mapping(uint256 => ParkingSpot) public parkingSpots;

    event ParkingSpotAdded(uint256 indexed spotld);
    event CheckedIn(uint256 indexed spotld, address indexed occupant);

    event CheckedOut(uint256 indexed spotld, address indexed occupant, uint256 duration, uint256 cost); 

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addParkingSpot() external onlyOwner {
        parkingSpotCount++;
        parkingSpots[parkingSpotCount] = ParkingSpot(parkingSpotCount, false, address(0), 0);
        emit ParkingSpotAdded (parkingSpotCount);

    }

     function checkIn(uint256 _spotId) external payable { 
        ParkingSpot storage spot = parkingSpots[_spotId]; 
        require(!spot.isOccupied, "Spot is already occupied"); 
        require(msg.value == pricePerHour, "Incorrect payment");
        
        spot.isOccupied = true; 
        spot.occupant = msg.sender;
        spot.checkInTime = block.timestamp;

        emit CheckedIn(_spotId, msg.sender);
    } 

    function checkOut(uint256 _spotId) external {
        ParkingSpot storage spot = parkingSpots[_spotId];
        require(spot.isOccupied && spot.occupant == msg.sender, "Not the occupant of this spot");
        
        uint256 duration = (block.timestamp - spot.checkInTime) / 1 hours;
        uint256 totalCost = duration * pricePerHour;
        
        require(address(this).balance >= totalCost, "Contract balance insufficient");
        
        spot.isOccupied = false; spot.occupant = address(0); spot.checkInTime = 0;
        payable(msg.sender).transfer(totalCost);
        
        emit CheckedOut(_spotId, msg.sender, duration, totalCost);
    } 

    function withdrawFunds() external onlyOwner{
        uint256 balance = address(this).balance;
        payable(owner).transfer(balance);
    }

}
