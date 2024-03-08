module C = struct
  type storage = {
    ledger : (address, nat) big_map;
    admin: address;
  }

  type ret = operation list * storage

  module Errors = struct
    let not_admin = "Not admin"
    let not_allowed = "Not allowed"
    let not_enough_funds = "Not enough funds"
    let unknown_user = "Unknown user"
  end

  // Two entrypoints
  [@entry] let mint (to_, amount: address * nat) (store : storage) : ret = 
    let () = assert_with_error ((Tezos.get_sender()) = store.admin) Errors.not_admin in
    let new_ledger = match Big_map.find_opt to_ store.ledger with
    | Some(a) -> Big_map.update to_ (Some(amount + a)) store.ledger
    | None    -> Big_map.add to_ amount store.ledger
    in
    [], { store with ledger = new_ledger }

  [@entry] let burn (from_, amount: address * nat) (store : storage) : ret = 
    let () = assert_with_error ((Tezos.get_sender()) = store.admin) Errors.not_admin in
    let new_ledger = match Big_map.find_opt from_ store.ledger with
    | Some(a) -> 
      let () = assert_with_error (a >= amount) Errors.not_enough_funds in 
      Big_map.update from_ (Some(abs(a - amount))) store.ledger
    | None    -> failwith Errors.unknown_user
    in
    [], { store with ledger = new_ledger }

  [@entry] let transfer (from_, to_, amount: address * address * nat) (store : storage) : ret =     
    let () = assert_with_error ((Tezos.get_sender()) = from_) Errors.not_allowed in
    let ledger_updated = match Big_map.find_opt to_ store.ledger with
    | Some(tb) -> Big_map.update to_ (Some(amount + tb)) store.ledger
    | None -> Big_map.add to_ amount store.ledger
    in
    let ledger_updated = match Big_map.find_opt from_ ledger_updated with
    | Some(fb) -> 
      let () = assert_with_error (fb >= amount) Errors.not_enough_funds in
      Big_map.update from_ (Some(abs(fb - amount))) ledger_updated
    | None -> failwith Errors.not_enough_funds
    in
    [], { store with ledger = ledger_updated }


  [@view] let balance_of (from_: address) (store: storage) : nat =
    match Big_map.find_opt from_ store.ledger with
    | Some(fb) -> fb
    | None -> 0n

end