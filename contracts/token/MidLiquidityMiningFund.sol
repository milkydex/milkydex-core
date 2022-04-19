// SPDX-License-Identifier: MIT

pragma solidity 0.8.4;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract MidLiquidityMiningFund is Ownable {
    using SafeERC20 for IERC20;
    IERC20 public token;
    uint256 public claimedAmount;

    mapping(address => bool) public requesters;
    address[] public requestersArray;

    /*===================== CONSTRUCTOR =====================*/

    constructor(address _token) {
        require(_token != address(0), "VestedFund:: Invalid address");
        token = IERC20(_token);
    }

    /*===================== VIEWS =====================*/

    function balance() external view returns (uint256) {
        return token.balanceOf(address(this));
    }

    /*===================== MUTATIVE =====================*/

    function transfer(address receiver, uint256 amount) external {
        require(receiver != address(0), "MilkyDexLiquidityMiningFund:: Invalid address");
        require(requesters[msg.sender], "MilkyDexLiquidityMiningFund:: Not allowed");
        token.safeTransfer(receiver, amount);
    }

    function addRequester(address _addr) external onlyOwner {
        require(_addr != address(0), "MilkyDexLiquidityMiningFund:: Invalid address");
        require(!requesters[_addr], "MilkyDexLiquidityMiningFund:: Address was previously added");
        requesters[_addr] = true;
        requestersArray.push(_addr);
        emit RequesterAdded(_addr);
    }

    function removeRequester(address _addr) external onlyOwner {
        require(
            requesters[_addr],
            "MilkyDexLiquidityMiningFund:: Address not found in requesters list"
        );
        delete requesters[_addr];
        for (uint256 i = 0; i < requestersArray.length; i++) {
            if (requestersArray[i] == _addr) {
                requestersArray[i] = address(0);
                // This will leave a null in the array and keep the indices the same
                break;
            }
        }
        emit RequesterRemoved(_addr);
    }

    /*===================== EVENTS =====================*/

    event RequesterAdded(address indexed _addr);
    event RequesterRemoved(address indexed _addr);
}
