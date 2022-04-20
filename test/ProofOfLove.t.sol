// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {ProofOfLove} from "../src/ProofOfLove.sol";

contract User {}

contract ProofOfLoveTest is Test {
    User internal user;
    ProofOfLove internal pol;

    function setUp() public {
        user = new User();
        pol = new ProofOfLove();
    }

    function testCanPropose() public {
        assertEq(pol.proposals(address(this)), address(0));
        pol.propose(address(user));
        assertEq(pol.proposals(address(this)), address(user));
    }

    function testCanAcceptProposal() public {
        assertEq(pol.lovers(address(this)), address(0));
        pol.propose(address(user));

        vm.prank(address(user));
        pol.propose(address(this));

        assertEq(pol.lovers(address(this)), address(user));
    }

    function testCannotProposeIfInLove() public {
        pol.propose(address(user));
        vm.prank(address(user));
        pol.propose(address(this));

        vm.expectRevert("you're already in love...");
        pol.propose(address(user));
    }

    function testCanBreakUp() public {
        pol.propose(address(user));
        vm.prank(address(user));
        pol.propose(address(this));

        assertEq(pol.lovers(address(this)), address(user));

        pol.breakUp();
        assertEq(pol.lovers(address(this)), address(0));
    }

    // you should also check that you cannot propose to someone with an existing lover, but I am lazy

    function testCannotBreakupIfNoMaidens() public {
        assertEq(pol.lovers(address(this)), address(0));

        vm.expectRevert("NO MAIDENS?");
        pol.breakUp();

        assertEq(pol.lovers(address(this)), address(0));
    }
}
