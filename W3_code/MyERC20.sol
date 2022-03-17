// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyERC20 is ERC20 {

    address public owner;

    constructor(uint256 initialSupply) ERC20("MyERC20", "LOVE") {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
    }

    function mint(uint256 amount) external {
        require(msg.sender == owner);
        _mint(msg.sender, amount);
    }
}