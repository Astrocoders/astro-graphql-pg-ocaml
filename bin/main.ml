open Lib
open Lwt
open Graphql_lwt
module C = Cohttp_lwt_unix

let schema = Schema.(schema [
  io_field "users"
    ~args:Arg.[]
    ~typ:(non_null (list (non_null UserType.user)))
    ~resolve:(fun () () ->
      match%lwt (Models.User.findOne ()) with
      | Some user -> Lwt.return [user]
      | None -> Lwt.return []
    )
  ;
]
)

let () =
  Server.start ~ctx:(fun () -> ()) schema
  |> Lwt_main.run
