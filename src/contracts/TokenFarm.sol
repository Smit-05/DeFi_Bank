pragma solidity ^0.5.0;

import "./DappToken.sol";
import "./DaiToken.sol";

contract TokenFarm{

    string public name = "Dapp Token Farm";
    DappToken public dappToken;
    DaiToken public daiToken;

    address[] public stakers;
    mapping(address => uint) public stakingBalance;
    mapping(address => bool) public hasStaked;
    mapping(address => bool) public isStaking;

    constructor(DappToken _dappToken,DaiToken _daiToken) public {
        dappToken = _dappToken;
        daiToken = _daiToken;
    }

    //Stake Tokens
    function stakeTokens(uint _amount) public payable{

        

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


    }

    //Issuing Token
    function issueTokens() public{
        for(uint i=0;i<stakers.length;i++){
            
        }
    }

    //UnStacking Tokens(Withdraw)


}
