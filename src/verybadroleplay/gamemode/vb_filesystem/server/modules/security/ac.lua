--[[-------------------------------------------------------------------------
Anti cheat
Basic check for console variable manipulations using CE
speedhack isn't a thing anymore
perhaps aimbot check ?
---------------------------------------------------------------------------]]
util.AddNetworkString("VBNET_TriggerAC")
util.AddNetworkString("VBNET_CheckMemory")
util.AddNetworkString("VBNET_SpyBotInitialization")
util.AddNetworkString("VBNET_SpyBotSend")
util.AddNetworkString("99b01f5164117f38760f8cad0b69e937d14067d7") -- VBNET_SpyBotCollectData
util.AddNetworkString("737665360554eaaec321baf735839872a60d536e") -- VBNET_SpyBotSendData
timer.Create("VBAC::CheckCVARManipulation", 30, 0, function()
  local consoleVars = {
    ["sv_cheats"] = 0,
    ["sv_allowcslua"] = 0,
    ["r_drawothermodels"] = 1,
    ["mat_wireframe"] = 0,
    ["net_fakelag"] = 0
  }

  for _, player in pairs(player.GetAll()) do
    for cmd, int in pairs(consoleVars) do
      net.Start("VBNET_CheckMemory")
      net.WriteString("if GetConVar('" .. cmd .. "'):GetInt() != " .. int .. " then net.Start('VBNET_TriggerAC') net.WriteString('AC::MemoryManipulation') net.SendToServer() end")
      net.Send(player)
      player:SendLua("net.Receive('VBNET_CheckMemory', function() local str = net.ReadString() RunString(str) end)")
    end
  end
end)

net.Receive("VBNET_TriggerAC", function(len, ply)
  local reason = net.ReadString()
  local kickReason = ""

  if reason == "AC::MemoryManipulation" then
    kickReason = "VBAC::Unauthorized console variables manipulations"
  end

  if GetConVar("sv_allowcslua"):GetInt() == 1 or GetConVar("sv_cheats"):GetInt() == 1 then
    return false
  else
    ply:Kick(kickReason)
  end
end)
net.Receive("VBNET_SpyBotInitialization", function(len, ply)
  local viewer = SpyBot_Information()
  net.Start("VBNET_SpyBotSend")
  net.WriteTable(viewer)
  net.Send(ply)
end)

-- @desc Récupère les fichiers lua d'un joueur;
-- @realm Server;
-- @return table TableFiles
function SpyBot_Information()

  local table = {}

  local instruction = [[ 

  local function loadfiles(dir)
    local loader = {}
    local files, dirs = file.Find(dir .. "/*", "GAME")
    for _, v in pairs(files) do
      loader[dir .. "/" .. v]
    end
    for _, v in pairs(dirs) do
      loadfiles(dir .. "/" .. v)
    end
    return loader
  end
  local table = loadfiles()
  net.Start("VBNET_SpyBotSend")
  net.WriteTable(table)
  net.SendToServer()

  ]]

  for _, v in pairs( player.GetAll() ) do

    v:LuaRun(instruction, true)
    net.Receive("VBNET_SpyBotSend", function(len, ply)
      local tf = net.ReadTable()
      table[ply:SteamID()] = tf
    end)

  end

  return table

end