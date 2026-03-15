// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IStakingPrecompile {
    // Returns true if validator has any slashing spans recorded
    function isSlashed(address validator) external view returns (bool);

    // Returns authored blocks in current era (proxy for uptime)
    function getUptime(address validator) external view returns (uint256);

    // Returns era reward points for a given validator and era
    function getEraPoints(address validator, uint32 era) external view returns (uint256);
}
