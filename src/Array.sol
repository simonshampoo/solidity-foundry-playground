// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

library Array {
    function badSumOf(uint256[] memory a) public pure returns (uint256 s) {
        for (uint256 i = 0; i < a.length; i++) {
            s += a[i];
        }
    }

    function okaySumOf(uint256[] memory a) public pure returns (uint256 s) {
        for (uint256 i; i < a.length;) {
            s += a[i];
            unchecked {
                i++;
            }
        }
    }

    function sumOf(uint256[] memory a) public pure returns (uint256 ret) {
        assembly {
            // grab the length of the array
            // first 32 bytes of the array is its length
            let len := mload(a)
            // first element is actually 32 bytes bytes after, so grab it
            let element := add(a, 0x20)
            // grab the current max
            let max := mload(element)
            ret := 0
            for {
                // end = pointer to first element location + length*32 bytes per word
                let end := add(element, mul(len, 0x20))
            } lt(element, end) {
                // move onto the next word in the array
                element := add(element, 0x20)
            } { ret := add(mload(element), ret) }
        }
    }

    /*
    There is a bug with this function. Whenever there is a 0 in the array we either: 

    1. get an off-by-one error 
    2. have 0 as the max value

    */
    function maxOf(uint256[] memory a) public pure returns (uint256 max) {
        assembly {
            // grab the length of the array
            // first 32 bytes of the array is its length
            let len := mload(a)

            // first element is actually 32 bytes bytes after, so grab it
            let element := add(a, 0x20)

            // grab the current max
            max := mload(element)
            for { let end := add(element, mul(len, 0x20)) } // end = pointer to first element location + length*32 bytes per word
            lt(element, end) { element := add(element, 0x20) } {
                // move onto the next word in the array
                // // x ^ ((x ^ y) & -(x < y));
                let ele := mload(element)
                max := xor(max, and(xor(max, ele), mul(0xFFFFFFFFFFFFFFFFFFF, lt(max, ele))))
            }
        }
    }
}
