// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MID is ERC20 {
    uint256 public MAX_CAP = 150_000_000 ether;

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        _mint(msg.sender, MAX_CAP);
    }
}
