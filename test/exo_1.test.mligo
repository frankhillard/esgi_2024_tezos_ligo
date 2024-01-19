#import "./helper/bootstrap.mligo" "Bootstrap"
#import "./helper/assert.mligo" "Assert"

#import "../src/exo_1.mligo" "MyContract"

// type param = MyContract.C parameter_of

let test_exo_1_solution_check_initial_storage =
  let (owner1, _owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { value = 42; admin = owner1 } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  assert (Test.get_storage addr = initial_storage)


let test_exo_1_solution_increment =
  let (owner1, _owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { value = 42; admin = owner1 } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let _r = Test.transfer_to_contract contr (Increment 1) 0tez in
  let current_storage = Test.get_storage addr in
  assert(current_storage.value = 43)

let test_exo_1_solution_reset_success =
  let (owner1, _owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { value = 42; admin = owner1 } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner1 in
  let _r = Test.transfer_to_contract contr (Reset) 0tez in
  let current_storage = Test.get_storage addr in
  assert(current_storage.value = 0)

let test_exo_1_solution_reset_failure =
  let (owner1, owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { value = 42; admin = owner1 } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let () = Test.set_source owner2 in
  let r = Test.transfer_to_contract contr (Reset) 0tez in
  let () = Assert.string_failure r MyContract.C.Errors.not_admin in
  let current_storage = Test.get_storage addr in
  assert(current_storage.value = initial_storage.value)