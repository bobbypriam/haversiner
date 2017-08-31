open Opium.Std

let json_of_result result =
  let open Ezjsonm in
  dict [ ("distance", float result) ]

let distance_handler req =
  req
  |> App.json_of_body_exn
  |> Lwt.map (fun json ->
      let json_value = Ezjsonm.value json in
      let (a, b) = Coordinate_parser.parse json_value in
      let result = Haversine.calculate_distance a b in
      `Json (json_of_result result) |> respond
    )

let distance_route = post "/" distance_handler

let start () =
  print_endline "Running server at port 3000.";
  App.empty
  |> distance_route
  |> App.cmd_name "haversiner"
  |> App.run_command
