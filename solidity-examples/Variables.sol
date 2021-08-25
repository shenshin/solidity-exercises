pragma solidity ^0.8.1;

contract WorkingWithVariables {
    uint256 public myUint;
    
    function setMyUint(uint _myUint) public {
        myUint = _myUint;
    }
    
    bool public myBool;
    
    function setMyBool(bool _myBool) public {
        myBool = _myBool;
    }
    
    uint8 public myUint8;
    
    function incrementUint() public {
        myUint8 += 1;
    }
    function decrementUint() public {
        myUint8--;
    }
    
    address public myAddress;
    function setAddress(address _address) public {
        myAddress = _address;
    }
    function getBalance() public view returns(uint256) {
        return myAddress.balance;
    }
    
    string public myString = 'hello world';
    function setMyString(string memory _string) public {
        myString = _string;
    }
 }