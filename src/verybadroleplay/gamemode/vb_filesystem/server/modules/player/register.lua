util.AddNetworkString("VBRP_RegisterPlayerInformations")
util.AddNetworkString("VBNET_LoadMoneyClientSide")

net.Receive("VBRP_RegisterPlayerInformations", function(_, ply)
  local steamId = ply:SteamID()
  local firstName = net.ReadString()
  local lastName = net.ReadString()
  local bodyGroup = net.ReadString()
  local sex = net.ReadString()
  local date = net.ReadString()
  local query = "insert into players(rank_id, steam_id, first_name, last_name, sex, first_connection, bodygroup, player_money) values('1', '" .. VBSQL:Escape(steamId) .. "', '" .. VBSQL:Escape(firstName) .. "','" .. VBSQL:Escape(lastName) .. "','" .. VBSQL:Escape(sex) .. "','" .. VBSQL:Escape(date) .. "','" .. VBSQL:Escape(bodyGroup) .. "', 15000);"
  VBSQL:Query(query)
  ply:SetTeam(1)
  ply:SetDTFirstName(firstName)
  ply:SetDTLastName(lastName)
  ply:SetDTModel(bodyGroup)
  ply:SetDTSex(Either(sex == "m", 1, 0))
  ply:LoadPlayer()
  ply:SetDTRegistered(true)
  ply:KillSilent()
  ply:UnSpectate()
  ply:Spawn()
end)

local VBRP_Player = FindMetaTable("Player")

-- @desc Charge les informations de base d'un joueur;
-- @realm Server
function VBRP_Player:LoadPlayer()
  local query = VBSQL:Query("select * from players where steam_id = '" .. VBSQL:Escape(self:SteamID()) .. "';")
  query:wait()

  for k, v in pairs(query:getData()[1]) do
    if k == "first_name" then
      self:SetDTFirstName(v)
    elseif k == "last_name" then
      self:SetDTLastName(v)
    elseif k == "sex" then
      if v == "m" then
        self:SetDTSex(0)
      else
        self:SetDTSex(1)
      end
    elseif k == "bodygroup" then
      self:SetDTModel(v)
    elseif k == "player_money" then
      self:SetDTMoney(tonumber(v))
    elseif k == "rank_id" then
      self:SetDTRank(tonumber(v))
    elseif k == "organization_id" then
      if isnumber(v) then
        self:SetDTGroupId(v)
      else
        self:SetDTGroupId(0)
      end
    elseif k == "group_permissions" then
      self:SetDTGroupPermissionMask(v)
    elseif k == "is_police_chief" then
      self:SetDTPoliceChief(Either(tonumber(v) == 1, true, false))
    end
  end
  self:SetOrgInfo()
end

function VBRP_Player:SetOrgInfo()
  if self:GetDTGroupId() == 0 then
    self:SetNWString("VB::NW::Organization::Name", "VB-Default-Organization")
    self:SetNWString("VB::NW::Organization::Color", "ffffff")
  else
    local steamid = self:SteamID()
    local query = VBSQL:Query("select organization_name, organization_color from organization inner join players on players.organization_id = organization.organization_id where players.steam_id = '" .. VBSQL:Escape(steamid) .. "';")
    query:wait()

    self:SetNWString("VB::NW::Organization::Name", query:getData()[1]["organization_name"])
    self:SetNWString("VB::NW::Organization::Color", query:getData()[1]["organization_color"])
  end
end