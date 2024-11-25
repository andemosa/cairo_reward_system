# Starknet Reward System Smart Contract

## Overview
This is a Starknet smart contract that tracks user balances for a reward system.

## Features
- Add points for users
- Redeem points
- Track individual user points
- Event logging for points addition and redemption

## Contract Interface
The contract provides the following functions:
- `add_points(user: ContractAddress, amount: u256)`: Add points to a specific user
- `redeem_points(amount: u256)`: Redeem points for the caller
- `get_balance(user: ContractAddress) -> u256`: Retrieve points balance for a user

## Events
The contract emits two types of events:
- `PointsAdded`: Triggered when points are added to a user's account
- `PointsRedeemed`: Triggered when a user redeems points

## Security Features
- Prevents adding points below zero
- Prevents point redemption if insufficient balance

## Technical Details
- Written in Cairo
- Developed for Starknet Cairo Bootcamp III

## Usage Example
```cairo
// Adding points to a user
reward_system.add_points(user_address, 100);

// Checking user's point balance
let points = reward_system.get_balance(user_address);

// Redeeming points
reward_system.redeem_points(50);
```

## Error Handling
- Throws 'Amount must be positive' error when attempting to add points below zero
- Throws 'Insufficient points' error when attempting to redeem more points than available

## Deployment
To deploy this contract, you'll need:
- Starknet development environment
- Cairo compiler
- Starknet CLI or compatible deployment tool
