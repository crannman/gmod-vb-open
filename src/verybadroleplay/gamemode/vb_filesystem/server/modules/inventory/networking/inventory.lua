util.AddNetworkString("VBNET::Inventory::HasOpenedInventory")
util.AddNetworkString("VBNET::Inventory::SendToPlayer")

net.Receive("VBNET::Inventory::HasOpenedInventory", function(len, pl)

  pl:GetInventoryItems()

end)

