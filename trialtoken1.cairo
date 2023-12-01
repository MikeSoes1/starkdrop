#[starknet::contract]
mod MyToken {
    use starknet::ContractAddress;
    use openzeppelin::token::erc20::ERC20;

    #[storage]
    struct Storage {}

    #[constructor]
    fn constructor(
        self: @ContractState,
        initial_supply: u256,
        recipient: ContractAddress
    ) {
        let name = 'MyToken';
        let symbol = 'MTK';

        let mut unsafe_state = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::initializer(ref unsafe_state, name, symbol);
        ERC20::InternalImpl::_mint(ref unsafe_state, recipient, initial_supply);
    }
}
