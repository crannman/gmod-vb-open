if SERVER then
    AddCSLuaFile("shared.lua")
end

if CLIENT then
    SWEP.Slot = 0
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.PrintName = "Vector Helper"
    SWEP.DrawCrosshair = true
end

SWEP.ShouldDraw = false

SWEP.PrintName = "Vector Helper"
SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.Author = "Azzen"
SWEP.Instructions = ""
SWEP.ViewModel = "models/weapons/v_grenade.mdl"
SWEP.WorldModel = "models/weapons/w_grenade.mdl"
SWEP.Primary.Delay = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.Delay = 1
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
  self:SetWeaponHoldType("normal")
end

function SWEP:PrimaryAttack()
  if CLIENT and IsFirstTimePredicted() then
    ClientsideNotify("[Vector Helper] Selected minimum vector: " .. self.Owner:GetEyeTrace().HitPos:VecToString())
    self.MinVector = self.Owner:GetEyeTrace().HitPos
    self.ShouldDraw = true
  end
end

function SWEP:SecondaryAttack()
  if CLIENT and IsFirstTimePredicted() then
    ClientsideNotify("[Vector Helper] Selected maximum vector: " .. self.Owner:GetEyeTrace().HitPos:VecToString())
    self.MaxVector = self.Owner:GetEyeTrace().HitPos
  end
end

function SWEP:Reload()
  if CLIENT and IsFirstTimePredicted() and not self.Reloading and not self.StopTimer then
    self.Reloading = true
    if self.MinVector and self.MaxVector then
      ClientsideNotify("[Vector Helper] Written vectors in console")
      print
      { 
        W_Min = self.MinVector, 
        W_Max = self.MaxVector,
        L_Min = WorldToLocal(self.MinVector, Angle(0, 0, 0), self.Owner:GetPos(), Angle(0, 0, 0)),
        L_Max = WorldToLocal(self.MaxVector, Angle(0, 0, 0), self.Owner:GetPos(), Angle(0, 0, 0))
      }
      self.StopTimer = CurTime() + 3
    end

  end
end

function SWEP:DrawHUD()

  if self.ShouldDraw then

    local v2 = WorldToLocal(self.Owner:GetEyeTrace().HitPos, Angle(0, 0, 0), self.Owner:GetPos(), Angle(0, 0, 0))
    if self.MaxVector then
      v2 = WorldToLocal(self.MaxVector, Angle(0, 0, 0), self.Owner:GetPos(), Angle(0, 0, 0))
    end
    local v1 = WorldToLocal(self.MinVector, Angle(0, 0, 0), self.Owner:GetPos(), Angle(0, 0, 0))

    cam.Start3D()
        if self.StopTimer and self.StopTimer > CurTime() then
          render.DrawWireframeBox(self.Owner:GetPos(), Angle(0, 0 ,0), v1, v2, Color(0, 255, 0))
        elseif self.StopTimer and self.StopTimer < CurTime() then
          self.ShouldDraw = false
          self.MinVector = nil
          self.MaxVector = nil
          self.StopTimer = nil
        else
          render.DrawWireframeBox(self.Owner:GetPos(), Angle(0, 0 ,0), v1, v2, Either(self.MaxVector, Color(255, 0, 0), Color(255, 255, 255)))
        end

    cam.End3D()
  end
end

function SWEP:Think()
    if (self.Reloading and IsValid(self.Owner) and not self.Owner:KeyDown(IN_RELOAD) ) then
        self.Reloading = false
    end
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