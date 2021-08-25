pragma solidity ^0.8.7;

contract StartStopUpdateExample {
    address payable owner;
    bool public paused;
    
    // starts contract
    constructor() {
        owner = payable(msg.sender);
    }
    
    modifier restricted() {
        require(msg.sender == owner, "You are not the owner");
        _;
    }
    
    function sendMoney() public payable {
    }
    
    // stop (pause) contract
    function setPaused(bool _paused) public restricted {
        paused = _paused;
    }
    
    function withdrawAllMoney(address payable _to) public restricted {
        require(!paused, "Contract is paused");
        _to.transfer(address(this).balance);
    }
    
    // destroy contract
    function destroySmartContract() public restricted {
        // sends all contract money to the specified address
        selfdestruct(owner);
    }
}
