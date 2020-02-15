AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
PreparedStatements = PreparedStatements or {}

MsgC(Color(64, 224, 208), "=============\nVBFS-Server\nLoading Files\n=============\n")

-- @desc Charge les fichiers d'un répertoire dans une tabl;
-- @args string dir;
-- @realm Shared;
-- @return table loader;
function loadfiles(dir)
  local loader = { }
  local files, dirs = file.Find("verybadroleplay/gamemode/vb_filesystem/" .. dir .. "/*", "LUA")

  for _, v in pairs(dirs) do
    tmp = loadfiles(dir .. "/" .. v)

    for _, j in pairs(tmp) do
      table.insert(loader, j)
    end
  end

  for _, v in pairs(files) do
    if string.StartWith(v, "__explicit__") then continue end
    table.insert(loader, "vb_filesystem/" .. dir .. "/" .. v)
    if string.GetExtensionFromFilename(v) == "lua" then
      MsgC(Color(64, 224, 208), "[VB-Framework::LuaLoader] Including file: vb_filesystem/" .. dir .. "/" .. v .. "\n")
    end
  end

  return loader
end

local server_files = loadfiles("server")
local shared_files = loadfiles("shared")
local client_files = loadfiles("client")

-- Explicit inclusion
AddCSLuaFile("vb_filesystem/shared/modules/player/__explicit__player.lua")
include("vb_filesystem/shared/modules/player/__explicit__player.lua")
MsgC(Color(64, 224, 208), "[VB-Framework::LuaLoader] Including file explicitly: vb_filesystem/shared/modules/player/__explicit__player.lua\n")

AddCSLuaFile("vb_filesystem/shared/modules/translation/__explicit__manager.lua")
include("vb_filesystem/shared/modules/translation/__explicit__manager.lua")
MsgC(Color(64, 224, 208), "[VB-Framework::LuaLoader] Including file explicitly: vb_filesystem/shared/modules/translation/__explicit__manager.lua\n")


for _, v in pairs(server_files) do
  if string.GetExtensionFromFilename(v) == "lua" then
    include(v)
  end
end

for _, v in pairs(shared_files) do
  if string.GetExtensionFromFilename(v) == "lua" then
    AddCSLuaFile(v)
    include(v)
  end
end

for _, v in pairs(client_files) do
  if string.GetExtensionFromFilename(v) == "lua" then
    AddCSLuaFile(v)
  end
end