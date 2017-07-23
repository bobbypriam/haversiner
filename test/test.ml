open OUnit

let tests = TestList [
  Haversine_test.suite
]

let _ = run_test_tt_main tests
