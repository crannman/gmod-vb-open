addNetworkString = util.AddNetworkString
addNetworkString("VBNET::Friends::AddFriend")
addNetworkString("VBNET::Friends::RemoveFriend")
addNetworkString("VBNET::Friends::FetchFriendsList")
addNetworkString("VBNET::Friends::FlushFriendsList")
addNetworkString("VBNET::Friends::SendFriendsList")

ServerFriends = {}

net.Receive("VBNET::Friends::AddFriend", function(len, pl)

  local steamId = pl:SteamID()
  local friendSteamId = net.ReadString()
  if IsOnline(friendSteamId, true) and not pl:IsFriendWith(friendSteamId) then
    if not ServerFriends[steamId] then
      ServerFriends[steamId] = {}
    end
    ServerFriends[steamId][friendSteamId] = true
  end

end)

net.Receive("VBNET::Friends::RemoveFriend", function(len, pl)

  local steamId = pl:SteamID()
  local friendSteamId = net.ReadString()
  if IsOnline(friendSteamId, true) and ServerFriends[steamId] and ServerFriends[steamId][friendSteamId] then
      ServerFriends[steamId][friendSteamId] = nil
  end

end)

net.Receive("VBNET::Friends::FetchFriendsList", function(len, pl)

  local steamId = pl:SteamID()
  net.Start("VBNET::Friends::SendFriendsList")
  if ServerFriends[steamId] then
    net.WriteTable(ServerFriends[steamId])
  else
    net.WriteTable({})
  end
  net.Send(pl)

end)