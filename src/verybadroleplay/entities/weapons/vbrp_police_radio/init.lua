AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local addNetworkString = util.AddNetworkString
local recv = net.Receive
local isvalid = IsValid

addNetworkString("VBNET::SWEP::PoliceRadio::Activate")
addNetworkString("VBNET::SWEP::PoliceRadio::Toggle")

recv("VBNET::SWEP::PoliceRadio::Activate", function(len, pl)

  local weapon = pl:GetWeapon("vbrp_police_radio")
  if isvalid(weapon) then
    weapon:SetDTRadioActivated(true)
  end

end)


recv("VBNET::SWEP::PoliceRadio::Toggle", function(len, pl)

  local weapon = pl:GetWeapon("vbrp_police_radio")
  if isvalid(weapon) then
    weapon:SetDTRadioActivated(not weapon:GetDTRadioActivated())
  end

end)