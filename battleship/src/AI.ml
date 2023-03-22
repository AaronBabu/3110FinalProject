open Random
open Char

type ship =
  | Ship1
  | Ship2
  | Ship3
  | Ship4
  | Ship5

type ships = {
  ship : ship;
  length : int;
}

let randomgrid =
  [
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
  ]

let () = Random.self_init ()

let used_coords = ref []

let ywing = {ship = Ship1; length = 2}
let xwing = {ship = Ship2; length = 2}
let mfalcon = {ship = Ship3; length = 3}
let delta7 = {ship = Ship4; length = 3 }
let stardestroyer = {ship = Ship5; length = 4}
let shipList = [ywing; xwing; mfalcon; delta7; stardestroyer]
let letter_randomizer () =
  let random_int = Random.int 10 + 65 in chr random_int
let number_randomizer () = 
  let random_int = Random.int 10 in random_int + 1
let coord () = (letter_randomizer (), number_randomizer ())

let rec generate_ship_coords len coord dir acc =
  match len, coord, dir with
  | 0, _, _ -> acc
  | _, (c, n), 'h' when Char.code c < Char.code 'J' ->
      let new_coord = (Char.chr (Char.code c + 1), n) in
      if Char.code (fst new_coord) <= Char.code 'J' && not (List.mem new_coord !used_coords) then
        generate_ship_coords (len - 1) new_coord 'h' (new_coord :: acc)
      else
        acc
  | _, (c, n), 'v' when n < 10 ->
      let new_coord = (c, n + 1) in
      if snd new_coord <= 10 && not (List.mem new_coord !used_coords) then
        generate_ship_coords (len - 1) new_coord 'v' (new_coord :: acc)
      else
        acc
  | _, _, _ -> acc
  


let rec place_ship (ship:ships) =
  let length = ship.length in 
  let (col, row) = coord () in 
  let direction = if Random.bool () then 'h' else 'v' in
  let coords = (col, row) :: generate_ship_coords (length - 1) (col, row) direction [] in
  if List.length coords = length then
    coords
  else
    place_ship ship


 (** in
  let coords = generate_ship_coords (length - 1) (col, row) direction [] in
  let all_coords = (col, row) :: coords in
  List.iter (fun coord -> used_coords := coord :: !used_coords) all_coords;*)


let change coords = List.iter (fun x-> used_coords := x :: !used_coords) coords
let ywingCoords = place_ship ywing
let _ = change ywingCoords
let xwingCoords = place_ship xwing
let _ = change xwingCoords
let mfalconCoords = place_ship mfalcon
let _ = change mfalconCoords
let delta7Coords = place_ship delta7
let _ = change delta7Coords
let stardestroyerCoords = place_ship stardestroyer
let _ = change stardestroyerCoords

let place_ship_on_grid grid ship_coords ship=
  let update_grid row col = 
    let row_arr = List.nth grid row in
    if ship.ship = Ship1 then
      row_arr.(col) <- "#"
    else if ship.ship = Ship2 then
      row_arr.(col) <- "@"
    else if ship.ship = Ship3 then
      row_arr.(col) <- "$"
    else if ship.ship = Ship4 then
      row_arr.(col) <- "%"
    else if ship.ship = Ship5 then
      row_arr.(col) <- "~"
  in
  let rec loop coords =
    match coords with
    | [] -> ()
    | (col, row) :: rest ->
        let char_code = Char.code col in
        if row >= 1 && row <= 10 && char_code >= 65 && char_code <= 74 then
          update_grid (row - 1) (char_code - 65);
        loop rest
  in
  loop ship_coords

let _ = used_coords
let _ = place_ship_on_grid randomgrid ywingCoords ywing
let _ = place_ship_on_grid randomgrid xwingCoords xwing
let _ = place_ship_on_grid randomgrid mfalconCoords mfalcon
let _ = place_ship_on_grid randomgrid delta7Coords delta7
let _ = place_ship_on_grid randomgrid stardestroyerCoords stardestroyer










