// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProofOfLove {
    string public constant name = "Proof of Love";

    mapping (address => address) public proposals;
    mapping (address => address) public lovers;

    function propose(address _to) public {
        require(lovers[msg.sender] == address(0), "you're already in love...");
        require(lovers[_to] == address(0), "looks like they already have someone else : (");
        // theyve already proposed, accept!! <3
        if (proposals [_to] == msg.sender) {
            lovers[msg.sender] = _to;
            lovers[_to] = msg.sender;
        } else {
            proposals[msg.sender] = _to;
        }
    }

    function breakUp() public {
        require(lovers [msg.sender] != address(0), "NO MAIDENS?");

        if (lovers[lovers[msg.sender]] == msg.sender) {
            lovers[lovers[msg.sender]] = address(0);
        }

        lovers[msg.sender] = address(0);
    }
}
