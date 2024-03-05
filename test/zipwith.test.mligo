#import "./helper/utils.mligo" "Utils"

let test_zipWith =
  let lst_a = ["a"; "b"; "c"; "d"; "e"] in
  let lst_b = ["A"; "B"; "C"; "D"; "E"; "F"] in
  let expected = ["aA" ; "bB" ; "cC" ; "dD" ; "eE"] in

  let merge (s1, s2: string * string) : string = s1 ^ s2 in
  let res = Utils.zipWith lst_a lst_b merge in
  // let () = Test.log(res) in
  let () = assert (res = expected) in
  ()