// SPDX-License-Identifier: MIT  

pragma solidity ^0.8.0;

contract DonationApp {

    // Event to log donations
    event Donated(address indexed donor, uint256 amount);

    // Event to log withdrawals by the owner
    event Withdrawn (uint256 amount);

    // The owner of the contract (typically the one who deploys it) 
    address public owner;

    // Total donations received 
    uint256 public totalDonations;

    // Mapping to keep track of individual donations 
    mapping(address => uint256) public donations;

    // Modifier to restrict functions to the owner 

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function"); 
        _;
    }

    // Constructor to set the owner of the contract
    constructor(){
        owner = msg.sender;
    }

    // Function to donate Ether

    function donate() external payable {
        require(msg.value > 0, "Donation amount should be greater than 0");
        
        //Increase the total donations and individual donation amounts
        totalDonations += msg.value;
        donations[msg.sender] += msg.value;
        emit Donated(msg.sender, msg.value);
    } 

    // Function to allow the owner to withdraw donations 
    function withdraw() external onlyOwner {
        uint256 amount = address (this).balance;
        payable(owner).transfer(amount);
        emit Withdrawn (amount);
    }
    // Function to check the contract balance
    function checkBalance() external view returns (uint256) { 
        return address (this).balance;
    }
} 
