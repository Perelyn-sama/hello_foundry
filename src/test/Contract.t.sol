// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 <0.9.0;

import "ds-test/test.sol";

contract ContractTest is DSTest {
    function setUp() public {}

    function testExample() public {
        assertTrue(true);
    }
}

contract BasicTest is DSTest {
    uint256 testNumber;

    function setUp()  public {
        testNumber = 42;
    }

    function testNumberIs42() public {
        assertEq(testNumber, 42);
    }

    function testFailUnderflow()  public {
        testNumber -= 43;
    }

    // A good practice is to use something like testCannot in combination with the expectRevert cheatcode, instead of testFail, so you know what reverted:
    // function testCannotSubtract43() public {
    //     cheats.expectRevert(abi.encodeWithSignature("Panic(uint256)", 0x11));
    //     testNumber -= 43;
    // }   
}
