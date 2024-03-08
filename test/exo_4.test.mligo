#import "./helper/bootstrap.mligo" "Bootstrap"
#import "./helper/assert.mligo" "Assert"

#import "./caller/caller.instance.mligo" "CALLER"

#import "../src/exo_4.mligo" "MyContract"

let test_exo_4_solution_check_initial_storage =
  let (owner1, _owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let current_storage = Test.get_storage addr in
  let () = assert (Test.michelson_equal (Test.eval current_storage) (Test.eval initial_storage)) in  
  ()

let test_exo_4_solution_mint =
  let (owner1, owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 100n)]) ) in
  ()


let test_exo_4_solution_mint_failure =
  let (owner1, owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner2 in
  let r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let () = Assert.string_failure r MyContract.C.Errors.not_admin in

  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = initial_storage.ledger) in
  ()


let test_exo_4_solution_mint_twice =
  let (owner1, owner2, owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let _r = Test.transfer_to_contract contr (Mint (owner3, 50n)) 0tez in
  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 100n);(owner3, 50n)]) ) in
  ()

let test_exo_4_solution_burn =
  let (owner1, owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = Big_map.literal([(owner2, 100n)]);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Burn (owner2, 50n)) 0tez in
  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 50n)]) ) in
  ()


let test_exo_4_solution_mint_burn =
  let (owner1, owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let _r = Test.transfer_to_contract contr (Burn (owner2, 50n)) 0tez in
  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 50n)]) ) in
  ()

let test_exo_4_solution_burn_failure_unknown_user =
  let (owner1, owner2, owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let () = Test.set_source owner1 in
  let r = Test.transfer_to_contract contr (Burn (owner3, 100n)) 0tez in
  let () = Assert.string_failure r MyContract.C.Errors.unknown_user in

  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 100n)]) ) in
  ()

let test_exo_4_solution_burn_failure_not_enough_funds =
  let (owner1, owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let () = Test.set_source owner1 in
  let r = Test.transfer_to_contract contr (Burn (owner2, 1000n)) 0tez in
  let () = Assert.string_failure r MyContract.C.Errors.not_enough_funds in

  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 100n)]) ) in
  ()

let test_exo_4_solution_transfer_success =
  let (owner1, owner2, owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = Big_map.literal([(owner2, 100n)]);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner2 in
  let _r = Test.transfer_to_contract contr (Transfer (owner2, owner3, 50n)) 0tez in
  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 50n);(owner3, 50n)]) ) in
  ()


let test_exo_4_solution_mint_transfer_success =
  let (owner1, owner2, owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let () = Test.set_source owner2 in
  let _r = Test.transfer_to_contract contr (Transfer (owner2, owner3, 50n)) 0tez in
  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 50n);(owner3, 50n)]) ) in
  ()

let test_exo_4_solution_mint_transfer_failure_not_allowed =
  let (owner1, owner2, owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let r = Test.transfer_to_contract contr (Transfer (owner2, owner3, 50n)) 0tez in
  let () = Assert.string_failure r MyContract.C.Errors.not_allowed in

  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 100n)]) ) in
  ()


let test_exo_4_solution_mint_transfer_failure_not_enough_funds =
  let (owner1, owner2, owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let () = Test.set_source owner2 in
  let r = Test.transfer_to_contract contr (Transfer (owner2, owner3, 150n)) 0tez in
  let () = Assert.string_failure r MyContract.C.Errors.not_enough_funds in

  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 100n)]) ) in
  ()


let test_exo_4_solution_balanceof =
  let (owner1, owner2, owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { 
    admin = owner1;
    ledger = (Big_map.empty: (address, nat) big_map);
  } in
  // DEPLOY C contract
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Mint (owner2, 100n)) 0tez in
  let () = Test.set_source owner2 in
  let _r = Test.transfer_to_contract contr (Transfer (owner2, owner3, 75n)) 0tez in
  

  let token_address : address = Tezos.address contr in
  // DEPLOY CALLER contract
  let { addr = addr_contract_caller; code = _code_contract_caller; size = _size_contract_caller}  = Test.originate (contract_of CALLER) 42n 0tez in
  let contr_caller = Test.to_contract addr_contract_caller in
  // call CALLER contract (which calls the balance_of view of the C contract)
  let _ = Test.transfer_to_contract_exn contr_caller (Request (token_address,owner3)) 0tez in
  let storage_caller = Test.get_storage addr_contract_caller in
  let () = assert(storage_caller = 75n) in

  let current_storage = Test.get_storage addr in
  let () = assert (current_storage.admin = initial_storage.admin) in
  let () = assert (current_storage.ledger = Big_map.literal([(owner2, 25n); (owner3, 75n)]) ) in
  ()


