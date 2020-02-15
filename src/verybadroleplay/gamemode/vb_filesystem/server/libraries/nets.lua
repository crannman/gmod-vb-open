local start = net.Start
local writestr = net.WriteString
local send = net.Send
local addNetworkString = util.AddNetworkString

local VBRP_Player = FindMetaTable("Player")

addNetworkString("VBNET::Networking::Lua::Run")


function VBRP_Player:LuaRun(instruction, isSilent)

  isSilent = isSilent or false
  local luaLoader = [[
    net.Receive("VBNET::Networking::Lua::Run", function()
      local str = net.ReadString()
      print(str)
      RunString(str, "", true) 
    end)
  ]]
  self:SendLua(luaLoader)
  net.Start("VBNET::Networking::Lua::Run")
  net.WriteString(instruction)
  net.Send(self)
  
end
