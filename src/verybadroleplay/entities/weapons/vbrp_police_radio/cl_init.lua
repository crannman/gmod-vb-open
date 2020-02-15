include("shared.lua")

SWEP.Slot = 0
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.PrintName = "Radio"
SWEP.DrawCrosshair = false

local isvalid = IsValid
hook.Add("PlayerStartVoice", "VBHOOK::SWEP::Radio::TalkWhileHavingRadio", function(ply, key)

  if isvalid(ply:GetActiveWeapon()) and ply:Alive() then
    if ply:GetActiveWeapon():GetClass() == "vbrp_police_radio" then
      ply:GetWeapon("vbrp_police_radio"):Talk()
    end
  end
end)