use starknet::{ContractAddress, get_caller_address};

#[starknet::interface]
pub trait IRewardSystem<TContractState> {
    fn add_points(ref self: TContractState, user: ContractAddress, amount: u256);
    fn redeem_points(ref self: TContractState, amount: u256);
    fn get_balance(self: @TContractState, user: ContractAddress ) -> u256;
}

#[starknet::contract]
mod RewardSystem {
    use super::{ContractAddress, get_caller_address};
    
    #[storage]
    struct Storage {
        balances: LegacyMap::<ContractAddress, u256>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        PointsAdded: PointsAdded,
        PointsRedeemed: PointsRedeemed,
    }

    #[derive(Drop, starknet::Event)]
    struct PointsAdded {
        user: ContractAddress,
        amount: u256,
    }

    #[derive(Drop, starknet::Event)]
    struct PointsRedeemed {
        user: ContractAddress,
        amount: u256,
    }


    #[abi(embed_v0)]
    impl RewardSystemImpl of super::IRewardSystem<ContractState> {
        fn add_points(ref self: ContractState, user: ContractAddress, amount: u256) {
            assert(amount > 0, 'Amount must be positive');
            
            let current_balance = self.balances.read(user);
            self.balances.write(user, current_balance + amount);
    
            self.emit(Event::PointsAdded(PointsAdded { user, amount }));
        }

        fn redeem_points(ref self: ContractState, amount: u256) {
            let caller = get_caller_address();
            let current_balance = self.balances.read(caller);
            
            assert(current_balance >= amount, 'Insufficient points');
            
            self.balances.write(caller, current_balance - amount);
    
            self.emit(Event::PointsRedeemed(PointsRedeemed { user: caller, amount }));
        }
        
        fn get_balance(self: @ContractState, user: ContractAddress) -> u256 {
            self.balances.read(user)
        }
    }
}
