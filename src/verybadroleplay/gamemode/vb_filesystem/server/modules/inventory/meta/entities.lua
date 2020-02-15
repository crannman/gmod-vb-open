local VBRP_Player = FindMetaTable("Player")

function VBRP_Player:SpawnEntity(entity)
  local properties = VBCLASS_ITEM:GetItemProperties(entity)
  local entityDropped = ents.Create(properties.Entity)
  entityDropped:SetPos(self:GetSpawnVector())
  entityDropped:SetDTName(properties.Name)
  entityDropped:SetDTDesc(properties.Desc)
  entityDropped:SetDTOwner(self:SteamID())
  entityDropped:SetUseType(SIMPLE_USE)
  entityDropped:SetTrigger(true)
  entityDropped:Spawn()
end