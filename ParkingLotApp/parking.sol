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

    
