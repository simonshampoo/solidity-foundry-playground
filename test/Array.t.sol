// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Array.sol";

contract ArrayTest is Test {
    using Array for *;

    function setUp() public {}

    function testSumBad() public {
        uint256[] memory a = new uint256[](5);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        a[3] = 4;
        a[4] = 5;
        uint256 sum = Array.badSumOf(a);
        assertEq(sum, 15);
    }

    function testSumOkay() public {
        uint256[] memory a = new uint256[](5);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        a[3] = 4;
        a[4] = 5;
        uint256 sum = Array.okaySumOf(a);
        assertEq(sum, 15);
    }

    function testSumBest() public {
        uint256[] memory a = new uint256[](5);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        a[3] = 4;
        a[4] = 5;
        uint256 sum = Array.sumOf(a);
        assertEq(sum, 15);
    }

    function testMax(uint256[] memory a) public {
        bool zeroPresent = false;
        for (uint256 i; i < a.length;) {
            if (a[i] <= 0) {
                zeroPresent = true;
                break;
            }
            unchecked {
                i++;
            }
        }
        vm.assume(!zeroPresent);

        uint256 m = Array.maxOf(a);
        uint256 max = 0;
        for (uint256 i; i < a.length;) {
            if (a[i] > max) {
                max = a[i];
            }
            unchecked {
                i++;
            }
        }

        assertEq(m, max);
    }
}
