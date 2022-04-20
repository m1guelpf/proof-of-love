// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract ProofOfLove {
    /// @notice NO MAIDENS?
    error NoMaidens();

    /// @notice you're already in love...
    error AlreadyInLove();

    /// @notice looks like they already have someone else :(
    error YouGotFrontrun();

    /// @notice Name of the contract
    string public constant name = "Proof of Love";

    /// @notice Wether two addresses are in love
    mapping(address => address) public getLover;

    /// @notice Holds proposals from an address to another
    mapping(address => address) public getProposal;

    /// @notice Propose to someone, or accept a proposal
    /// @param _to Who you're proposing to
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

    /// @notice Break up with your current lover
    function breakUp() public {
        if(getLover[msg.sender] == address(0)) revert NoMaidens();

        if (getLover[getLover[msg.sender]] == msg.sender) {
            getLover[getLover[msg.sender]] = address(0);
        }

        getLover[msg.sender] = address(0);
    }
}
