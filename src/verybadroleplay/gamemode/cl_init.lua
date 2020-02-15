if SERVER then return end
include("shared.lua")

local function loadfiles(dir)
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
  end

  return loader
end

local shared_files = loadfiles("shared")
local client_files = loadfiles("client")

-- Explicit inclusion
include("vb_filesystem/shared/modules/player/__explicit__player.lua")
include("vb_filesystem/shared/modules/translation/__explicit__manager.lua")

for _, v in pairs(shared_files) do
  if string.GetExtensionFromFilename(v) == "lua" then
    include(v)
  end
end

for _, v in pairs(client_files) do
  if string.GetExtensionFromFilename(v) == "lua" then
    include(v)
  end
end

print([[
   ___    __                        ________       _________   ________      ______            ______                 
   __ |  / /________________  __    ___  __ )_____ ______  /   ___  __ \________  /_______________  /_____ _____  __  
   __ | / /_  _ \_  ___/_  / / /    __  __  |  __ `/  __  /    __  /_/ /  __ \_  /_  _ \__  __ \_  /_  __ `/_  / / /  
   __ |/ / /  __/  /   _  /_/ /     _  /_/ // /_/ // /_/ /     _  _, _// /_/ /  / /  __/_  /_/ /  / / /_/ /_  /_/ /   
   _____/  \___//_/    _\__, /      /_____/ \__,_/ \__,_/      /_/ |_| \____//_/  \___/_  .___//_/  \__,_/ _\__, /    
                       /____/                                                          /_/                 /____/     
   _____________       ______
   ___    |__  /__________  /_______ _
   __  /| |_  /___  __ \_  __ \  __ `/
   _  ___ |  / __  /_/ /  / / / /_/ /
   /_/  |_/_/  _  .___//_/ /_/\__,_/
             /_/
   by Azzen [VERSION ]] .. _VBVERSIONNUMBER .. [[]
]])