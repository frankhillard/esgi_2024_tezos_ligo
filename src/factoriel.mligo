module C = struct
  type storage = {
    value : int; 
    admin: address
  }
  type result = operation list * storage

    let rec fact : int -> int = fun n ->
        if n <= 1 then 1 else n * fact (n-1)

[@entry]
  let update_value (param: int) (storage: storage) : operation list * storage =
    let new_value = fact param in
    ([] : operation list), {storage with value = new_value}

end