open Graphql_lwt
open UserModel.Config

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
                           ~typ:(non_null string)
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
                         field "gender"
                           ~args:Arg.[]
                           ~typ:(non_null UserGenderType.typ)
                           ~resolve:(fun () p -> p.gender)
                       ])
                  )
