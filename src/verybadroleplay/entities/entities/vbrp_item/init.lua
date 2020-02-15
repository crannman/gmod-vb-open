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

function ENT:OnTakeDamage(dmgInfo)

  self:SetHealth(self:Health() - dmgInfo:GetDamage())
  if self:Health() <= 0 then self:Remove() end
end


function ENT:Use(activator, caller, useType, value)
  if caller:IsArrested() then return false end
  if self:GetEntOwner() == caller:GetCompleteName() or GetPlayerBySteamID(self:GetDTOwner()):IsFriendWith(caller:SteamID()) then
    self:Remove()
    local identifier
    for k,v in pairs(VBCLASS_ITEM.Items) do
      if v.Name == self:GetDTName() then 
        identifier = v.Identifier 
        break 
      end
    end
    caller:UpdateInventory(identifier, "add", 1)
  end
end
