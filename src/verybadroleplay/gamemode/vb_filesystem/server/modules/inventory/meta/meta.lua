local VBRP_Player = FindMetaTable("Player")
-- @desc Met à jour l'inventaire d'un joueur;
-- @args string ItemIdentifier, string case, int Quantity;
-- @realm Server;
function VBRP_Player:UpdateInventory(item, case, quantity)
  
  local identifier = VBCLASS_ITEM:GetItemProperties(item).Identifier

  if case == "remove" then
    PreparedStatements.Inventory.RemoveItem(self:SteamID(), identifier, quantity)
  elseif case == "add" then
    PreparedStatements.Inventory.AddItem(self:SteamID(), identifier, quantity)
  end
  
end

-- @desc Récupère l'inventaire d'un joueur;
-- @args string WeaponIdentifier;
-- @realm Server;
function VBRP_Player:GetInventoryItems()
  local data = PreparedStatements.Inventory.FetchInventory(self:SteamID())
  local payload = { }

  for k, v in pairs(VBCLASS_ITEM.Items) do
    for _, j in ipairs(data) do
      if v["Identifier"] == j["name"] and j["amount"] > 0 then
        payload[k] = v
        payload[k]["Quantity"] = j["amount"]
      end
    end
  end
  
  if self:Team() == TEAM_COOK and VBRP_Cooking.Inventories[self:SteamID64()] then
    for k, v in pairs(VBRP_Cooking.Inventories[self:SteamID64()]) do
      payload[k] = {
        Category = v.Category,
        Desc = "",
        Entity = "vbrp_foodingredients",
        Identifier = k,
        Model = v.Model,
        Name = v.Name,
        Quantity = v.Quantity
      }
    end
  end

  local data = util.Compress(util.TableToJSON(payload))
  local length = data:len()
  net.Start("VBNET::Inventory::SendToPlayer")
  net.WriteUInt(length, 16)
  net.WriteData(data, length)
  net.Send(self)
end