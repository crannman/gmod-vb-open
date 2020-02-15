AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local authorizedTeam = {
  [TEAM_POLICECHIEF] = true,
  [TEAM_COP] = true,
  [TEAM_SWAT] = true,
}

function ArrestPlayer(caller, pl)
  -- TODO: Check if pl is near to caller
  if not pl:IsArrested() and authorizedTeam[caller:Team()] and not authorizedTeam[pl:Team()] then
    pl:SetDTArrested(true)
    pl:SetDTStatus("En état d'arrestation")
    pl:StripWeapons()
    pl:SetRunSpeed(pl:GetWalkSpeed() + 50)
  end
end

function UnarrestPlayer(caller, pl)
  -- TODO: Check if pl is near to caller
  if pl:IsArrested() and authorizedTeam[caller:Team()] then
    pl:SetDTArrested(false)
    pl:SetDTStatus("")
    pl:MakeLoadout()
    pl:SetRunSpeed(320)
  end
end

function SWEP:PrimaryAttack()
  if IsFirstTimePredicted() then
  self:SetNextPrimaryFire(CurTime() + 2)
  self:SetNextSecondaryFire(CurTime() + 2)
    for k, v in ipairs(ents.FindInSphere(self.Owner:GetPos(), 50)) do
      local entity = self.Owner:GetEyeTrace().Entity
      if entity:IsPlayer() and IsValid(entity) then
        ArrestPlayer(self.Owner, entity)
      end
    end
  end
end

function SWEP:SecondaryAttack()
  if IsFirstTimePredicted() then
  self:SetNextPrimaryFire(CurTime() + 2)
  self:SetNextSecondaryFire(CurTime() + 2)
    for k, v in ipairs(ents.FindInSphere(self.Owner:GetPos(), 50)) do
      local entity = self.Owner:GetEyeTrace().Entity
      if entity:IsPlayer() and IsValid(entity) then
        UnarrestPlayer(self.Owner, entity)
      end
    end
  end
end

