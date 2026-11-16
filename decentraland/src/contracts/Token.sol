pragma solidity ^0.5.17;

contract Tether {
    string public name = "abc token";
    string public symbol = "ausdt";
    uint256 public totalSupply = 1000000000000000000000000;
    uint256 public decimals = 18;

    event Withdrawl(address from, address to, uint256 amount);

    event Approval(address owner, address to, uint256 amount);

    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() public {
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address to, uint256 amount)
        public
        returns (bool suceess)
    {
        //prerequisite
        require(balanceOf[msg.sender] > amount);

        //deduct amount from sender
        balanceOf[msg.sender] -= amount;

        // send amount to address
        balanceOf[to] += amount;

        //emit transaction
        emit Withdrawl(msg.sender, to, amount);

        return true;
    }

    function approve(address sender, uint256 amount)
        public
        returns (bool success)
    {
        allowance[msg.sender][sender] = amount;
        emit Approval(msg.sender, sender, amount);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public {
        require(amount <= balanceOf[from]);
        require(amount <= allowance[from][msg.sender]);

        //add and subtract the balances
        balanceOf[to] += amount;
        balanceOf[from] -= amount;
        allowance[msg.sender][from] -= amount;
    }
}
