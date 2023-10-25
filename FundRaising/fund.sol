// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundRaising{
    address public owner;
    uint256 public goal;
    uint256 public totalRaised;

    mapping(address => uint256) public donations;

    event Donated(address indexed donor, uint256 amt);

    event Withdrawn(uint256 amt);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this fun");
        _;
    }

    constructor(uint256 _goal) {
        owner = msg.sender;
        goal = _goal;
    }

    function donate() external payable {
        require(msg.value>0, "Donation should be more than 0");
        donations[msg.sender] += msg.value;

        totalRaised += msg.value;

        emit Donated(msg.sender, msg.value);
    }

    function withdraw() external onlyOwner{
        require(totalRaised >= goal, "Goal not met yet");
        uint256 amt=address(this).balance;
        payable(owner).transfer(amt);
        emit Withdrawn(amt);
    }

    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }
}
