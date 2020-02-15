local VBRP_Player = FindMetaTable("Player")
-- @desc Spawn un item là où regarde le joueur;
-- @args string ItemIdentifier;
-- @realm Server;
function VBRP_Player:SpawnItem(Item)

  local itemProperties = VBCLASS_ITEM:GetItemProperties(Item)
  local itemProps = ents.Create("vbrp_item")
  local obbMaxs = itemProps:OBBMaxs()
  itemProps:SetModel(itemProperties.Model)
  itemProps:SetPos(self:GetSpawnVector() + Vector(0, 0, obbMaxs.z / 2) )
  itemProps:Spawn()
  itemProps:SetDTName(itemProperties.Name)
  itemProps:SetDTDesc(itemProperties.Desc)
  itemProps:SetDTOwner(self:SteamID())
  itemProps:SetHealth(itemProperties.Health)    

end
