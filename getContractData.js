function get_buyer_address (_itemNumber){
    web3.eth.contract(contractAbi).at(contractAddress).get_buyer_address.call(_itemNumber, function(err, buyerAddress){
        if (err) {return console.log(err)}
        console.log('buyerAddress =', buyerAddress)
    })
}

function get_buyer_value(_itemNumber = 1){
    web3.eth.contract(contractAbi).at(contractAddress).get_buyer_value.call(_itemNumber, function(err, data){
        if (err) {return console.log(err)}
        const buyerValue = Number(data.c[0]) / 10000
        console.log('buyerValue =', buyerValue)     
    })  
}

function get_seller_address (_itemNumber = 1){
    web3.eth.contract(contractAbi).at(contractAddress).get_seller_address.call(_itemNumber, function(err, sellerAddress){
        if (err) {return console.log(err)}
        console.log('sellerAddress =', sellerAddress)
    })   
}

function get_seller_value (_itemNumber = 1){
    web3.eth.contract(contractAbi).at(contractAddress).get_seller_value.call(_itemNumber, function(err, data){
        if (err) {return console.log(err)}
        const sellerValue = Number(data.c[0]) / 10000
        console.log('sellerValue =', sellerValue)
    })  
}

function get_itemNumber_status (_itemNumber = 1){
    web3.eth.contract(contractAbi).at(contractAddress).get_itemNumber_status.call(_itemNumber, function(err, data){
        if (err) {return console.log(err)}
        const statusNumber = Number(data.c[0])
        const statusMessage = {
            '1': 'item_created',
            '2': 'only_buyer_can_complete',
            '3': 'complete',
            '4': 'canceled',
        }
        console.log('status =', statusMessage[statusNumber])
    })
}


function get_itemNumber_from_address(_address = web3.eth.accounts[0], _index = 0){
    web3.eth.contract(contractAbi).at(contractAddress).get_itemNumber_from_address.call(_address, _index, function(err, data){
        if (err) {return console.log(err)}

        itemNumber = Number(data.c[0])

        console.log({address: _address, itemNumber: itemNumber})

        // loop until the end of the array
        if (itemNumber !== 0){
            get_itemNumber_from_address(_address, ++_index)
        }

    })





}










