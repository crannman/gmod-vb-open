local VBRP_Player = FindMetaTable("Player")

-- @desc Met à jour l'argent d'un joueur;
-- @args int Amount, string Operator;
-- @realm Server;
function VBRP_Player:UpdateMoney(amount, operator)
  local steamId = self:SteamID()

  if operator == "add" then
    local Query = VBSQL:Query("UPDATE players SET player_money = player_money + " .. amount .. " where steam_id = '" .. VBSQL:Escape(steamId) .. "';")
    Query:wait()
  elseif operator == "sub" then
    local Query = VBSQL:Query("UPDATE players SET player_money = player_money - " .. amount .. " where steam_id = '" .. VBSQL:Escape(steamId) .. "';")
    Query:wait()
  elseif operator == "set" then
    local Query = VBSQL:Query("UPDATE players SET player_money = " .. amount .. " where steam_id = '" .. VBSQL:Escape(steamId) .. "';")
    Query:wait()
  end

  local query2 = VBSQL:Query("SELECT player_money FROM players WHERE steam_id = '" .. VBSQL:Escape(steamId) .. "';")
  query2:wait()
  local moneyData = query2:getData()[1]["player_money"]
  self:SetDTMoney(moneyData)
end