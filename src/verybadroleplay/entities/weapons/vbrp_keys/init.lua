AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Initialize()

  self:SetWeaponHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()

  if not IsFirstTimePredicted() then return false end
  self:SetNextPrimaryFire(CurTime() + 1.5)
  self:SetNextSecondaryFire(CurTime() + 1.5)

  local target = self.Owner:GetEyeTrace().Entity
  if not IsValid(target) then return false end

  if target:GetClass() == "vbrp_vehicle_trunk" and target:GetParent():GetNWString("VB::NW::Car::Owner") == self.Owner:SteamID() then
    target:SetDTLocked(true)
  end
  if target:IsDoor() and not target:IsCellDoor() and target:GetEntOwner() ~= "world"  and target:GetEntOwner() ~= "" and self.Owner:IsNearToEntity(target)
  and 
  (
    target:GetEntOwner() == self.Owner:GetCompleteName() 
    or GetPlayerByName(target:GetEntOwner()):IsFriendWith(self.Owner:SteamID()) 
    or self.Owner:SameGroupAs(GetPlayerByName(target:GetEntOwner()))
  ) then
    target:Fire("lock")
    self.Owner:EmitSound(self.LockSound, 50, 100)
  elseif target:IsDoor() and target:GetEntOwner() ~= self.Owner:SteamID() and self.Owner:IsNearToEntity(target) then
    self.Owner:EmitSound(self.KnockSound, 50, 100)
  end
  if target:IsCellDoor() and self.Owner:IsNearToEntity(target) then
    StartJailMenu(self.Owner, target:EntIndex())
  end
end

function SWEP:SecondaryAttack()

  if not IsFirstTimePredicted() then return false end
  self:SetNextPrimaryFire(CurTime() + 1.5)
  self:SetNextSecondaryFire(CurTime() + 1.5)
  
  local target = self.Owner:GetEyeTrace().Entity
  if not IsValid(target) then return false end

  if target:GetClass() == "vbrp_vehicle_trunk" and target:GetParent():GetNWString("VB::NW::Car::Owner") == self.Owner:SteamID() then
    target:SetDTLocked(false)
  end
  if target:IsDoor() and target:GetEntOwner() ~= "world" and target:GetEntOwner() ~= "" and self.Owner:IsNearToEntity(target) and 
  (
    target:GetEntOwner() == self.Owner:GetCompleteName() 
    or GetPlayerByName(target:GetEntOwner()):IsFriendWith(self.Owner:SteamID()) 
    or self.Owner:SameGroupAs(GetPlayerByName(target:GetEntOwner()))
  ) then
    self.Owner:EmitSound(self.UnlockSound, 50, 100)
    target:Fire("unlock")
  elseif target:IsDoor() and target:GetEntOwner() ~= self.Owner:SteamID() and self.Owner:IsNearToEntity(target) then
    self.Owner:EmitSound(self.KnockSound, 50, 100)
  end
end