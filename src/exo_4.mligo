// This is mycontract.mligo
module C = struct
  type storage = {
    admin: address;
    users : address set;
    ledger : (address, nat) big_map;
  }
  type result = operation list * storage

  module Errors = struct
    let not_admin = "Not admin"
  end

  // Two entrypoints
  [@entry] let transfer (delta : int) (store : storage) : result = [],store
  
end