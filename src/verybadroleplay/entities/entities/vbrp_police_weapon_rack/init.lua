AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()

  self:SetModel("models/props/coop_cementplant/coop_weapon_rack/coop_weapon_rack.mdl")
  self:PhysicsInit(SOLID_VPHYSICS)
  self:SetMoveType(MOVETYPE_NONE)
  self:SetSolid(SOLID_VPHYSICS)
  self:SetUseType(SIMPLE_USE)
  local phys = self:GetPhysicsObject()
  if (IsValid(phys)) then
    phys:Wake()
  end

end

function ENT:Use(activator, caller, useType, value)
  if caller:IsArrested() then return false end
  if caller:GetJob().AccessToArmory then
    caller:LuaRun([[OpenPoliceArmory()]])
  end
end
