util.AddNetworkString("VBNET::Inventory::Entities::RequestDrop")

net.Receive("VBNET::Inventory::Entities::RequestDrop", function(len, pl)

  local entity = net.ReadString()

  local properties = VBCLASS_ITEM:GetItemProperties(entity)
  local identifier = properties.Identifier
  if not PreparedStatements.Inventory.PlayerHasItem(identifier, pl:SteamID()) then return false end
  
  pl:SpawnEntity(entity)
  pl:UpdateInventory(entity, "remove", 1)

end)