let findOne () = 
  let open Ezpostgresql.Pool in
  let open Lwt_result.Infix in
  let%lwt operation_result = 
    one
      ~query: "select id, first_name from app_users"
      Database.pool >>= fun row_opt ->
    match row_opt with
    | Some row -> ( Lwt_result.return ( Some UserType.{ id = row.(0); name = Some row.(1); role = Admin; gender = Female } ) )
    | None -> Lwt_result.return None
  in
  match operation_result with
  | Ok Some user -> Lwt.return ( Some user )
  | _ -> Lwt.return None
