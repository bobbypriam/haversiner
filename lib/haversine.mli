type angle =
  | Degree of float
  | Radian of float
type latitude = Latitude of angle
type longitude = Longitude of angle
type coordinate = latitude * longitude

(* Convert floats to coordinate *)
val degree_coordinate_of_floats : lat:float -> long:float -> coordinate

(* Calculate distance between two coordinates *)
val calculate_distance : coordinate -> coordinate -> float
