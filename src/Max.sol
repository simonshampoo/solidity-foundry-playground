// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Max {
    constructor() {}

    function negative(uint256 x) public pure returns (int256 twosComplement) {
        assembly {
            twosComplement := add(not(x), 1) // bitwise not then add 1. two's complement representation
        }
    }
}
