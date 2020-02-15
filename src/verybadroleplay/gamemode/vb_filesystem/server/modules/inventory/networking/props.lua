util.AddNetworkString("VBNET::Inventory::Items::RequestDrop")

net.Receive("VBNET::Inventory::Items::RequestDrop", function(len, pl)

  local item = net.ReadString()
  
  local properties = VBCLASS_ITEM:GetItemProperties(item)
  local identifier = properties.Identifier
  if not PreparedStatements.Inventory.PlayerHasItem(identifier, pl:SteamID()) then return false end

  pl:SpawnItem(item)
  pl:UpdateInventory(item, "remove", 1)

end)