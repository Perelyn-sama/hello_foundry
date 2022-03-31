// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

interface CheatCodes {
    function assume(bool) external;
    // When fuzzing, generate new inputs if conditional not met
}

contract Safe {
    receive() external payable {}

    function withdraw() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}

import "ds-test/test.sol";

contract SafeTest is DSTest {
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    Safe safe;

    // Needed so the test contract itself can receive ether
    receive() external payable {}

    function setUp()  public {
        safe = new Safe();
    }
    // Without fuzzing 
    // function testWithdraw() public {
    //     payable(address(safe)).transfer(1 ether);
    //     uint preBalance = address(this).balance;
    //     safe.withdraw();
    //     uint256 postBalance = address(this).balance;
    //     assertEq(preBalance + 1 ether, postBalance);
    // }

    // With fuzzing 
    // function testWithdraw(uint256 amount) public {
    //     payable(address(safe)).transfer(amount);
    //     uint256 preBalance = address(this).balance;
    //     safe.withdraw();
    //     uint256 postBalance = address(this).balance;
    //     assertEq(preBalance + amount, postBalance);
    // }

    // restrict the type of amount to uint96 to make sure we don't try to send more than we have
    function testWithdraw(uint96 amount) public {
        // filter for fuzzing
        cheats.assume(amount > 0.1 ether);
        payable(address(safe)).transfer(amount);
        uint256 preBalance = address(this).balance;
        safe.withdraw();
        uint256 postBalance = address(this).balance;
        assertEq(preBalance + amount, postBalance);
    }
}