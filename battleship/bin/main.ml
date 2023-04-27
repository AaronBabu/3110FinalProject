open Lib
(** [play_game f] starts the game with state [g]. *)

open Battleship
open AI
open Command
open State

let reset_board () =
  let new_grid = List.map (fun row -> Array.copy row) randomgrid in
  new_grid

let player_board () =
  let new_grid = List.map (fun row -> Array.copy row) player_grid in
  new_grid

let rec play_game grid grid2 string =
  try
    let move2 = parse string in
    new_turn grid move2;
    print_endline "\n AI board \n";
    print_column_label grid;
    print_grid grid 1;
    print_endline "\n Player board \n";
    print_column_label grid2;
    print_grid grid2 1;
    print_endline "\n Choose a target: \n";
    let line = read_line () in
    play_game grid grid2 line
  with _ ->
    print_endline "\n Choose a target: \n";
    let line = read_line () in
    play_game grid grid2 line

let main () =
  print_endline "\n AI board \n";
  let grid1 = reset_board () in
  let grid2 = player_board () in
  print_endline "Choose a target:";
  let line = read_line () in
  play_game grid1 grid2 line

let () = main ()
