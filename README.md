https://ethereum-escrow.github.io/store/

How does it work?

-----------

Both the buyer and seller agree to trade an item for 1 ETH.
![alt tag](./images/1_agree.png)

-----------------

The seller creates a contract and sends 1 ETH as collateral.
![alt tag](./images/2_sell.png")

-----------------

The buyer sends a total of 2 ETH to the contract address
1 ETH for the item.
1 ETH for collateral.
The contract is now locked.
Only the buyer can unlock the contract.
![alt tag](./images/3_buy.png")

-----------------

The seller sends the item.
![alt tag](./images/4_send.png")

-----------------

When item is recieved,
the buyer can safely unlock the contract.
![alt tag](./images/5_recieve.png")

-----------------

The unlocked contract:
Returns the seller's 1 ETH as collateral.
Pays the seller 1 ETH.
Returns the buyer's 1 ETH as collateral.
![alt tag](./images/6_complete.png")