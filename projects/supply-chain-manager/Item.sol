//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { ItemManager } from "./ItemManager.sol";

/*
вводится отдельный контракт для единицы продукции, для того, чтобы была возможность
платить (слать деньги) непосредственно по адресу контракта, а не вызывая функцию 
в ItemManager. Это делается просто(?) для удобства пользователя контракта
Этот класс принмает платёж и отправляет его в ItemManager
*/
contract Item {
    uint public priceInWei;
    uint public paidWei;
    uint public index;

    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;
    }

    receive() external payable {
        require(msg.value == priceInWei, "We don't support partial payments");
        require(paidWei == 0, "Item is already paid!");
        paidWei += msg.value;
        // function 'call' returns 2 values. Getting the first one
        // address(someAddress).call.value(msg.value)()
        (bool success, ) = address(parentContract).call{value:msg.value}(abi.encodeWithSignature("triggerPayment(uint256)", index));
        require(success, "The transaction was not successfull. Cancelling");
    }

    fallback () external {

    }

}