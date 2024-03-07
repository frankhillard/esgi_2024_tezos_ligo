module C = struct

    type register = (address,nat)big_map

    type storage = {
        ledger : register;
        total_supply : nat;
        admin : address;
    }

    type result = operation list * storage

    let addValue(m,key,value:register*address*nat): register = Big_map.add key value m

    let updateValue(m,key,value:register*address*nat):register = Big_map.update key (Some value) m

    [@entry] let mint (amount: nat) (store : storage) : result =
        let store = { store with ledger = addValue(store.ledger,(Tezos.get_sender()),amount); total_supply = store.total_supply + amount } in
        [],store

    [@entry] let transfer (addr,amount:address*nat) (store : storage) : result =
        let balance1 = match Big_map.find_opt (Tezos.get_sender()) store.ledger with
            |Some l -> l
            |None -> failwith "No ledger found"
        in
        let _ = assert_with_error (balance1 >= amount) "Not enough money in bank account" in
        let new_amount1 = abs(balance1 - amount) in
        let balance2 = match Big_map.find_opt addr store.ledger with
            |Some l -> l
            |None -> 0n
        in
        let new_amount2 = balance2 + amount in
        [],{store with ledger = updateValue(updateValue(store.ledger,(Tezos.get_sender()),new_amount1),addr,new_amount2)}
end