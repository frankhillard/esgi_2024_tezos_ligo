#import "./helper/bootstrap.mligo" "Bootstrap"
#import "./helper/assert.mligo" "Assert"

#import "../src/caller.mligo" "Caller"
#import "../src/counter.mligo" "Counter"

let test_call =
  let (owner1, _owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
  let initial_storage = { value = 0; admin = owner1 } in
  let {addr = addr_counter ; code = _ ; size = _} = Test.originate (contract_of Counter.C) initial_storage 0tez in
  let _contr_counter = Test.to_contract addr_counter in
  let {addr = addr_caller ; code = _ ; size = _} = Test.originate (contract_of Caller.C) initial_storage 0tez in
  let contr_caller = Test.to_contract addr_caller in
  let r = Test.transfer_to_contract contr_caller (Call_increment (5,Test.to_address addr_counter)) 0tez in
  let () = Assert.tx_success r in
  let new_storage = Test.get_storage addr_counter in 
  assert( new_storage.value = 5)

let test_call2 =
// Initialisation des adresses
  let (owner1, _owner2, _owner3, _, _, _, _) = Bootstrap.boot_accounts() in
// Storage initial (utilisé pour les deux contrats)
  let initial_storage = { value = 0; admin = owner1 } in
// Instanciation du contrat Counter  
  let {addr = addr_counter ; code = _ ; size = _} = Test.originate (contract_of Counter.C) initial_storage 0tez in
  let _contr_counter = Test.to_contract addr_counter in
// Instanciation du contrat Caller
  let {addr = addr_caller ; code = _ ; size = _} = Test.originate (contract_of Caller.C) initial_storage 0tez in
  let contr_caller = Test.to_contract addr_caller in
// Requête d'incrémentation  
  let _r = Test.transfer_to_contract contr_caller (Call_increment (5,Test.to_address addr_counter)) 0tez in
// Requête de visionnage  
  let r = Test.transfer_to_contract contr_caller (Update_value (Test.to_address addr_counter)) 0tez in
//  Vérification du résultat  
  let () = Assert.tx_success r in
  let new_storage = Test.get_storage addr_caller in 
  assert( new_storage.value = 5)