pragma solidity ^0.5.0;
import "../sfc/ConstantsManager.sol";

contract UnitTestConstantsManager is ConstantsManager {
    function updateMinSelfStake(uint256 v) external onlyOwner {
        minSelfStake = v;
    }

    function updateBaseRewardPerSecond(uint256 v) external onlyOwner {
        baseRewardPerSecond = v;
    }

    function updateGasPriceBalancingCounterweight(
        uint256 v
    ) external onlyOwner {
        gasPriceBalancingCounterweight = v;
    }

    function updateOfflinePenaltyThresholdTime(uint256 v) external onlyOwner {
        offlinePenaltyThresholdTime = v;
    }

    function updateTargetGasPowerPerSecond(uint256 v) external onlyOwner {
        targetGasPowerPerSecond = v;
    }
}
