open OUnit2
open Lib
open State

let grid =
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

  let grid2 =
    [
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; "o"; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
      [| " "; " "; " "; " "; " "; " "; " "; " "; " "; " " |];
    ]


let new_turn_test (name : string) s (position: string*string) expected : test =
  name >:: fun _ -> 
    let () = new_turn s position in 
  assert_equal expected s

let new_turn_tests = [
  new_turn_test "Basic Test" grid ("B", "4") grid2;]


let tests = 
  "test suite for Final Project"
  >::: List.flatten
  [
    new_turn_tests;
  ]

let _ = run_test_tt_main tests 