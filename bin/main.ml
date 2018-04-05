open Lib
open Lwt
open Graphql_lwt
module C = Cohttp_lwt_unix

let rec alice = UserType.{ id = 1; name = Some "Alice"; role = Admin; friends = [bob] }
and bob = UserType.{ id = 2; name = Some "Bob"; role = User; friends = [alice]}

let users = [alice; bob]
let schema = Schema.(schema [
    io_field "users"
      ~args:Arg.[]
      ~typ:(non_null (list (non_null UserType.user)))
      ~resolve:(fun () () -> Lwt.return users)
    ;
    field "greeter"
      ~typ:string
      ~args:Arg.[
          arg "config" ~typ:(non_null (obj "Greeter_config" ~coerce:(fun greeting name -> (greeting, name)) ~fields:[
              arg' "greeting" ~typ:string ~default:"hello";
              arg "name" ~typ:(non_null string)
            ]))
        ]
      ~resolve:(fun () () (greeting, name) ->
          Some (Format.sprintf "%s, %s" greeting name)
        )
    ;
  ]
  )

let () =
  Server.start ~ctx:(fun () -> ()) schema
  |> Lwt_main.run
