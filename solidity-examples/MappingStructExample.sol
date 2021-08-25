// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract MappingStructExample {

    
    struct Payment {
        uint amount;
        uint timestamp;
    }
    
    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }
    
        // tracks balances for the each address who sent money
    mapping(address => Balance) public balanceReceived;
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    function sendMoney() public payable {
        Balance storage contributorBalance = balanceReceived[msg.sender];
        contributorBalance.totalBalance += msg.value;
        Payment memory payment = Payment({
            amount: msg.value,
            timestamp: block.timestamp // previously called 'now'
        });
        contributorBalance.payments[contributorBalance.numPayments] = payment;
        contributorBalance.numPayments++;
    }
    
    function withdrawAllSentMoney(address payable _to) public {
        // gets the amount of money sent by the function caller
        uint balanceToSend = balanceReceived[msg.sender].totalBalance;
        // nullify the received money counter
        balanceReceived[msg.sender].totalBalance = 0;
        // tranfer that amount to the specified account
        _to.transfer(balanceToSend);
    }
    
    function withdrawMoney(address payable _to, uint _amount) public {
        require(balanceReceived[msg.sender].totalBalance >= _amount, "insufficient funds");
        balanceReceived[msg.sender].totalBalance -= _amount;
        _to.transfer(_amount);
    }
}
