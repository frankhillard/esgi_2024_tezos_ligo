type storage = nat
type ret = operation list * storage

[@entry]
let request (token_addr, user : address * address) (_store : storage) : ret = 
    let new_storage = match Tezos.call_view "balance_of" user token_addr with
    | None -> 0n
    | Some(v) -> v
    in
    [] , new_storage