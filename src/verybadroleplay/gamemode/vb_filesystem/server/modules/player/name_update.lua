util.AddNetworkString("VBNET_UpdateRoleplayName")
util.AddNetworkString("VBNET_RequestNameAvailability")
util.AddNetworkString("VBNET_SendNameAvailability")

net.Receive("VBNET_UpdateRoleplayName", function(len, ply)

  local firstName = net.ReadString()
  local lastName = net.ReadString()
  if ply:IsRegistered() and firstName == ply:GetFirstName() and lastName == ply:GetLastName() then
    return false
  end
  local steamid = ply:SteamID()
  local sql = "UPDATE players SET first_name = '" .. VBSQL:Escape(firstName) .."', last_name = '".. VBSQL:Escape(lastName) .."' where steam_id = '" .. VBSQL:Escape(steamid) .. "';"
  local query = VBSQL:Query(sql)
  query:wait()
  ply:SetDTFirstName(firstName)
  ply:SetDTLastName(lastName)
end)

net.Receive("VBNET_RequestNameAvailability", function(len, ply)

  local firstName = net.ReadString()
  local lastName = net.ReadString()
  local sql = "SELECT 1 FROM players where first_name = '" .. VBSQL:Escape(firstName) .. "' AND last_name = '" .. VBSQL:Escape(lastName) .. "'"
  local query = VBSQL:Query(sql)
  query:wait()

  net.Start("VBNET_SendNameAvailability")
  -- Si les noms ne changent pas alors ils sont dispo.
  if ply:IsRegistered() and firstName == ply:GetFirstName() and lastName == ply:GetLastName() then
    net.WriteBool(true)
  else
    local availability = query:getData()[1] == nil
    print(availability)
    net.WriteBool(availability)
  end
  net.Send(ply)  

end)