module doodoo::coin {
    use std::string::utf8;
    use std::signer;

    use aptos_framework::coin;

    struct DooDoo {}

    public entry fun initialize(acc: &signer) {
        let (burn_cap, freeze_cap, mint_cap) = coin::initialize<DooDoo>(
            acc,
            utf8(b"DooDoo"),
            utf8(b"doodoo"),
            8,
            true,
        );

        coin::register<DooDoo>(acc);

        let minted_coins = coin::mint(4200000000000000, &mint_cap);
        coin::deposit(signer::address_of(acc), minted_coins);

        coin::destroy_burn_cap(burn_cap);
        coin::destroy_freeze_cap(freeze_cap);
        coin::destroy_mint_cap(mint_cap);
    }
}
