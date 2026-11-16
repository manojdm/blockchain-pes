pragma solidity ^0.5.17;

import "./rwd.sol";
import "./token.sol";

contract Management {
    string public name = "Management Token";
    address public owner;
    Tether tether;
    RWD rwd;

    address[] public stakers;

    mapping(address => uint256) stakingBalance;
    mapping(address => bool) isStaking;
    mapping(address => bool) hasStaked;

    constructor(RWD _rwd, Tether _tether) public {
        rwd = _rwd;
        tether = _tether;
        owner = msg.sender;
    }

    function depositTokens(uint256 amount) public {
        require(amount > 0);
        tether.transferFrom(msg.sender, address(this), amount);

        stakingBalance[msg.sender] += amount;

        if (!hasStaked[msg.sender]) {
            stakers.push(msg.sender);
        }

        hasStaked[msg.sender] = true;
        isStaking[msg.sender] = true;
    }

    function unstakeTokens() public {
        require(stakingBalance[msg.sender] > 0, "No Staked Amount");

        tether.transfer(msg.sender, stakingBalance[msg.sender]);

        stakingBalance[msg.sender] = 0;
        isStaking[msg.sender] = false;
    }

    function issueTokens() public {
        require(msg.sender == owner, "caller must be the owner");

        for (uint256 i = 0; i < stakers.length; i++) {
            address recipient = stakers[i];
            uint256 balance = stakingBalance[recipient] / 9;

            if (balance > 0) {
                rwd.transfer(recipient, balance);
            }
        }
    }
}
