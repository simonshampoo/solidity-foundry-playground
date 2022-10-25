// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract Counter {
    uint256 public number;

    function setNumber(uint256 newNumber) public {
        assembly {
            // first need to find where number is stored in storage
            // probably at storage slot 0? idk look it up
            // then we simply store calldata into the slot where ``number`` is stored
            // gg ez, go return 0
            sstore(number.slot, newNumber)
            return(0, 0)
        }
    }

    function increment() public {
        assembly {
            sstore(number.slot, add(sload(number.slot), 1))
            return(0, 0)
        }
    }
}
