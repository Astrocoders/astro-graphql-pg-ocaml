module type Config = sig
  type t
  val table: string
  val parseRow: string array -> t
end

module Create (Config: Config) = struct
  let findOne ?clause () =
    let query = "select * from " ^ Config.table ^ match clause with
    | Some(clause) -> " where " ^ clause
    | None -> "" in
    let open Ezpostgresql.Pool in
    let open Lwt_result.Infix in
    let%lwt operation_result = 
      one
        ~query
        Database.pool >>= fun row_opt ->
      match row_opt with
      | Some row ->
        Lwt_result.return (
          Some (Config.parseRow row)
        )
      | None -> Lwt_result.return None
    in
    match operation_result with
    | Ok Some parsedRow -> Lwt.return ( Some parsedRow )
    | _ -> Lwt.return None
end
