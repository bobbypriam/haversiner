open Lib.Haversine

let epsilon = 0.01 (* We tolerate difference of +- 10 meters *)

let close_enough a b =
  abs_float (a -. b) < epsilon

let test () =
  print_endline ("Tolerating +- " ^ string_of_int (int_of_float (epsilon *. 1000.)) ^ " meters");

  (* Distance from BNA to LAX should roughly be 2886.45 km *)
  let bna = coordinate_of_floats 36.12 (-86.67) in
  let lax = coordinate_of_floats 33.94 (-118.4) in
  let result = calculate_distance bna lax in
  print_endline ("BNA-LAX: expected = 2886.45 km, actual = " ^ string_of_float result);
  assert (close_enough result 2886.45);

  (* Distance from Jakarta to Bandung should roughly be 114.78 km *)
  let jak = coordinate_of_floats (-6.21462) 106.84513 in
  let bdg = coordinate_of_floats (-6.90389) 107.61861 in
  let result = calculate_distance jak bdg in
  print_endline ("JAK-BDG: expected = 114.78 km, actual = " ^ string_of_float result);
  assert (close_enough result 114.78)

let _ = test()
