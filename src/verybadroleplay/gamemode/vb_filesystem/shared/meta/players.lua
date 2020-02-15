local VBRP_Player = FindMetaTable("Player")


-- @desc Récupère le prénom;
-- @realm Shared;
-- @return string Name;
function VBRP_Player:GetFirstName()
  return self:GetDTFirstName()
end

-- @desc Récupère le nom de famille;
-- @realm Shared;
-- @return string Last name;
function VBRP_Player:GetLastName()
  return self:GetDTLastName()
end

-- @desc Récupère le prénom et le nom de famille;
-- @realm Shared;
-- @return string Complete name;
function VBRP_Player:GetCompleteName()
  return self:GetDTFirstName() .. " " .. self:GetDTLastName()
end

-- @desc Récupère le sexe;
-- @realm Shared;
-- @return string Sex;
function VBRP_Player:GetSex()
  --return self:GetDTSex()
  local sex = ParseModelIdentifier(self:GetDTModel())
  return sex
end

-- @desc  Récupère le statue en cours;
-- @realm Shared;
-- @return string Statue;
function VBRP_Player:GetStatus()
  return self:GetDTStatus()
end

-- @desc Récupère le playermodel;
-- @realm Shared;
-- @return string Player Model;
function VBRP_Player:GetPlayerModel()
  return self:GetDTModel()
end

-- @desc  Vérifie si le joueur est enregistré ou non;
-- @realm Shared;
-- @return boolean IsRegistered;
function VBRP_Player:IsRegistered()
  return self:GetDTRegistered()
end

-- @desc  Récupère l'argent du joueur;
-- @realm Shared;
-- @return int Money;
function VBRP_Player:GetMoney()
  return self:GetDTMoney()
end

-- @desc Vérifie si le joueur peut s'offrir quelque chose ou non;
-- @args integer Price;
-- @realm Shared;
-- @return boolean CanAfford;
function VBRP_Player:CanAfford(price)
  local money = tonumber(self:GetMoney())
  if money - price >= 0 then return true end

  return false
end

-- @desc  Récupère le job du joueur;
-- @realm Shared;
-- @return object Job;
function VBRP_Player:GetJob()
  return VBJOB.GetJob(self)
end

-- @desc  Vérifie si le joueur est prêt d'une entitée;
-- @args entity Entity;
-- @realm Shared;
-- @return boolean IsNearToEntity;
function VBRP_Player:IsNearToEntity(entity)
  for _, v in pairs(ents.FindInSphere(entity:GetPos(), 100)) do
    if v == self then return true end
  end

  return false
end

-- @desc  Vérifie si le joueur est prêt d'un NPC;
-- @args entity Entity;
-- @realm Shared;
-- @return boolean IsNearToNPC;
function VBRP_Player:IsNearToNPC(entity)
  return self:IsNearToEntity(entity)
end

-- @desc  Vérifie si le joueur a atteint la limite pour une entité;
-- @args string ClassName, integer Limit;
-- @realm Shared
-- @return boolean HasClientReachedEntitiesLimit;
function VBRP_Player:HasClientReachedEntitiesLimit(className, limit)

  local Count = 0

  for _, v in pairs(ents.FindByClass(className)) do

    if v:GetEntOwner() == self:GetCompleteName() then
      Count = Count + 1
    end

  end

  if Count >= limit then
    return true
  end

  return false

end

function VBRP_Player:GetRank()
  return self:GetDTRank()
end

function VBRP_Player:GetEnergy()
  return math.Clamp(self:GetDTEnergy(), 0, 100)
end

function VBRP_Player:IsPoliceChief()
  return self:GetDTPoliceChief()
end

function VBRP_Player:IsModerator()
  return self:GetRank() >= 5
end

function VBRP_Player:IsAdmin()
  return self:GetRank() >= 6
end

function VBRP_Player:IsVIP()
  return self:GetRank() >= 2
end

function VBRP_Player:IsSilver()
  return self:GetRank() >= 3
end

function VBRP_Player:IsGold()
  return self:GetRank() >= 4
end

function VBRP_Player:IsSuperAdmin()
  return self:GetRank() >= 7
end

function VBRP_Player:GetGroupName()
  return self:GetNWString("VB::NW::Organization::Name")
end

function VBRP_Player:GetGroupColor()
  return self:GetNWString("VB::NW::Organization::Color")
end

function VBRP_Player:GetGroupPermissions()
  return self:GetDTGroupPermissionMask()
end

function VBRP_Player:SameGroupAs(ply)
  if type(ply) == "string" then
    for k,v in pairs(player.GetAll()) do
      if v:GetCompleteName() == ply then
        return self:GetGroupName() == v:GetGroupName()
      end
    end
  end
  return self:GetGroupName() == ply:GetGroupName()
end

function GetSteamIDFromPlayerName(playerName)
  for k, v in pairs(player.GetAll()) do
    if v:GetCompleteName() == playerName then
      return v:SteamID()
    end
  end
  return nil
end

function GetPlayerByName(name)
  for k, v in pairs(player.GetAll()) do
    if v:GetCompleteName() == name then
      return v
    end
  end
end

if SERVER then

  function GetPlayerBySteamID(steamid)
    for k, v in pairs(player.GetAll()) do
      if v:SteamID() == steamid then
        return v
      end
    end
  end
  

end
function GetPlayerNameFromSteamID(steamid)
  for k, v in pairs(player.GetAll()) do
    if v:SteamID() == steamid then
      return v:GetCompleteName()
    end
  end
end

function IsOnline(str, isSteamId)
  isSteamId = isSteamId or false
  local found = false
  for k,v in pairs(player.GetAll()) do
    if isSteamId and v:SteamID() == str then
      found = true
      break
    elseif v:GetCompleteName() == str then
      found = true
      break
    end
  end
  return found
end

-- @desc Obtient le vecteur correct pour spawn une entité;
-- @realm Shared;
-- @return vector SpawnPos;
function VBRP_Player:GetSpawnVector()
  local maxSpawnDistance = 200	
  local spawnPos = self:EyePos() + self:EyeAngles():Forward() * maxSpawnDistance
  local tr = util.TraceLine({
    start = self:EyePos(),
    endpos = spawnPos,
    filter = {self}})
  if (tr.HitPos) then
    spawnPos = tr.HitPos + (tr.HitNormal * Vector(10,10,10))
  end

  return spawnPos
end

function VBRP_Player:IsArrested()
  return self:GetDTArrested()
end