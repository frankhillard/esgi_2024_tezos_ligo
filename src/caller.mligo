module C = struct
    type storage = {
        value: int;
        admin: address
    }

type result = operation list * storage

let get_entrypoint(addr, name:address*string) = 
    if name = "increment" then
        match Tezos.get_entrypoint_opt "%increment" addr with
            | Some contract -> contract
            | None -> failwith "Error"
    else
        failwith "Unsupported entrypoint"

[@entry] let call_increment (delta,addr : int*address) (store : storage) : result = 
    let add : int contract = get_entrypoint(addr, "increment") in
    let op = Tezos.transaction delta 0mutez add in
    [op], store

[@entry] let update_value (addr:address) (store: storage):result = 
    let call_response: int option = Tezos.call_view "show" () addr in
    let v = match call_response with
    | Some value -> value
    | None -> failwith "Error"
    in
    [],{store with value = v}
    
end