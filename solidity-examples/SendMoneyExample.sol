pragma solidity ^0.8.7;

contract SendMoneyExample {
    uint public receivedBalance;
    uint public lockedUntill;
    
    function receiveMoney() public payable {
        receivedBalance += msg.value;
        lockedUntill = block.timestamp + 1 minutes;
    }
    
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
    
    function withdrawMoney() public {
        if (lockedUntill < block.timestamp) {
            address payable to = payable(msg.sender);
            to.transfer(this.getBalance());
        }
    }
    
    function sendMoneyTo(address payable _to) public {
        if (lockedUntill < block.timestamp) {
            _to.transfer(getBalance());
        }
    }
}