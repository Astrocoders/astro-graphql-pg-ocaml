module Config = struct 
  type role = User | Admin
  type t = {
    id   : string;
    name : string option;
    role : role;
    gender: UserGenderType.gender;
  }
  let table = "app_users"
  let parseRow row =
    { id = row.(0); name = Some row.(1); role = Admin; gender = Female } 
end

module User = Model.Create(Config)
