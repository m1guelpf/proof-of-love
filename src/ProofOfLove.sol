// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProofOfLove {
    string public constant name = "Proof of Love";

    mapping(address => address) public getProposal;
    mapping(address => address) public getLover;

    function propose(address _to) public {
        require(getLover[msg.sender] == address(0), "you're already in love...");
        require(getLover[_to] == address(0), "looks like they already have someone else : (");
        // theyve already proposed, accept!! <3
        if (getProposal[_to] == msg.sender) {
            getLover[msg.sender] = _to;
            getLover[_to] = msg.sender;
        } else {
            getProposal[msg.sender] = _to;
        }
    }

    function breakUp() public {
        require(getLover[msg.sender] != address(0), "NO MAIDENS?");

        if (getLover[getLover[msg.sender]] == msg.sender) {
            getLover[getLover[msg.sender]] = address(0);
        }

        getLover[msg.sender] = address(0);
    }
}
