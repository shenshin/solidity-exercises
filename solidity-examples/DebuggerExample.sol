// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.5.13;

contract DebuggerExample {
    uint public myUint;
    // hash: "06540f7e": "myUint()",
    
    function setMyUint(uint _myuint) public {
        myUint = _myuint;
    }
    // hash: "e492fd84": "setMyUint(uint256)"
    // input 5: 0xe492fd840000000000000000000000000000000000000000000000000000000000000005
}
