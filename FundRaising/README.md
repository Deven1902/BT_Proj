# Explanation:- 

The contract starts by defining some basic state variables like the owner, goal, and totalRaised.

The donations mapping keeps track of how much each address has donated.
•
The onlyOwner modifier ensures that only the owner of the contract can call certain functions.

•
The constructor sets the fundraising goal and the owner of the contract.
The donate function allows users to send Ether to the contract and logs the donation.

•
The withdraw function allows the owner to withdraw the funds once the fundraising goal is met.
The getBalance function returns the current balance of the contract. 
