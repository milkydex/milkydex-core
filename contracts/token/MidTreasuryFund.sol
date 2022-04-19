// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;

import "./VestedFund.sol";

contract MidTreasuryFund is VestedFund {
    uint256 public constant ALLOCATION = 15_000_000 ether; // 10%
    uint256 public constant VESTING_DURATION = 3 * 365 * 24 * 3600; // 3 years
    uint256 public constant VESTING_START = 1650549600; // 21th Apr 2022, 2PM UTC

    constructor(address _token) VestedFund(_token) {}

    function allocation() public pure override returns (uint256) {
        return ALLOCATION;
    }

    function vestingStart() public pure override returns (uint256) {
        return VESTING_START;
    }

    function vestingDuration() public pure override returns (uint256) {
        return VESTING_DURATION;
    }
}
