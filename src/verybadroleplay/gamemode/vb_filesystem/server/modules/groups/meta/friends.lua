local VBRP_Player = FindMetaTable("Player")

function VBRP_Player:IsFriendWith(steamid)
  if ServerFriends[self:SteamID()] then
    if ServerFriends[self:SteamID()][steamid] then
      return true
    end
  end
  return false
end

function FlushFriendList(pl)

  local steamId = pl:SteamID()
  if ServerFriends[steamId] then
    ServerFriends[steamId] = nil
  end

end