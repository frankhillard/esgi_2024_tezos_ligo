let rec zip(l1,l2: int list * int list) : (int*int)list =
  match l1, l2 with
  | [], [] -> []
  | _,  [] -> []
  | [], _  -> []
  | h1::t1, h2::t2 -> (h1, h2) :: zip (t1, t2)


let reverse(a,b:int*string) : (string*int) = (b,a)
let reverseNCur(a,b:int*int) : (int*int) = (b,a)

let rec zipWith (type a b c)(l1: a list) (l2: b list) (f: (a*b)->c) : c list =
    match l1, l2 with
    | [], [] -> []
    | _,  [] -> []
    | [], _  -> []
    | h1::t1, h2::t2 -> f(h1, h2) :: zipWith t1 t2 f

let rec zipWithNCur(l1,l2,f:int list*int list*((int*int)->int*int)) : (int*int)list =
    match l1, l2 with
    | [], [] -> []
    | _,  [] -> []
    | [], _  -> []
    | h1::t1, h2::t2 -> f(h1, h2) :: zipWithNCur( t1,t2,f)

let test_zipWith =
    let l1 = 1::2::3::[] in
    let l2 = ["2";"3";"4"] in
    let result = zipWith l1 l2 reverse in
    let () = Test.log(result) in
    assert(result = ("2",1)::("3",2)::("4",3)::[])

let test_zipWithNCur =
    let l1 = 1::2::3::[] in
    let l2 = [2;3;4] in
    let result = zipWithNCur( l1,l2, reverseNCur) in
    let () = Test.log(result) in
    assert(result = (2,1)::(3,2)::(4,3)::[])