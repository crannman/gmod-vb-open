AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
end

function ENT:UpdateTransmitState()
  return TRANSMIT_ALWAYS
end
