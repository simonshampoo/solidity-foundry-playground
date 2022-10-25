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
    There is a bug with this function. There are multiple fail cases:  

    1. when the array length is 2 OR
    2. when a zero is present in the array 
    

    3. when both, it is when the array is just crazy. like look at this one test case that fails: 

    args = [1077, 2850, 110, 16, 50, 648, 2946, 189, 2836, 595, 10, 681, 65537, 
        2728, 2686, 365, 232, 2946, 237, 63, 3638658538924045119126437326771845363306064498, 
        416, 225, 65536, 2806, 431, 224, 323, 2402, 102, 2843, 2499, 1300, 595, 102, 1823, 
        16, 645326474426547203313410069153905908525362434349, 2964, 2964, 501, 2778, 2919, 1692
        ]

        though I'm confused because it should totally work here. overflow not a problem so what gives 
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
