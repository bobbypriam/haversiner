(** Parse coordinates from json *)
val parse : Ezjsonm.value -> Haversine.coordinate * Haversine.coordinate
