open OUnit2

let tests = test_list [
  Haversine_test.suite
]

let _ = run_test_tt_main tests
