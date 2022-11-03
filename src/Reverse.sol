// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

//reverse calldata
contract Reverse {
    function reverseCallData(bytes32 data) public returns (bytes32 ret) {
        assembly {
            let num := calldataload(0)
            //((num & 0xFF000000) >> 24) | ((num & 0x00FF0000) >> 8) | ((num & 0x0000FF00) << 8) | ((num & 0x000000FF) << 24) )
            ret := or(
                or(shr(and(num, 0xFF000000), 24), shr(and(num, 0x00FF0000), 8)),
                or(shl(and(num, 0x0000FF00), 8), shl(and(num, 0x000000FF), 24))
            )
        }
    }
}
