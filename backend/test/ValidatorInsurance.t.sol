// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ValidatorInsurance.sol";

contract ValidatorInsuranceTest is Test {
    ValidatorInsurance insurance;
    address validator = address(0xABC);
    address alice = address(0x1);
    address bob   = address(0x2);

    function setUp() public {
        insurance = new ValidatorInsurance();
        vm.deal(alice, 100 ether);
        vm.deal(bob, 100 ether);
    }

    function test_CreatePool() public {
        insurance.createPool(validator);
        (address v,,,,, uint256 createdAt) = insurance.pools(validator);
        assertEq(v, validator);
        assertGt(createdAt, 0);
    }

    function test_Stake() public {
        insurance.createPool(validator);
        vm.prank(alice);
        insurance.stake{value: 50 ether}(validator, ValidatorInsurance.Position.Safe);
        (, uint256 safeTotal,,,, ) = insurance.pools(validator);
        assertEq(safeTotal, 50 ether);
    }

    function test_ResolveAndClaim() public {
        insurance.createPool(validator);
        vm.prank(alice);
        insurance.stake{value: 50 ether}(validator, ValidatorInsurance.Position.Safe);
        vm.prank(bob);
        insurance.stake{value: 10 ether}(validator, ValidatorInsurance.Position.Fraud);

        // Mock precompile: validator NOT slashed
        vm.mockCall(
            0x0000000000000000000000000000000000000801,
            abi.encodeWithSignature("isSlashed(address)", validator),
            abi.encode(false)
        );

        insurance.resolvePool(validator);

        uint256 balBefore = alice.balance;
        vm.prank(alice);
        insurance.claim(validator);
        assertGt(alice.balance, balBefore);
    }
}
