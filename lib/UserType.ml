open Graphql_lwt

type role = User | Admin

type user = {
  id   : int;
  name : string option;
  role : role;
  friends : user list;
}

let role = Schema.(enum "Role"
  ~values:[
    enum_value "USER" ~value:User ~doc:"A regular user";
    enum_value "ADMIN" ~value:Admin ~doc:"An admin user";
  ]
)

let user = Schema.(obj "User"
  ~fields:(fun user -> [
    field "id"
      ~args:Arg.[]
    ~typ:(non_null int)
      ~resolve:(fun () p -> p.id)
    ;
    field "name"
      ~args:Arg.[]
      ~typ:(string)
      ~resolve:(fun () p -> p.name)
;
  field "role"
    ~args:Arg.[]
      ~typ:(non_null role)
      ~resolve:(fun () p -> p.role)
    ;
    field "friends"
      ~args:Arg.[]
      ~typ:(list (non_null user))
      ~resolve:(fun () p -> Some p.friends)
  ])
)

