util.AddNetworkString("VBNET_SetViewEntity")
util.AddNetworkString("VBNET_ResetViewEntity")
net.Receive("VBNET_SetViewEntity", function(len, pl)

  pl:SetViewEntity(ents.FindByClass("vbrp_view_entity")[1])

end)

net.Receive("VBNET_ResetViewEntity", function(len, pl)

  pl:SetViewEntity(pl)

end)