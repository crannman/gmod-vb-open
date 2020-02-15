util.AddNetworkString("VBNET_PlayerTalkedToRealEstateAgent")
util.AddNetworkString("VBNET_PlayerTalkedToFleaVendor")
util.AddNetworkString("VBNET_FLEA_ConfirmPlayerIsNearToNPC")
util.AddNetworkString("VBNET_REALESTATE_ConfirmPlayerIsNearToNPC")

net.Receive("VBNET_PlayerTalkedToRealEstateAgent", function(len, ply)
  local entity = net.ReadEntity()

  if entity == Entity(0) then
    MsgC(Color(255, 255, 0), "[VBAC:Cheat] Player " .. ply:GetCompleteName() .. " (" .. ply:SteamID() .. ") tried to bypass network messages. Triggering VB:AC...\n")
  else
    if ply:IsNearToNPC(entity) then
      net.Start("VBNET_REALESTATE_ConfirmPlayerIsNearToNPC")
      net.WriteEntity(entity)
      net.Send(ply)
    else
      MsgC(Color(255, 0, 0), "[Suspicious] Bypass recorded for " .. ply:GetCompleteName() .. " (" .. ply:SteamID() .. ")\n")
    end
  end
end)

net.Receive("VBNET_PlayerTalkedToFleaVendor", function(len, ply)
  local entity = net.ReadEntity()

  if entity == Entity(0) then
    MsgC(Color(255, 255, 0), "[VBAC:Cheat] Player " .. ply:GetCompleteName() .. " (" .. ply:SteamID() .. ") tried to bypass network messages. Triggering VB:AC...\n")
  else
    if ply:IsNearToNPC(entity) then
      net.Start("VBNET_FLEA_ConfirmPlayerIsNearToNPC")
      net.Send(ply)
    else
      MsgC(Color(255, 0, 0), "[Suspicious] Bypass recorded for " .. ply:GetCompleteName() .. " (" .. ply:SteamID() .. ")\n")
    end
  end
end)