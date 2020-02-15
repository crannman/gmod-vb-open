util.AddNetworkString("VBNET_ChangeJob")

net.Receive("VBNET_ChangeJob", function(len, ply)

  local id = net.ReadInt(8)

  if id == TEAM_COP and ply:IsPoliceChief() then
    id = TEAM_POLICECHIEF
  end

  VBJOB.SetJob(ply, id)
end)