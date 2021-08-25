// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;
import { Owned } from "./Owned.sol";


contract InheritanceModifierExample is Owned {
    mapping(address => uint) public tokenBalance;
    
    event TokensSent(address _from, address _to, uint _amount);

    uint tokenPrice = 1 ether;

    constructor() {
        tokenBalance[owner] = 100;
    }
    
    function ownersTokens() public view returns(uint) {
        return tokenBalance[owner];
    }
    
    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }
    
    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }
    
    function purchaseToken() public payable {
        require(tokenBalance[owner] * tokenPrice / msg.value > 0, 'not enough tokens');
        uint numberOfTokens = msg.value / tokenPrice;
        tokenBalance[owner] -= numberOfTokens;
        tokenBalance[msg.sender] += numberOfTokens; 
    }
    
    function sendToken(address _to , uint _amount) public {
        uint senderTokens = tokenBalance[msg.sender];
        uint receiverTokens = tokenBalance[_to];
        require(senderTokens >= _amount, "not enough tokens");
        assert(receiverTokens + _amount >= receiverTokens);
        assert(senderTokens - _amount <= senderTokens);
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
        
        emit TokensSent(msg.sender, _to, _amount);
    }
}