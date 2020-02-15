if SERVER then
    AddCSLuaFile("shared.lua")
end

if CLIENT then
    SWEP.Slot = 0
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.PrintName = "Position Utility"
    SWEP.DrawCrosshair = true
end

SWEP.PrintName = "Position Utility"
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
        SetClipboardText(self.Owner:GetPos():VecToString())
        ClientsideNotify("Copied Vector to clipboard.")
    end
end

function SWEP:SecondaryAttack()
    if CLIENT and IsFirstTimePredicted() then
        SetClipboardText(self.Owner:GetAngles():AngToString())
        ClientsideNotify("Copied Angles to clipboard.")
    end
end

function SWEP:DrawHUD()
    draw.RoundedBox(5, ScrW() * .5 - 380 / 2, ScrH() * .84, 380, 58, Color(12, 12, 12, 175))
    local ac_viewangles = self.Owner:GetAngles():AngToString()
    local ac_pos = self.Owner:GetPos():VecToString()
    draw.DrawText("Actual Position: " .. ac_pos .. "\nActual Angles: " .. ac_viewangles, "VBFONT_HUDNORMAL", ScrW() * .5 - 380 / 2 + 5, ScrH() * .85, Color(255, 255, 255, 255))
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