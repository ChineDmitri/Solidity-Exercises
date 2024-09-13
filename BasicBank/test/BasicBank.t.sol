// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BasicBank.sol";

contract BasicBankTest is Test {
    BasicBank public basicBank;

    function setUp() public {
        basicBank = new BasicBank();
    }

    function testAddEther() external {
        vm.deal(address(this), 1 ether);
        basicBank.addEther{value: 1 ether}();
        console.log(" -- address(basicBank).balance BEFORE : ", address(basicBank).balance);
        console.log(" -- msg.sender", msg.sender);
        assertEq(
            address(basicBank).balance,
            1 ether,
            "expected balance of basic bank contract to be 1 ether"
        );
        console.log(" -- address(basicBank).balance AFTER : ", address(basicBank).balance);
    }

    function testRemoveEther() external {
        vm.deal(address(this), 1 ether);
        vm.expectRevert();
        basicBank.removeEther(1);
        console.log(" -- address(this).balance BEFORE ADD ", address(basicBank).balance); 
        basicBank.addEther{value: 1 ether}();
        console.log(" -- address(this).balance AFTER ADD ", address(basicBank).balance); 
        basicBank.removeEther(1 ether);
        console.log(" -- address(this).balance AFTER REMOVE ", address(basicBank).balance);
        console.log(" -- msg.sender", msg.sender);
        assertEq(
            address(this).balance,
            1 ether,
            "expected balance of address(this) to be 1 ether"
        );
    }

    receive() external payable {}
}
