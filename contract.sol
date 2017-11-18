/*
status
item_created = 1
only_buyer_can_complete = 2
complete = 3
canceled = 4
*/




/* 
item =
{
    '0xSender' : {        
        sellerValue: 12,
        sellerAddress: 0xSeller
        buyerAddress: 0xBuyer
        buyerValue: 0
        status: 1
    }
}
*/

pragma solidity ^0.4.0;

contract myContract {
    

    /*
    itemList =
    {
        '0xSender' : {        
            sellerValue: 12,
            sellerAddress: 0xSeller
            buyerAddress: 0xBuyer
            buyerValue: 0
            status: 1
        }
    }
    */
    uint public itemNumber = 0;
    struct Item {
        uint sellerValue;
        address sellerAddress;
        address buyerAddress;
        uint buyerValue;
        uint status;
    }
    mapping(uint => Item) public itemList;
    




    /*
    addressList = {
        0xAddress1 : [1, 6, 9],
        0xAddress2 : [2, 4, 7],
        0xAddress3 : [3, 5, 8]
    }
    */
    struct Address{
        uint item;
    }
    mapping(address => Address[]) public addressList;




    modifier condition(bool _condition) {
        require(_condition);
        _;
    }




    
    function create_new_item()
        payable
        returns (uint)
    {
        // new item number
        itemNumber++;
        
        /* 
        add new item to the itemList.
        {        
            sellerValue: 12,
            sellerAddress: 0xSeller
            buyerAddress: 0xBuyer
            buyerValue: 0
            status: 1 
        }

        status of 1 means only the seller can unlock

        */
        itemList[itemNumber] = Item(msg.value, msg.sender, msg.sender, 0, 1);

        // add new item to the addressList
        addressList[msg.sender].push(Address(itemNumber));

        // return the itemNumber
        return itemNumber;
    }
    
    function get_buyer_address(uint _itemNumber) returns (address){
        return itemList[_itemNumber].buyerAddress;
    }   
    
    function get_buyer_value(uint _itemNumber) returns (uint){
        return itemList[_itemNumber].buyerValue;
    }  

    function get_seller_address(uint _itemNumber) returns (address){
        return itemList[_itemNumber].sellerAddress;
    }

    function get_seller_value(uint _itemNumber) returns (uint){
        return itemList[_itemNumber].sellerValue;
    }
    
    function get_itemNumber_status(uint _itemNumber) returns (uint){
        return itemList[_itemNumber].status;
    }

    function get_itemNumber_from_address(address _address, uint _index) public returns(uint){
        return addressList[_address][_index].item;
    }

    // the seller can cancel anytime. if they do, the ETH gets returned
    function cancel_item(uint _itemNumber) 
        condition (itemList[_itemNumber].sellerAddress == msg.sender)
        returns (uint) 
    {            
        // update the status to canceled=4
        itemList[_itemNumber].status = 4; 

        // transfer buyer value to seller
        itemList[_itemNumber].sellerAddress.transfer(itemList[_itemNumber].sellerValue);

        // transfer seller value to buyer
        itemList[_itemNumber].buyerAddress.transfer(itemList[_itemNumber].buyerValue);

        // return the status
        return itemList[_itemNumber].status;
    }

    // if the buyer value is twice as much as the sellerValue && the item has not been bought aka status = 1)
    function buy_item(uint _itemNumber)
        payable
        condition (itemList[_itemNumber].sellerValue * 2 == msg.value && itemList[_itemNumber].status == 1)
        returns (uint)
    {
        // update the status to only_buyer_can_unlock=2
        itemList[_itemNumber].status = 2;
        // add buyer address to item
        itemList[_itemNumber].buyerAddress = msg.sender;
        // add buyer value to item
        itemList[_itemNumber].buyerValue = msg.value;

        return itemList[_itemNumber].status;
    }


    // if address belongs to the buyer && status is 'only_buyer_can_unlock'
    function recieved_item(uint _itemNumber) 
        payable
        condition ( itemList[_itemNumber].buyerAddress == msg.sender && itemList[_itemNumber].status == 2 )
        returns (uint)
    {
        // NOTE: This actually allows both the buyer and the seller to block the refund - the withdraw pattern should be used.

        // update the status to complete
        itemList[_itemNumber].status = 3;

        // transfer buyer value to seller
        itemList[_itemNumber].sellerAddress.transfer(itemList[_itemNumber].buyerValue);

        // transfer seller value to buyer
        itemList[_itemNumber].buyerAddress.transfer(itemList[_itemNumber].sellerValue);

        return itemList[_itemNumber].status;
    }
    
}