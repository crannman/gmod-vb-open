AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Identifier = "MARKET_LOAM"

function ENT:Use(activator, caller)
  if caller:IsArrested() then return false end
  self:Remove()
  caller:UpdateInventory(self.Identifier, "add", 1)

end