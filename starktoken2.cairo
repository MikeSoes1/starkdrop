#[starknet::contract]
mod MyToken {
    use starknet::ContractAddress;
    use openzeppelin::access::ownable::Ownable;
    use openzeppelin::token::erc20::ERC20;

    #[storage]
    struct Storage {}

    #[constructor]
    fn constructor(self: @ContractState, owner: ContractAddress) {
        // Set contract owner
        let mut unsafe_ownable = Ownable::unsafe_new_contract_state();
        Ownable::InternalImpl::initializer(ref unsafe_ownable, owner);

        // Initialize ERC20
        let name = 'MyToken';
        let symbol = 'MTK';

        let mut unsafe_erc20 = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::initializer(ref unsafe_erc20, name, symbol);
    }

    #[external(v0)]
    fn mint(
        self: @ContractState,
        recipient: ContractAddress,
        amount: u256
    ) {
        // Set permissions with Ownable
        let unsafe_ownable = Ownable::unsafe_new_contract_state();
        Ownable::InternalImpl::assert_only_owner(@unsafe_ownable);

        // Mint tokens if called by the contract owner
        let mut unsafe_erc20 = ERC20::unsafe_new_contract_state();
        ERC20::InternalImpl::_mint(ref unsafe_erc20, recipient, amount);
    }
}
