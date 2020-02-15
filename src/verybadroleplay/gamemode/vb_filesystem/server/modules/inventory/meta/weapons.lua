local VBRP_Player = FindMetaTable("Player")
-- @desc Drop un weapon là où regarde le joueur;
-- @args string WeaponIdentifier;
-- @realm Server;
function VBRP_Player:DropVBWeapon(weapon)
  local weaponProperties = VBCLASS_ITEM:GetItemProperties(weapon)
  local selfHitPos = self:GetEyeTrace().HitPos
  local weaponDropped = ents.Create("vbrp_dropped_weapon")
  weaponDropped:SetModel(weaponProperties.Model)
  weaponDropped:SetPos(selfHitPos)
  weaponDropped:Spawn()
  weaponDropped:SetDTName(weaponProperties.Name)
  weaponDropped:SetDTDesc(weaponProperties.Desc)
  weaponDropped:SetDTOwner(self:SteamID())

end

function VBRP_Player:EquipWeapon(weapon)
  local weaponProperties = VBCLASS_ITEM:GetItemProperties(weapon)
  if self:HasHeavyWeapon() and IsVBHeavyWeaponFromClass(weaponProperties.Entity) then
    return false
  end

  if self:HasLightWeapon() and IsVBLightWeaponFromClass(weaponProperties.Entity) then
    return false
  end

  self:Give(weaponProperties.Entity)
end