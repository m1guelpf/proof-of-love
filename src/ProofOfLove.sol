// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProofOfLove {
    string public constant name = "Proof of Love";

    mapping (address => address) public proposals;
    mapping (address => address) public lovers;
    address private constant NULLADDR = address(0x000000000000000000000000000000000);

    function propose(address _to) public returns (bool success) {
        require(lovers[msg.sender] == NULLADDR, "you're already in love...");
        require(lovers[_to] == NULLADDR, "looks like they already have someone else : (");
        // theyve already proposed, accept!! <3
        if (proposals [_to] == msg.sender) {
            lovers[msg.sender] = _to;
            lovers[_to] = msg.sender;
        } else {
            proposals[msg.sender] = _to;
        }

        return true;
    }

    function breakUp() public returns (bool success) {
        require(lovers [msg.sender] != NULLADDR, "NO MAIDENS?");

        if (lovers[lovers[msg.sender]] == msg.sender) {
            lovers[lovers[msg.sender]] = NULLADDR;
        }

        lovers[msg.sender] = NULLADDR;

        return true;
    }
}
