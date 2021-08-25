// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract FunctionsExample {

    mapping(address => uint) public balanceReceived;
    
    address payable owner;
    
    // invokes only once at the moment of deployment
    constructor() {
        owner = payable(msg.sender);
    }
    
    // pure funcs don't interact state
    function convertWeiToEth(uint _amount) public pure returns(uint) {
        return _amount / 1 ether;
    }
    
    // getter for the private prop
    function getOwner() public view returns(address payable) {
        return owner;
    }
    
    function destroy() public {
        // can be only called by the contract creator
        require(msg.sender == owner, "You are not he owner");
        selfdestruct(owner);
    }

    function receiveMoney() public payable {
        assert(balanceReceived[msg.sender] + msg.value >= balanceReceived[msg.sender]);
        balanceReceived[msg.sender] += msg.value;
    }

    function withdrawMoney(address payable _to, uint _amount) public {
        require(_amount <= balanceReceived[msg.sender], "not enough funds.");
        assert(balanceReceived[msg.sender] >= balanceReceived[msg.sender] - _amount);
        balanceReceived[msg.sender] -= _amount;
        _to.transfer(_amount);
    } 
    
    // view functions are only called (not transacted) and don't cause the
    // state changes
    function balance() public view returns(uint) {
        return address(this).balance;
    }
    
    function contractAddress() public view returns(address) {
        return address(this);
    }
    
    // fallback function
    receive() external payable {
        receiveMoney();
    }
}