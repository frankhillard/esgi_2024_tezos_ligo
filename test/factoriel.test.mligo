#import "./helper/bootstrap.mligo" "Bootstrap"
#import "./helper/assert.mligo" "Assert"

#import "../src/factoriel.mligo" "MyContract"

let test_fact =
  let (owner1, _owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { value = 0; admin = owner1 } in
  let {addr ; code = _ ; size = _} = Test.originate (contract_of MyContract.C) initial_storage 0tez in
  let contr = Test.to_contract addr in
  let r = Test.transfer_to_contract contr (Update_value 5) 0tez in
  let () = Assert.tx_success r in
  let new_storage = Test.get_storage addr in 
  assert( new_storage.value = 120)