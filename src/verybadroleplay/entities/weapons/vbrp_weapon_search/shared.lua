AddCSLuaFile()

if CLIENT then
  SWEP.PrintName             = "VBRP Weapon Search"
  SWEP.Slot                  = 0
  SWEP.SlotPos               = 1
  SWEP.DrawCrosshair         = true
end


SWEP.Spawnable               = true
SWEP.ViewModel               = Model("models/weapons/v_stunstick.mdl")
SWEP.WorldModel              = Model("models/weapons/w_stunbaton.mdl")

SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip     = -1
SWEP.Primary.Automatic       = false
SWEP.Primary.Ammo            = "none"

SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo          = "none"

SWEP.Author                  = "VALVe (models and sounds) and Azzen (lua)"
SWEP.Contact                 = "https://steamcommunity.com/id/azzen"
SWEP.Purpose                 = ""
SWEP.Instructions            = ""

--[[------------------------
User defined SWEP variables
------------------------]]--

SWEP.HoldType                = "melee"
SWEP.AttackSound             = Sound("weapons/stunstick/stunstick_swing1.wav")

--[[------------------------
SWEP functions
------------------------]]--

function SWEP:Initialize()

  if SERVER then
    self:SetHoldType(self.HoldType)
  end

end

function SWEP:Think() end

function SWEP:PrimaryAttack()

  self:SetNextPrimaryFire(CurTime() + 0.9)
  self:EmitSound(self.AttackSound)
  self:SendWeaponAnim(ACT_VM_HITCENTER)

  if SERVER then
    local trace = self.Owner:GetEyeTrace()
    if IsValid(trace.Entity) and not (self.Owner:EyePos():DistToSqr(trace.Entity:GetPos()) > 100 * 100) then
      if trace.Entity:IsPlayer() then
        local pl = trace.Entity
        for k, v in ipairs(pl:GetWeapons()) do
          if IsVBWeapon(v) then
            NotifyPlayer(string.format("Arme trouvée: %s", v:GetPrintName()), self.Owner)
          end
        end
      end
    end
  end
end


function SWEP:SecondaryAttack()
end