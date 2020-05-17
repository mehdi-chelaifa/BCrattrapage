pragma solidity >=0.4.24 <0.7.0;

import "../node_modules/zeppelin-solidity/contracts/ownership/HasNoTokens.sol";

contract SafeContract is HasNoTokens{
    address owner;
    address public from;
    uint public value;
    bytes data;
    constructor () public {
        owner = msg.sender;
    }
}