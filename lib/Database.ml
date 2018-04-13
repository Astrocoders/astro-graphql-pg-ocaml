open Ezpostgresql

let conninfo =
  try Sys.getenv "DATABASE_URL"
  with Not_found -> "postgresql://localhost:5432/astro_ocaml_graphql"

let pool = Pool.create ~conninfo ~size:10 ()
