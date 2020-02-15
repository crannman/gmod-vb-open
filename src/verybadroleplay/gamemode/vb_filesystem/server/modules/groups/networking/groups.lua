addNetworkString = util.AddNetworkString
addNetworkString("VBNET::Groups::RequestGroupPlayerList")
addNetworkString("VBNET::Groups::InvitePlayerToGroup")
addNetworkString("VBNET::Groups::PlayerJoinGroup")
addNetworkString("VBNET::Groups::PlayerQuitGroup")
addNetworkString("VBNET::Groups::KickPlayer")
addNetworkString("VBNET::Groups::RequestPlayerToJoinGroup")
addNetworkString("VBNET::Groups::PlayerChangePermission")
addNetworkString("VBNET::Groups::GetMembers")
addNetworkString("VBNET::Groups::SendMembers")

net.Receive("VBNET::Groups::PlayerQuitGroup", function(len, pl)

  local currentGroup = pl:GetNWString("VB::NW::Organization::Name")
  if currentGroup ~= "VB-Default-Organization" then
    local steamid = pl:SteamID()
    VBSQL:Query([[
      UPDATE players SET organization_id = NULL WHERE steam_id = ']] .. VBSQL:Escape(steamid) .. [[';
    ]])
    VBSQL:Query([[
      UPDATE players SET group_permissions = 0 WHERE steam_id = ']] .. VBSQL:Escape(steamid) .. [[';
    ]])
    pl:SetNWString("VB::NW::Organization::Name", "VB-Default-Organization")
    pl:SetNWString("VB::NW::Organization::Color", "ffffff")
    pl:SetDTGroupPermissionMask(0)
    pl:SetDTGroupId(0)
    pl:SetWeaponColor(HexToColorRGB(pl:GetNWString("VB::NW::Organization::Color")):ToVector())
  end

end)

net.Receive("VBNET::Groups::GetMembers", function(len, pl)

  local group = pl:GetDTGroupId()
  local players = {}
  local query = VBSQL:Query([[
    SELECT first_name, last_name, group_permissions FROM players
    WHERE organization_id = ]] .. group .. [[;
  ]])
  query:wait()
  local data = query:getData()
  if data == nil then return false end
  for k, v in ipairs(data) do
    if v["first_name"] .. " " .. v["last_name"] == pl:GetCompleteName() then continue end
    local completeName = string.format("%s %s", v["first_name"], v["last_name"])
    players[completeName] = {
      ["online"] = IsOnline(completeName),
      ["permissions"] = tonumber(v["group_permissions"])
    }
  end

  net.Start("VBNET::Groups::SendMembers")
  net.WriteTable(players)
  net.Send(pl)

end)

net.Receive("VBNET::Groups::KickPlayer", function(len, pl)

  if not Permission:Can(pl:GetDTGroupPermissionMask(), Permission.KICK) then return false end
  local playerToKick = net.ReadString()
  if IsOnline(playerToKick) then
    local playerEntity = nil
    for k, v in pairs(player.GetAll()) do
      if v:GetCompleteName() == playerToKick then
        playerEntity = v
      end
    end
    local steamid = playerEntity:SteamID()
    VBSQL:Query([[
      UPDATE players SET organization_id = NULL, group_permissions = 0 WHERE steam_id = ']] .. VBSQL:Escape(steamid) .. [[';
    ]])
    playerEntity:SetNWString("VB::NW::Organization::Name", "VB-Default-Organization")
    playerEntity:SetNWString("VB::NW::Organization::Color", "ffffff")
    playerEntity:SetDTGroupPermissionMask(0)
    playerEntity:SetDTGroupId(0)
    playerEntity:SetWeaponColor(HexToColorRGB(playerEntity:GetNWString("VB::NW::Organization::Color")):ToVector())
  else
    local firstName, lastName = unpack(string.Explode(" ", playerToKick))
    VBSQL:Query([[
      UPDATE players SET organization_id = NULL, group_permissions = 0 WHERE first_name = ']] .. VBSQL:Escape(firstName) .. [[' AND last_name = ']] .. VBSQL:Escape(lastName) .. [[';
    ]])
  end

end)

net.Receive("VBNET::Groups::PlayerChangePermission", function(len, pl)

  if pl:GetNWString("VB::NW::Organization::Name") == "VB-Default-Organization" then return false end
  local playerName = net.ReadString()
  local bitMask = net.ReadInt(9)
  local playerEntity = nil
  for k, v in pairs(player.GetAll()) do
    if v:GetCompleteName() == playerName then
      playerEntity = v
    end
  end
  -- If player is online
  if Permission:Can(pl:GetDTGroupPermissionMask(), Permission.ADMIN) and playerEntity ~= nil then
    local steamid = playerEntity:SteamID()
    VBSQL:Query([[
      UPDATE players SET group_permissions = ]] .. bitMask .. [[
      WHERE steam_id = ']] .. VBSQL:Escape(steamid) .. [[';
    ]])
    playerEntity:SetDTGroupPermissionMask(bitMask)
  -- If player is offline
  elseif Permission:Can(pl:GetDTGroupPermissionMask(), Permission.ADMIN) and playerEntity == nil then
    local firstName, lastName = unpack(string.Explode(" ", playerName))
    VBSQL:Query([[
      UPDATE players SET group_permissions = ]] .. bitMask .. [[
      WHERE first_name = ']] .. VBSQL:Escape(firstName) .. [[' AND last_name = ']] .. VBSQL:Escape(lastName) .. [[';
    ]])
  end

end)

net.Receive("VBNET::Groups::InvitePlayerToGroup", function(len, pl)

  if not Permission:Can(pl:GetDTGroupPermissionMask(), Permission.INVITE) then return false end
  local name = net.ReadString()
  local group = net.ReadString()
  local playerToSendInvitation = nil
  for k,v in pairs(player.GetAll()) do
    if v:GetCompleteName() == name then
      playerToSendInvitation = v
    end
  end
  if playerToSendInvitation ~= nil then
    net.Start("VBNET::Groups::RequestPlayerToJoinGroup")
    net.WriteString(group)
    net.Send(playerToSendInvitation)
  end

end)

net.Receive("VBNET::Groups::PlayerJoinGroup", function(len, pl)

  local group = net.ReadString()
  local steamid = pl:SteamID()
  local query = VBSQL:Query([[
    SET @ID = (SELECT organization_id FROM organization 
    WHERE organization_name = ']] .. VBSQL:Escape(group) .. [[' );
    UPDATE players
    SET players.organization_id = @ID, players.group_permissions = 0
    WHERE steam_id = ']] .. VBSQL:Escape(steamid) .. [[';
  ]])
  local query2 = VBSQL:Query([[
    SELECT organization_color, organization_id FROM organization
    WHERE organization_name = ']] .. VBSQL:Escape(group) .. [[';
  ]])
  query2:wait()
  VBSQL:Query([[
    UPDATE players SET group_permissions = 0 WHERE steam_id = ']] .. VBSQL:Escape(steamid) .. [[';
  ]])
  local id = query2:getData()[1]["organization_id"]
  local col = query2:getData()[1]["organization_color"]
  pl:SetNWString("VB::NW::Organization::Name", group)
  pl:SetNWString("VB::NW::Organization::Color", col)
  pl:SetDTGroupPermissionMask(0)
  pl:SetDTGroupId(id)
  pl:SetWeaponColor(HexToColorRGB(pl:GetNWString("VB::NW::Organization::Color")):ToVector())

end)