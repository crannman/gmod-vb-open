util.AddNetworkString("VBNET::Inventory::Weapons::RequestEquip")
util.AddNetworkString("VBNET::Inventory::Weapons::RequestDrop")
util.AddNetworkString("VBNET::Inventory::Weapons::RequestStore")

net.Receive("VBNET::Inventory::Weapons::RequestStore", function(len, pl)
  
  if pl:Team() ~= TEAM_CITIZEN then return false end
  local weapon = net.ReadString()
  local identifier = RetrieveEntityFromClassName(weapon)["Identifier"]
  if pl:GetActiveWeapon():GetClass() == weapon then
    pl:StripWeapon(weapon)
    pl:SelectWeapon("vbrp_keys")
    pl:UpdateInventory(identifier, "add", 1)
  else
    pl:StripWeapon(weapon)
    pl:UpdateInventory(identifier, "add", 1)
  end

end)

net.Receive("VBNET::Inventory::Weapons::RequestEquip", function(len, pl)

  local weapon = net.ReadString()

  local properties = VBCLASS_ITEM:GetItemProperties(weapon)
  local identifier = properties.Identifier
  if not PreparedStatements.Inventory.PlayerHasItem(identifier, pl:SteamID()) then return false end

  pl:EquipWeapon(weapon)
  pl:UpdateInventory(weapon, "remove", 1)

end)

net.Receive("VBNET::Inventory::Weapons::RequestDrop", function(len, pl)

  local weapon = net.ReadString()

  local properties = VBCLASS_ITEM:GetItemProperties(weapon)
  local identifier = properties.Identifier
  if not PreparedStatements.Inventory.PlayerHasItem(identifier, pl:SteamID()) then return false end

  pl:DropVBWeapon(weapon)
  pl:UpdateInventory(weapon, "remove", 1)

end)
