//       A       B
//      ➡️      ⬅️
//     | a | b | c | ⬇️ C
//     | d | e | f | 
//     | g | h | i | ⬆️ D


let flipA(board: string list list list):string list list list = 
    let oldLine1 = board[0]
    let newLine1 = append(oldLine1[0],oldLine1[1]...)