type angle =
  | Degree of float
  | Radian of float
type latitude = Latitude of angle
type longitude = Longitude of angle
type coordinate = latitude * longitude

(* Some maths. *)
let pi = 4. *. atan 1.
let radians_of_degrees = ( *. ) (pi /. 180.)
let haversine theta = 0.5 *. (1. -. cos theta)
let earth_radius = 6371. (* in kilometers *)

let subtract_angle a b =
  match a, b with
  | (Degree x, Degree y) -> (Degree (x -. y))
  | (Radian x, Radian y) -> (Radian (x -. y))
  | _ -> failwith "Can't subtract different units: degree - radian or vice versa."

let subtract_latitude (Latitude x) (Latitude y) =
  Latitude (subtract_angle x y)
let subtract_longitude (Longitude x) (Longitude y) =
  Longitude (subtract_angle x y)

let subtract_coordinates (lat_a, long_a) (lat_b, long_b) =
  (subtract_latitude lat_a lat_b, subtract_longitude long_a long_b)

let angle_as_radians = function
  | Degree d -> Radian (radians_of_degrees d)
  | Radian r -> Radian r

let latitude_as_radians (Latitude l) =
  Latitude (angle_as_radians l)
let longitude_as_radians (Longitude l) =
  Longitude (angle_as_radians l)

let radian_coordinate_of_degree_coordinate (lat, long) =
  (latitude_as_radians lat, longitude_as_radians long)

let value_of_latitude = function
  | Latitude (Degree x) -> x
  | Latitude (Radian x) -> x
let value_of_longitude = function
  | Longitude (Degree x) -> x
  | Longitude (Radian x) -> x

let coordinate_of_floats ~lat ~long =
  (Latitude (Degree lat), Longitude (Degree long))

let calculate_distance a b =
  let lat_a = a |> radian_coordinate_of_degree_coordinate |> fst |> value_of_latitude in
  let lat_b = b |> radian_coordinate_of_degree_coordinate |> fst |> value_of_latitude in
  let d = subtract_coordinates a b in
  let lat_d = d |> radian_coordinate_of_degree_coordinate |> fst |> value_of_latitude in
  let long_d = d |> radian_coordinate_of_degree_coordinate |> snd |> value_of_longitude in
  let h = haversine lat_d +. haversine long_d *. cos lat_a *. cos lat_b in
  2. *. earth_radius *. asin (sqrt h)
