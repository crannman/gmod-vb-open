local insert = table.insert
local fmt = string.format
local isclr = IsColor
local clr = Color
local addNetworkString = util.AddNetworkString
local start = net.Start
local writetbl = net.WriteTable
local broadcast = net.Broadcast
local send = net.Send
local recv = net.Receive
local readstr = net.ReadString
local findInSphere = ents.FindInSphere
local isvalid = IsValid
local ct = CurTime
local getHumans = player.GetHumans
local istable = istable
local isstring = isstring
local ipairs = ipairs
local pairs = pairs

addNetworkString("VBNET_ChatNotify")
addNetworkString("VBNET_ClientsideChatNotify")

local function GenerateChatBufferOrdered(layout, ply, message)

  local buffer = {}
  local varargs = {}
  for key, val in ipairs(layout) do
    if istable(val) then
      -- If table is color
      if isclr(val) then
        insert(buffer, val)
      end
      -- If table is parameters
      if val.Parameters then
        for _, param in pairs(val.Parameters) do
          if param == "PlayerName" then
            insert(varargs, ply:GetCompleteName())
          end
          if param == "Text" then
            insert(varargs, message)
          end
        end
      end
    end
    if isstring(val) and val == "Text" then
      insert(buffer, message)
    else
      insert(buffer, val)
    end
  end
  insert(buffer, ct() + 10)
  return buffer

end

function ServerSay(message)
  
  local layout = {
    clr(244, 31, 221),
    "(VeryBadRoleplayServer) ",
    clr(255, 255, 255, 255),
    "Text",
  }
  local buffer = GenerateChatBufferOrdered(layout, _, message)
  start("VBNET_ChatNotify")
  writetbl(buffer)
  broadcast()

end

-- Couleur police: Color(0, 120, 255)
function VBChatNotify(message, radius, ply)

  ply = ply or nil
  radius = radius or 0

  local layout = {
    [1] = clr(0, 170, 255),
    [2] = "(VeryBadRoleplay) ",
    [3] = clr(255, 255, 255),
    [4] = "Text"
  }

  local buffer = GenerateChatBufferOrdered(layout, ply, message)

  if ply then
    start("VBNET_ChatNotify")
    writetbl(buffer)
    send(ply)
  elseif ply and radius ~= 0 then
    for _, e in pairs(findInSphere(ply:GetPos(), radius)) do
      if e:IsPlayer() then
        start("VBNET_ChatNotify")
        writetbl(buffer)
        send(e)
      end
    end
  else
    start("VBNET_ChatNotify")
    writetbl(buffer)
    broadcast()
  end

end
recv("VBNET_ClientsideChatNotify", function(len, ply)

  VBChatNotify(readstr(), 0, ply)

end)

function NotifyPlayer(message, pl)

  if isvalid(pl) then
    pl:LuaRun(fmt([[ClientsideNotify("%s")]], message))
  end

end

function BroadcastNotification(message)

  for k, v in ipairs(getHumans()) do
    if isvalid(v) then
      v:LuaRun(fmt([[ClientsideNotify("%s")]], message))
    end
  end

end

function NotifyInRadius(message, radius, origin)

  for k, v in ipairs(findInSphere(origin, radius)) do
    if v:IsPlayer() and isvalid(v) then
      v:LuaRun(fmt([[ClientsideNotify("%s")]], message))
    end
  end

end