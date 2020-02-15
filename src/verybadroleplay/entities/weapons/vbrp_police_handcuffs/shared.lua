SWEP.PrintName = "HandCuffs"
SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.Author = "Azzen (lua) and The One Free-man & ToBadForYou (model)"
SWEP.Instructions = ""
SWEP.UseHands = true
SWEP.ViewModel = "models/tobadforyou/c_hand_cuffs.mdl"
SWEP.WorldModel = "models/tobadforyou/handcuffs.mdl"

function SWEP:Initialize()
  self:SetWeaponHoldType("normal")
end

function SWEP:SecondaryAttack()
end

function SWEP:DrawHUD()
end

function SWEP:Think()
end

function SWEP:Deploy()
  return true
end

function SWEP:Holster()
  return true
end

function SWEP:OnRemove()
end

function SWEP:OnRestore()
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
end