AddCSLuaFile()

if CLIENT then
  SWEP.PrintName             = "VBRP Stun Stick"
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

  self.Hit = {
    Sound("weapons/stunstick/stunstick_impact1.wav"),
    Sound("weapons/stunstick/stunstick_impact2.wav")
  }
  self.FleshHit = {
    Sound("weapons/stunstick/stunstick_fleshhit1.wav"),
    Sound("weapons/stunstick/stunstick_fleshhit2.wav")
  }
end

function SWEP:Think() end

function SWEP:PrimaryAttack()

  self:SetNextPrimaryFire(CurTime() + 0.9)
  self.Owner:SetAnimation(PLAYER_ATTACK1)
  self:EmitSound(self.AttackSound)
  self:SendWeaponAnim(ACT_VM_HITCENTER)

  if SERVER then
    local trace = self.Owner:GetEyeTrace()
    if IsValid(trace.Entity) and not (self.Owner:EyePos():DistToSqr(trace.Entity:GetPos()) > 100 * 100) then
      trace.Entity:TakeDamage(math.random(10, 25))
      if trace.Entity:IsPlayer() then
        self.Owner:EmitSound(self.FleshHit[math.random(#self.FleshHit)])
      else
        self.Owner:EmitSound(self.Hit[math.random(#self.Hit)])
      end
    end
  end
end


function SWEP:SecondaryAttack()
end