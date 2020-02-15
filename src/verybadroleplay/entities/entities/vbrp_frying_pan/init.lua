AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

  self:SetModel("models/props_c17/metalPot002a.mdl")
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
end
