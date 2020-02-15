util.AddNetworkString("VBRP_ShowRegisterMenu")

--[[-------------------------------------------------------------------------
Event Listener : PlayerInitialSpawn
Begins the registering process if necessary
---------------------------------------------------------------------------]]

function GM:PlayerInitialSpawn(ply)
  player_manager.SetPlayerClass(ply, "player_verybadroleplay")
  if ply:IsBot() then
    ply:SetModel("models/player/eli.mdl")
    ply:SetDTFirstName("Eli")
    ply:SetDTLastName("Vance")

    return false
  end

  local q = VBSQL:Query("select steam_id from players where steam_id = '" .. VBSQL:Escape(ply:SteamID()) .. "';")
  q:wait()

  if q:getData()[1] ~= nil then
    if q:getData()[1]["steam_id"] == ply:SteamID() then
      ply:LoadPlayer()
      ply:SetDTRegistered(true)
    end
  else
    ply:SetDTRegistered(false)
  end

  if not ply:IsRegistered() and IsValid(ply) then
    net.Start("VBRP_ShowRegisterMenu")
    net.Send(ply)
  end
  ply:SetTeam(1)
end

--[[-------------------------------------------------------------------------
Event Listener : PlayerAuthed
Called when the player is authenticated
If ply is registered then LoadPlayer
---------------------------------------------------------------------------]]
function GM:PlayerAuthed(ply)
  player_manager.SetPlayerClass(ply, "player_verybadroleplay")
  BroadcastNotification(ply:GetCompleteName() .. " is connected.")
  if ply:IsBot() then return false end

   if not ply:IsRegistered() and IsValid(ply) then
    GAMEMODE:PlayerSpawnAsSpectator(ply)
  end
end

--[[-------------------------------------------------------------------------
Event Listener : PlayerSpawn
Called when the player respawn / spawn
Player's loadout
---------------------------------------------------------------------------]]
function GM:PlayerSpawn(ply)
  if ply.DeathRagdoll and IsValid(ply.DeathRagdoll) then
    ply:SetDTDeathRagdollIndex(-1)
    ply.DeathRagdoll:Remove()
  end

  player_manager.SetPlayerClass(ply, "player_verybadroleplay")
  if not ply:IsRegistered() then return false end
  local job = ply:GetJob()
  
  for _, v in pairs(job.Loadout) do
    ply:Give(v)
  end
  
  job:ApplyModel(ply)
  ply:Give("vbrp_keys")
  ply:Give("weapon_fists")
  if ply:IsVIP() then
    ply:Give("weapon_physgun")
  end
  
  if job.Armor then
    ply:SetArmor(job.Armor)
  end

  if ply:IsSuperAdmin() then
    ply:Give("vbrp_doorsutil")
    ply:Give("vbrp_posutil")
    ply:Give("vbrp_vector_helper")
  end
  
  if ply:IsModerator() then
    ply:Give("vbrp_entity_info_finder")
  end
  ply:SetViewEntity(ply)
  ply:SetWeaponColor(HexToColorRGB(ply:GetNWString("VB::NW::Organization::Color")):ToVector())
  ply:SetDTMoney(ply:GetMoney())
  ply:SetDTStatus("")
  ply:SetupHands()
  if ply:GetDTArrested() then ply:SetDTArrested(false) end
  ply:SetEnergy(100)
end

function GM:PlayerConnect(name, ip)
  BroadcastNotification(name .. " joined the server")
end

--[[-------------------------------------------------------------------------
Event Listener : PlayerSelectSpawn
Called when player has to choose a spawn point
Todo: check if spawnpoint is suitable for spawning
---------------------------------------------------------------------------]]
function GM:PlayerSelectSpawn(ply)
  local spawnpoints = ents.FindByClass("info_player_start")
  local backup = math.random(#spawnpoints)

  for i = 0, #spawnpoints do
    local rdm_spwn = math.random(#spawnpoints)
    if hook.Run("IsSpawnpointSuitable", ply, spawnpoints[rdm_spwn], false) then
      return spawnpoints[rdm_spwn]
    end
  end
  return spawnpoints[backup]
end

function GM:PlayerDisconnected(ply)

  FlushFriendList(ply)
  ply:FlushFoodIngredientsInventory()
  
  if ply:GetDTDeathRagdollIndex() ~= -1 then
    local rag = Entity(ply:GetDTDeathRagdollIndex())
    if IsValid(rag) then
      rag:Remove()
    end
  end

  for k, v in ipairs(ents.FindByClass("vbrp_item")) do
    if v:GetEntOwner() == ply:GetCompleteName() then
      v:Remove()
    end
  end
  
  for k,v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
    if v:GetEntOwner() == ply:GetCompleteName() then
      v:Remove()
    end
  end

  for k, v in ipairs(ents.FindByClass("func_door*")) do
    if v:GetEntOwner() == ply:GetCompleteName() then
      v:SetDoorOwner("world")
      if not v:IsDoorLocked() then
        v:Fire("lock")
      end
      if v:IsDoorOpened() then
        v:Fire("close", "", 0.1)
      end
    end
  end

  for k, v in ipairs(ents.FindByClass("prop_door_rotating")) do
    if v:GetEntOwner() == ply:GetCompleteName() then
      v:SetDoorOwner("world")
      if not v:IsDoorLocked() then
        v:Fire("lock")
      end
      if v:IsDoorOpened() then
        v:Fire("close", "", 0.1)
      end
    end
  end

  if ply:IsRegistered() then
    BroadcastNotification(ply:GetCompleteName() .. " has left the server.")
  end

end