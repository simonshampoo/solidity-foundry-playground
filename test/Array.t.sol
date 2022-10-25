// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Array.sol";

contract ArrayTest is Test {
    Array public array;

    function setUp() public {
        array = new Array();
    }

    function testSumBad() public {
        uint256[] memory a = new uint256[](5);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        a[3] = 4;
        a[4] = 5;
        uint256 sum = array.badSumOf(a);
        assertEq(sum, 15);
    }

    function testSumOkay() public {
        uint256[] memory a = new uint256[](5);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        a[3] = 4;
        a[4] = 5;
        uint256 sum = array.okaySumOf(a);
        assertEq(sum, 15);
    }

    function testSumBest() public {
        uint256[] memory a = new uint256[](5);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        a[3] = 4;
        a[4] = 5;
        uint256 sum = array.sumOf(a);
        assertEq(sum, 15);
    }

    function testMax() public {
        uint256[] memory a = new uint256[](5);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;
        a[3] = 4;
        a[4] = 5;
        uint256 m = array.maxOf(a);
        console.logUint(m);
        assertEq(m, 5);
    }

}
