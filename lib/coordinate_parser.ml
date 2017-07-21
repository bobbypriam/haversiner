let is_latitude (key, value) = key = "lat"
let is_longitude (key, value) = key = "long"

let parse_coordinate coordinate_node : float * float =
  let find_and_get f node = node |> List.find f |> snd |> Ezjsonm.get_float in
  let lat = find_and_get is_latitude coordinate_node in
  let long = find_and_get is_longitude coordinate_node in
  (lat, long)

let parse json_value : Haversine.coordinate * Haversine.coordinate =
  let get_field_from_json field = Ezjsonm.(get_dict (find json_value [field])) in
  let (lat_a, long_a) = get_field_from_json "a" |> parse_coordinate in
  let (lat_b, long_b) = get_field_from_json "b" |> parse_coordinate in
  let a = Haversine.coordinate_of_floats ~lat:lat_a ~long:long_a in
  let b = Haversine.coordinate_of_floats ~lat:lat_b ~long:long_b in
  (a, b)
