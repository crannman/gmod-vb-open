AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
  self:SetModel("models/alyx.mdl")
  self:SetHealth(40000)
  self:SetUseType(SIMPLE_USE)
end

local restrictCheck = {
  ["Police"] = function(caller) return caller:GetJob().Police end,
  ["Medic"] = function(caller) return caller:Team() == TEAM_MEDIC end

}

function ENT:Use(caller)

  if caller:IsArrested() then return false end
  if self:GetEntityName() == "" then return false end

  local properties = GetNPCTableFromName(self:GetEntityName())
  if properties.RestrictTo and not restrictCheck[properties.RestrictTo](caller) then
    local lua = [[
      local dlg = {
        [1] = {
          Type = "NPC_Dialog",
          Text = function() return "]] .. properties.RestrictMessage .. [[" end,
          Action = nil
        },
        [2] = {
          Type = "NPC_Answer",
          Text = function() return "*partir*" end,
          Action = function(self)
            self:GetParent():Remove()
          end,
        },
      }
      CreateNPCDialog("]] .. properties.Name .. [[", dlg)
    ]]
    caller:LuaRun(lua)
    return false 
  end

  net.Start("VBNET_StartNextBotFunc")
  net.WriteEntity(self)
  net.Send(caller)
  hook.Call("VBHOOK_NextBotHasBeenUsed", gmod.GetGamemode(), caller, self)
end