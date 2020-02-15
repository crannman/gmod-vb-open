local addNetworkString = util.AddNetworkString
local fmt = string.format
addNetworkString("VBNET::Jobs::Police::ArrestPlayer")
addNetworkString("VBNET::Jobs::Police::StartJailMenu")
addNetworkString("VBNET::Jobs::Police::OpenJailMenu")
local policeTeam = {
  [2] = true,
  [4] = true,
  [5] = true,
}

net.Receive("VBNET::Jobs::Police::ArrestPlayer", function(len, pl)

  local doorId = net.ReadInt(16)
  local time = net.ReadFloat()
  local arrestedPlayer = GetPlayerInCell(doorId)
  if arrestedPlayer:IsArrested() and policeTeam[pl:Team()] then
    NotifyPlayer(fmt("Vous avez bien arrêté %s", arrestedPlayer:GetCompleteName()), pl)
    Entity(doorId):Fire("lock")
    JailPlayer(arrestedPlayer, time, doorId, pl)
  end
  
end)

function StartJailMenu(pl, doorId)

  if policeTeam[pl:Team()] and Entity(doorId):IsCellDoor() and not IsCellEmpty(doorId) then
    if GetPlayerInCell(doorId).IsInJail then return false end
    net.Start("VBNET::Jobs::Police::OpenJailMenu")
    net.WriteInt(doorId, 16)
    net.Send(pl)
  end
end