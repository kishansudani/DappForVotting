//SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.4;

import "./Roles.sol";
import "./voter.sol";
import "./Nomine.sol";

contract VotingMachine {

    
    // using Roles for Roles.Role;
    // Roles.Role private machine;
    
    Voter voter = new Voter();
    Nomine nomine = new Nomine();
    
    mapping (address => bool) voted; // for checking if perosn alreadyVoted
    mapping (address => uint64) votes; // for checking number of votes
    
    event doneVoting(address _address);
    
    modifier alreadyVoted(address _address) {  // check if person is alreadyVoted
        require(!personAlreadyVoted(_address));
        _;
    }
    
    modifier isPersonVoter(address _address) {  //check is person is voter
        require(voter.isAlreadyVoter(_address));
        _;
    }
    
    function addVote(address _voterPersonAddress, uint128 _nomineeNumber) public  {
        _addVote(_voterPersonAddress, _nomineeNumber);
    }
    
    function _addVote(address _voterPersonAddress, uint128 _nomineeNumber) private  {
        address nomineAddress = nomine.getNomineAddress(_nomineeNumber);
        votes[nomineAddress] += 1;
        voted[_voterPersonAddress] = true;
        emit doneVoting(_voterPersonAddress);
    }
    
    function personAlreadyVoted(address _address) public view returns(bool) {
        return voted[_address];
    }
    
    function getVotes(address _address) public view returns(uint) {
        return votes[_address];
    }
    
}