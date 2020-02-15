AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

  self:PhysicsInit(SOLID_VPHYSICS)
  self:SetMoveType(MOVETYPE_VPHYSICS)
  self:SetSolid(SOLID_VPHYSICS)
  self:SetUseType(SIMPLE_USE)
  local phys = self:GetPhysicsObject()
  if (IsValid(phys)) then
    phys:Wake()
  end
end

function ENT:Use(activator, caller, useType, value)
  if caller:IsArrested() then return false end
  local properties
  for k,v in pairs(VBCLASS_ITEM.Items) do
    if v.Name == self:GetDTName() then 
      properties = v 
      break 
    end
  end

  if (caller:HasLightWeapon() and LightweightWeaponsList[ properties["Entity"] ]) or (caller:HasHeavyWeapon() and HeavyWeaponsList[properties["Entity"]]) then
    caller:UpdateInventory(properties.Identifier, "add", 1)
    caller:SendLua([[CreateProgressBar("Vous êtes entrain de ramasser l'arme", 2, "Entrain de ramasser une arme.")]])
  else
    caller:EquipWeapon(properties.Identifier)
    caller:SendLua([[CreateProgressBar("Vous êtes entrain de ramasser l'arme", 2, "Entrain de ramasser une arme.")]])
  end
  self:Remove()

end