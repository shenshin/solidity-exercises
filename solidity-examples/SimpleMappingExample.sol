pragma solidity 0.8.7;

contract SimpleMappingExample {
    mapping(uint => bool) public myMapping;
    
    // set the value for the key in mapping
    function setValue(uint _i) public {
        myMapping[_i] = true;
    }
    
    mapping(address => bool) public myAddressMapping;
    
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
    
    // mapping of mappings
    mapping (uint => mapping (uint => bool)) twoDimMapping;
    
    function getValueFromTwoDimMapping(uint _i, uint _j) public view returns(bool) {
        return twoDimMapping[_i][_j];
    }
    
    function setValueFromTwoDimMapping(uint _i, uint _j, bool value) public {
        twoDimMapping[_i][_j] = value;
    }
}
