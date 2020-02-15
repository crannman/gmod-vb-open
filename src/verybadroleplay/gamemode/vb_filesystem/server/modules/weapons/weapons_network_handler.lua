util.AddNetworkString("VBNET_ChangeStatue")

net.Receive("VBNET_ChangeStatue", function(len, ply)
  local status = net.ReadString()
  ply:SetDTStatus(status)
end)