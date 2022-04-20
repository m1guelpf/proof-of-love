// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProofOfLove {
    error NoMaidens();
    error AlreadyInLove();
    error YouGotFrontrun();

    string public constant name = "Proof of Love";

    mapping(address => address) public getLover;
    mapping(address => address) public getProposal;

    function propose(address _to) public {
        if(getLover[msg.sender] != address(0)) revert AlreadyInLove();
        if(getLover[_to] != address(0)) revert YouGotFrontrun();

        // theyve already proposed, accept!! <3
        if (getProposal[_to] == msg.sender) {
            getLover[msg.sender] = _to;
            getLover[_to] = msg.sender;
        } else {
            getProposal[msg.sender] = _to;
        }
    }

    function breakUp() public {
        if(getLover[msg.sender] == address(0)) revert NoMaidens();

        if (getLover[getLover[msg.sender]] == msg.sender) {
            getLover[getLover[msg.sender]] = address(0);
        }

        getLover[msg.sender] = address(0);
    }
}
