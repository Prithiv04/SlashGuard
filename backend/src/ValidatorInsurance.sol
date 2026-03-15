// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./interfaces/IStakingPrecompile.sol";

contract ValidatorInsurance {
    IStakingPrecompile constant STAKING =
        IStakingPrecompile(0x0000000000000000000000000000000000000801);

    enum Position { Safe, Fraud }
    enum PoolStatus { Active, Resolved }

    struct Pool {
        address validator;
        uint256 safeTotal;      // DOT staked on "won't be slashed"
        uint256 fraudTotal;     // DOT staked on "will be slashed"
        PoolStatus status;
        bool slashOccurred;
        uint256 createdAt;
    }

    struct Stake {
        uint256 amount;
        Position position;
        bool claimed;
    }

    mapping(address => Pool) public pools;
    // poolId (validator address) => staker => Stake
    mapping(address => mapping(address => Stake)) public stakes;

    event PoolCreated(address indexed validator);
    event Staked(address indexed validator, address indexed staker, Position position, uint256 amount);
    event PoolResolved(address indexed validator, bool slashed);
    event Claimed(address indexed validator, address indexed staker, uint256 payout);

    // Create a new insurance pool for a validator
    function createPool(address validator) external {
        require(pools[validator].createdAt == 0, "Pool exists");
        pools[validator] = Pool({
            validator: validator,
            safeTotal: 0,
            fraudTotal: 0,
            status: PoolStatus.Active,
            slashOccurred: false,
            createdAt: block.timestamp
        });
        emit PoolCreated(validator);
    }

    // Stake native DOT on a position
    function stake(address validator, Position position) external payable {
        require(msg.value > 0, "Must send DOT");
        Pool storage pool = pools[validator];
        require(pool.status == PoolStatus.Active, "Pool not active");
        require(stakes[validator][msg.sender].amount == 0, "Already staked");

        stakes[validator][msg.sender] = Stake({
            amount: msg.value,
            position: position,
            claimed: false
        });

        if (position == Position.Safe) {
            pool.safeTotal += msg.value;
        } else {
            pool.fraudTotal += msg.value;
        }

        emit Staked(validator, msg.sender, position, msg.value);
    }

    // Resolve pool by querying PVM precompile for slash status
    function resolvePool(address validator) external {
        Pool storage pool = pools[validator];
        require(pool.status == PoolStatus.Active, "Already resolved");

        bool slashed = STAKING.isSlashed(validator);
        pool.slashOccurred = slashed;
        pool.status = PoolStatus.Resolved;

        emit PoolResolved(validator, slashed);
    }

    // Claim payout after pool resolution
    function claim(address validator) external {
        Pool storage pool = pools[validator];
        require(pool.status == PoolStatus.Resolved, "Not resolved");

        Stake storage userStake = stakes[validator][msg.sender];
        require(userStake.amount > 0, "No stake");
        require(!userStake.claimed, "Already claimed");

        bool userWon = (pool.slashOccurred && userStake.position == Position.Fraud)
                    || (!pool.slashOccurred && userStake.position == Position.Safe);
        require(userWon, "Losing position");

        uint256 winningPool = pool.slashOccurred ? pool.fraudTotal : pool.safeTotal;
        uint256 losingPool  = pool.slashOccurred ? pool.safeTotal  : pool.fraudTotal;

        // Proportional share of losing pool + return of original stake
        uint256 payout = userStake.amount + (userStake.amount * losingPool / winningPool);

        userStake.claimed = true;
        payable(msg.sender).transfer(payout);

        emit Claimed(validator, msg.sender, payout);
    }

    // View: get validator risk data directly from precompile
    function getValidatorData(address validator) external view returns (bool slashed, uint256 uptime) {
        slashed = STAKING.isSlashed(validator);
        uptime  = STAKING.getUptime(validator);
    }
}
