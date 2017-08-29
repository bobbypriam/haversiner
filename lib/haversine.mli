(** Coordinate type. Use coordinate_of_floats to construct. *)
type coordinate

(** Construct coordinates from floats. Latitude and longitude
    must be in decimal degrees format. *)
val coordinate_of_floats : lat:float -> long:float -> coordinate

(** Calculate earth distance between two coordinates. *)
val calculate_distance : coordinate -> coordinate -> float
