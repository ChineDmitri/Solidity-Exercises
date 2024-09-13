// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

event EtherRemoved(address indexed user, uint256 amount);
event EtherRemovalFailed(address indexed user, uint256 amount, string reason);

contract BasicBankV2 {
    /// used to store the balance of users
    ///     USER    =>  BALANCE
    mapping(address => uint256) public balances;

    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        balances[msg.sender] += msg.value;
    }

    /// @notice used to withdraw ether from the contract
    /// @param amount of ether to remove. Cannot execeed balance i.e users cannot withdraw more than they deposited
    function removeEther(uint256 amount) external payable {

        if (amount == 0) {
            emit EtherRemovalFailed(msg.sender, amount, "Le montant doit etre superieur a zero");
        }   

        if (amount > balances[msg.sender]) {
            emit EtherRemovalFailed(msg.sender, amount, "Solde insuffisant");
        }        
        
    	payable(msg.sender).transfer(amount);
    }

    function getBalancesContract() public view returns (uint256) {
        return address(this).balance;
    }

    function getBalances() public view returns (uint256) {
        return balances[msg.sender];
    }

    function getBalanceOf(address account) public view returns (uint256) {
        return balances[account];
    }       
}
