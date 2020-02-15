AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Initialize()

  self:SetWeaponHoldType(self.HoldType)

end

function SWEP:PrimaryAttack()
  if IsFirstTimePredicted() then
    local entity = self.Owner:GetEyeTrace().Entity
    if entity:IsDoor() or entity:MapEntity() or entity:GetClass() == "prop_ragdoll" then return false end
    if not entity:IsPlayer() or not entity:IsWorld() and IsValid(entity) then
      entity:Remove()
    end
  end
end

function SWEP:SecondaryAttack()
  return false
end
