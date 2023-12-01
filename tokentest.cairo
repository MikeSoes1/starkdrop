#[starknet::contract]
mod MyToken {
    use starknet::ContractAddress;
    use openzeppelin::token::erc20::ERC20;

    #[storage]
    struct Storage {}

    #[constructor]
    fn constructor(self: @ContractState) {
        let name = 'MyToken';
        let symbol = 'MTK';

        let mut unsafe_state = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::initializer(ref unsafe_state, name, symbol);
    }

    #[external(v0)]
    fn mint(
        self: @ContractState,
        recipient: ContractAddress,
        amount: u256
    ) {
        // This function is NOT protected which means
        // ANYONE can mint tokens
        let mut unsafe_state = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::_mint(ref unsafe_state, recipient, amount);
    }
}
