SWEP.PrintName = "Radio"
SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.Author = "Azzen (lua) <https://steamcommunity.com/id/azzen> and NullRefz <https://steamcommunity.com/id/nullrefz> (model)"
SWEP.Instructions = ""
SWEP.UseHands = true
SWEP.ViewModel = "models/radio/c_radio.mdl"
SWEP.WorldModel = "models/radio/w_radio.mdl"

local predicted = IsFirstTimePredicted

function SWEP:SetupDataTables()
  self:NetworkVar("Bool", 0, "DTRadioActivated")
end


function SWEP:Initialize()
  self:SetWeaponHoldType("slam")
end

function SWEP:Talk() 
  if CLIENT then
    net.Start("VBNET::SWEP::PoliceRadio::Activate")
    net.SendToServer()
  end 
end

function SWEP:PrimaryAttack()
  self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
  if predicted() then
    self:SetNextPrimaryFire(CurTime() + 2)
    if CLIENT then
      surface.PlaySound("verybadroleplay/police/radio_beep.mp3")
    end
    if SERVER then
      self:SetDTRadioActivated(not self:GetDTRadioActivated())
    end
  end
end

function SWEP:SecondaryAttack()
   return false
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