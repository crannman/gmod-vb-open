AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Initialize()

  self:SetWeaponHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()
  if not IsFirstTimePredicted() then return false end
  local target = self.Owner:GetEyeTrace().Entity
  if IsValid(target) and not (self.Owner:EyePos():DistToSqr(target:GetPos()) > 100 * 100) and target:Health() < target:GetMaxHealth() then
    target:SetHealth(math.min(target:GetMaxHealth(), target:Health() + self.Heal))
    target:EmitSound(self.HealSound)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:SetNextSecondaryFire(CurTime() + self:SequenceDuration() + 0.5)
    self:SetNextPrimaryFire(CurTime() + self:SequenceDuration() + 0.5)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    timer.Simple(self:SequenceDuration(), function() if not IsValid(self) then return end self:SendWeaponAnim(ACT_VM_IDLE) end)
  elseif IsValid(target) and not (self.Owner:EyePos():DistToSqr(target:GetPos()) > 100 * 100) and target:Health() >= target:GetMaxHealth() then
    target:EmitSound(self.MaxHealthSound)
    self:SetNextSecondaryFire(CurTime() + 1)
    self:SetNextPrimaryFire(CurTime() + 1)
  end
end

function SWEP:SecondaryAttack()
  if not IsFirstTimePredicted() then return false end
  local target = self.Owner

  if target:Health() < target:GetMaxHealth() then
    target:SetHealth(math.min(target:GetMaxHealth(), target:Health() + self.Heal))
    target:EmitSound(self.HealSound)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:SetNextSecondaryFire(CurTime() + self:SequenceDuration() + 0.5)
    self:SetNextPrimaryFire(CurTime() + self:SequenceDuration() + 0.5)
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    timer.Simple(self:SequenceDuration(), function() if not IsValid(self) then return end self:SendWeaponAnim(ACT_VM_IDLE) end)
  else
    target:EmitSound(self.MaxHealthSound)
    self:SetNextSecondaryFire(CurTime() + 1)
    self:SetNextPrimaryFire(CurTime() + 1)
  end

end