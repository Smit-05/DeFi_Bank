pragma solidity ^0.5.0;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm{

    string public name = "Dapp Token Farm";
    address public owner;
    DappToken public dappToken;
    DaiToken public daiToken; 
    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;
    mapping(address => uint) public time;

    constructor(DappToken _dappToken,DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
        owner = msg.sender;
    }

    //Stake Tokens
    function stakeTokens(uint _amount) public {

        require( _amount > 0,"Amount cannot be 0");        

        //Transfer to this(TokenFarm) contract
        daiToken.transferFrom(msg.sender, address(this), _amount);

        //Updating stake balance
        stakingBalance[msg.sender] += _amount;

        //Add user to stakers array only if they haven't staked already
        if(!hasStaked[msg.sender]){
            stakers.push(msg.sender);
        }

        //Staking status
        isStaking[msg.sender] = true;
        hasStaked[msg.sender] = true;
        time[msg.sender] = block.timestamp;

    }

    
    //Issuing Token
    function issueTokens() public {

        require(msg.sender==owner,"Caller must be owner");

        for(uint i=0;i<stakers.length;i++){
            address recipient = stakers[i];
            uint balance = stakingBalance[recipient];
            if(balance>0){
                dappToken.transfer(recipient, balance);
            }
        }
    }

    //UnStacking Tokens(Withdraw)
    function unstakeTokens() public {

        uint balance = stakingBalance[msg.sender];
        require(balance>0,"Balance cannot be zero");
        
        daiToken.transfer(msg.sender, balance);
        stakingBalance[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }

}
