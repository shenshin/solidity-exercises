//SPDX-License-Identifier: MIT

pragma solidity 0.8.7;
import { Allowance } from './Allowance';

contract SharedWallet is Allowance {
    event MoneySent(address indexed _beneficiary, uint _amount);
    event MoneyReceived(address indexed _from, uint _amount);
    function withdrawMoney(address payable _to, uint _amount) public ownerOrAllowed(_amount) {
        require(_amount <= address(this).balance, "The contract doen't have enough money");
        if (!isOwner()) {
            reduceAllowance(msg.sender, _amount);
        }
        emit MoneySent(_to, _amount);
        _to.transfer(_amount);
    }
    function renounceOwnership() public pure override {
        revert("Can't renounce ownership");
    }
    // deposit (fallback) function - to send money to the smart contract
    receive() external payable {
        emit MoneyReceived(msg.sender, msg.value);
    }
}