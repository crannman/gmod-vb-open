util.AddNetworkString("VBNET_RegisterModel")

local VBRP_Player = FindMetaTable("Player")
local VBRP_Entity = FindMetaTable("Entity")

function VBRP_Player:UpdateModel(identifier)
  
  self:SetDTModel(identifier)
  local steamid = self:SteamID()
  local query = "UPDATE players SET bodygroup = '" .. VBSQL:Escape(identifier) .. "' where steam_id = '" .. VBSQL:Escape(steamid) .. "';"
  local q = VBSQL:Query(query)
  q:wait()
end

net.Receive("VBNET_RegisterModel", function(len, ply)
  local identifier = net.ReadString()
  ply:SetModelWithIdentifier(identifier)
  ply:UpdateModel(identifier)
  ply:Spawn()
end)