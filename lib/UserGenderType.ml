open Graphql_lwt
type gender = Male | Female | Other

let typ: (unit, gender option) Schema.typ = Schema.(enum "Gender" ~values: [enum_value "MALE" ~value:Male; enum_value "FEMALE" ~value:Female; enum_value "OTHER" ~value:Other;])
