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
  if not caller:Team() == TEAM_COOK then return false end
  if self:GetDTOwner() == caller:SteamID() then
    VBRP_Cooking:StoreToInventory(caller, self:GetDTIdentifier(), false)
    self:Remove()
  end
  
end
