
﻿
## Explanation:
Events: Donated and withdrawn events are declared to log and track donations and withdrawals, respectively.

# Variables:
  owner: Stores the address of the contract owner.
  totalDonations: Keeps track of the total amount of Ether donated.
  donations: A mapping that associates each donor's address with the amount they've donated.

# Modifiers:
  onlyOwner: A modifier to ensure that only the owner can call certain functions.

# Constructor: Sets the owner of the contract to the address that deploys it.
  
donate function: Allows users to send Ether to the contract. It checks if the sent amount is greater than 0, updates the total donations, and logs the donation event.

withdraw function: Allows the owner to withdraw the total donations from the contract. It transfers the contract's balance to the owner and logs the withdrawal event.

checkBalance function: Returns the current balance of the contract. 
