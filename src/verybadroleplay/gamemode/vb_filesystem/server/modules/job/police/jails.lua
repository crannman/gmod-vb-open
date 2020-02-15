VBRP_Jails = {
  { Door = 2526, Max = Vector(-7584, -9975, -304), Min = Vector(-7695, -9856, -435) },
  { Door = 2553, Max = Vector(-7376, -9856, -304), Min = Vector(-7265, -9975, -435) },
  { Door = 2530, Max = Vector(-7584, -10103, -304), Min = Vector(-7695, -9984, -435) },
  { Door = 2551, Max = Vector(-7376, -9984, -304), Min = Vector(-7265, -10103, -435) },
  { Door = 2533, Max = Vector(-7584, -10231, -304), Min = Vector(-7695, -10112, -435) },
  { Door = 2549, Max = Vector(-7376, -10112, -304), Min = Vector(-7265, -10231, -435) },
  { Door = 2536, Max = Vector(-7584, -10359, -304), Min = Vector(-7695, -10240, -435) },
  { Door = 2547, Max = Vector(-7376, -10240, -304), Min = Vector(-7265, -10359, -435) },
}
VBRP_Arrested_Players = {}
local fmt = string.format
local strftime = string.FormattedTime
local ipairs = ipairs
local clamp = math.Clamp

function CreateJail()

  for k, v in ipairs(VBRP_Jails) do
    local cellDoor = ents.GetMapCreatedEntity(v["Door"])
    local controller = ents.Create("vbrp_door_network_controller")
    controller:SetDTOwner("world")
    controller:SetDTName(fmt("Cell %d", k))
    controller:Spawn()
    controller:SetParent(cellDoor)
    cellDoor:SetNWBool("VB::NW::Bool::Flag::CellDoor", true)
  end
  VBRP.log(fmt("Registered %d cells", #VBRP_Jails), "VB-Framework::Jail")
end

function GetCell(doorId)
  for k, v in ipairs(VBRP_Jails) do
    if v["Door"] == Entity(doorId):MapCreationID() then
      return v
    end
  end
  return nil
end

function GetCellMapID(mapId)
  for k, v in ipairs(VBRP_Jails) do
    if v["Door"] == mapId then
      return v
    end
  end
  return nil
end

function GetPlayerInCellFromMapId(mapId)
  local cell = GetCellMapID(mapId)
  for k, v in ipairs(ents.FindInBox(cell.Min, cell.Max)) do
    if v:IsPlayer() and v:IsArrested() then return v end
  end
  return nil
end

function GetPlayerInCell(doorId)
  local cell = GetCell(doorId)
  for k, v in ipairs(ents.FindInBox(cell.Min, cell.Max)) do
    if v:IsPlayer() and v:IsArrested() then return v end
  end
  return nil
end

function IsCellEmpty(doorId)
  local cell = GetCell(doorId)
  for k, v in ipairs(ents.FindInBox(cell.Min, cell.Max)) do
    if v:IsPlayer() and v:IsArrested() then return false end
  end
  return true
end

function JailPlayer(pl, time, doorId, caller)
  time = clamp(time, 60, 900)

  if IsValid(pl) and pl:IsArrested() then
    pl.IsInJail = true
    VBRP_Arrested_Players[pl:SteamID()] = {
      StartTime = tostring(os.time()),
      EndTime = tostring(os.time() + time),
      ArrestedBy = caller:SteamID()
    }
    local str = fmt("Vous êtes en prison pour: %s ", strftime(time, "%i minutes et %i secondes"))
    NotifyPlayer(str, pl)
    timer.Create("VBTIMER::JAIL_TIME::" .. pl:SteamID64(), time, 1, function()
      NotifyPlayer("Vous êtes libre", pl)
      VBRP_Arrested_Players[pl:SteamID()] = nil
      pl:SetPos(Vector(-6913, -9200, -431))
      pl:SetAngles(Angle(0, 90, 0))
      pl:SetDTArrested(false)
      pl:SetDTStatus("")
      pl:MakeLoadout()
      pl:SetRunSpeed(320)
      Entity(doorId):Fire("unlock")
      pl.IsInJail = false
    end)
  end
end
