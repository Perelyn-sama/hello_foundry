// SPDX-License-Identifier: MIT
pragma solidity >=0.4.0 <0.9.0;

contract OwnerUpOnly {
    address public immutable owner;
    uint256 public count;

    constructor() {
        owner = msg.sender;
    }

    function increment() external {
        require(msg.sender == owner, "Only the owner can increment the count");
        count++;
    }
}

import "ds-test/test.sol";

// contract OwnerUpOnlyTest is DSTest {
//     OwnerUpOnly upOnly;
    
//     function setUp() public {
//         upOnly = new OwnerUpOnly();
//     }

//     function testIncrementAsOwner() public {
//         assertEq(upOnly.count(), 0);
//         upOnly.increment();
//         assertEq(upOnly.count(), 1);
//     }
// }

// interface CheatCodes {
//     function prank(address) external;
//     function expectRevert(bytes calldata) external;
// }

// contract OwnerUpOnlyTest is DSTest {
//     CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
//     OwnerUpOnly upOnly;

//     // setUp
//     // testIncrementAsOwner

//     // function testFailIncrementAsNotOwner() public {
//     //     cheats.prank(address(0));
//     //     upOnly.increment();
//     // }

//     // Notice that we replaced `testFail` with `test`
//     function testIncrementAsNotOwner() public {
//         cheats.expectRevert(bytes("Only the owner can increment the count"));
//         cheats.prank(address(0));
//         upOnly.increment();
//     }
// }

interface CheatCodes {
  function prank(address) external;
  function expectRevert(bytes calldata) external;
}

contract OwnerUpOnlyTest is DSTest {
  CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
  OwnerUpOnly upOnly;

  // setUp
  // testIncrementAsOwner

  // Notice that we replaced `testFail` with `test`
  function testIncrementAsNotOwner() public {
    cheats.expectRevert(
      bytes("only the owner can increment the count")
    );
    cheats.prank(address(0));
    upOnly.increment();
  }
}
