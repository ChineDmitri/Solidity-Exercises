// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

// You may modify this contract
// -- public: visible externally and internally (creates a getter function for storage/state variables)
// -- private: only visible in the current contract
// -- external: only visible externally (only for functions) - i.e. can only be message-called (via this.func)
// -- internal: only visible internally
// -- DEFAULT: only visible external
contract Parent {
    uint256 internal _value;
}

contract Child is Parent {
    /*
        This exercise assumes you understand how access modifiers works.
        1. `_value` variable is private and can only be accessed by `Parent` contract. Make the variable accessible
           to `Parent` and `Child` contract ONLY.
    */

    function setValue(uint256 newValue) public {
        _value = newValue;
    }

    function getValue() public view returns (uint256) {
        return _value;
    }

}
