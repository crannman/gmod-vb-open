
VBSpawnpoints = {
  { ["Vector"] = Vector(-5502.060547, -7445.220215, 140), ["Angle"] = Angle(0, 180, 0) },
  { ["Vector"] = Vector(-5475.397461, -6303.645996, 140), ["Angle"] = Angle(0, 180, 0) },
  { ["Vector"] = Vector(-5069.559082, -6557.178223, 140), ["Angle"] = Angle(0, 180, 0) },
  { ["Vector"] = Vector(-5444.224121, -6646.794434, 140), ["Angle"] = Angle(0, 180, 0) }
}

local hospitalBedSpawnPoints = {
  { Vector(-9944, 8952, 105), Angle(-90, -90, 180) },
  { Vector(-10064, 8952, 105), Angle(-90, -90, 180) },
  { Vector(-10179, 8952, 105), Angle(-90, -90, 180) },
  { Vector(-9944, 9135, 105), Angle(-90, 90, 180) },
  { Vector(-10064, 9135, 105), Angle(-90, 90, 180) },
  { Vector(-10183, 9135, 105), Angle(-90, 90, 180) },
}

function SpawnHospitalBeds()
  for k, v in ipairs(hospitalBedSpawnPoints) do
    local bed = ents.Create("prop_vehicle_prisoner_pod")
    bed:SetModel("models/vehicles/prisoner_pod_inner.mdl")
    bed:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod_non_interactive.txt")
    bed:SetKeyValue("limitview", "0")
    bed:SetKeyValue("vehiclelocked", "1")
    bed:SetPos(v[1])
    bed:SetAngles(v[2])
    bed:SetRenderMode(RENDERMODE_TRANSALPHA)
    bed:SetColor(Color(255, 255, 255, 0))
    bed:Spawn()
    bed:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
    bed:SetMoveType(MOVETYPE_NONE)
    bed:SetVehicleEntryAnim(false)
  end
end

function AddSpawnPoints()
  for _, v in ipairs(ents.FindByClass("info_player_start")) do
    v:Remove()
  end
  local count = 0
  for _, spawnpoints in ipairs(VBSpawnpoints) do
    local ips = ents.Create("info_player_start")
    ips:SetPos(spawnpoints["Vector"])
    ips:SetAngles(spawnpoints["Angle"])
    ips:Spawn()
    count = count + 1
  end
  VBRP.log("Added " .. count .. " spawnpoints.", "VB-Framework::MapPreparation")
end

function CreateWorldProp(data)

  local ent = ents.Create(data.Class)
  ent:SetPos(data.Pos)
  ent:SetAngles(data.Angle)
  ent:SetModel(data.Model)
  ent:Spawn()
  ent:SetNWBool("VB::NW::Bool::Flag::MapEntity", true)
  ent:PhysicsInit(SOLID_VPHYSICS)
  ent:SetMoveType(MOVETYPE_NONE)
  ent:SetSolid(SOLID_VPHYSICS)
  ent:SetUseType(SIMPLE_USE)

  local phys = ent:GetPhysicsObject()
  if (IsValid(phys)) then
    phys:Wake()
  end

end

function LoadMapSave()
  local fileHandler = file.Open("wpm/verybadroleplay.gms", "rb", "DATA")

  if not fileHandler then
    VBRP.log("Error while reading GMS file...", "VB-Framework::MapPreparation")
    return false
  end

  if not fileHandler:Read(4) == "GMS3" then
    fileHandler:Close()
    VBRP.log("Invalid GMS signature...", "VB-Framework::MapPreparation")
    return false
  end

  fileHandler:ReadLine():sub(1, -2) -- utile pour placer le pointeur du stream au bonne endroit (renvoie la map)
  local buffer = fileHandler:Read(fileHandler:Size() - fileHandler:Tell())
  fileHandler:Close()

  local data = util.Decompress(buffer)

  if not isstring(data) then
    VBRP.log("Error while decompressing GMS File...", "VB-Framework::MapPreparation")
    return false
  end

  local jsonData = util.JSONToTable(data)

	duplicator.RemoveMapCreatedEntities()
  for k, v in pairs(jsonData.Entities) do
    CreateWorldProp(v)
  end

  VBRP.log("Successfully loaded default props using save manager", "VB-Framework::MapPreparation")
end


function SpawnDefaultEntities()
  local ve = ents.Create("vbrp_view_entity")
  ve:Spawn()
  local light = ents.Create("vbrp_light")
  light:SetDTLightIdentifier("VBENT::LIGHT::CHARCREATION")
  light:SetPos(Vector(-3673, -4621, 924))
  light:SetAngles(Angle(0, 0, 0))
  light:SetDTState(true)
  light:Spawn()
  VBRP.log("Successfully loaded default entities", "VB-Framework::MapPreparation")

  local policeComputer = ents.Create("vbrp_police_computer")
  policeComputer:SetPos(Vector(-7275, -9625, -402))
  policeComputer:SetAngles(Angle(0, 90, 0))
  policeComputer:SetMoveType(MOVETYPE_NONE)
  policeComputer:Spawn()
  policeComputer:SetNWBool("VB::NW::Bool::Flag::MapEntity", true)

  local poliecRack = ents.Create("vbrp_police_weapon_rack")
  poliecRack:SetPos(Vector(-7369, -9075, -432))
  poliecRack:SetAngles(Angle(0, 0, 0))
  poliecRack:SetMoveType(MOVETYPE_NONE)
  poliecRack:Spawn()
  poliecRack:SetNWBool("VB::NW::Bool::Flag::MapEntity", true)

  SpawnHospitalBeds()

end


hook.Add("InitPostEntity", "VBHOOK::LoadMap", function()
  game.CleanUpMap()
  LoadMapSave()
  AddSpawnPoints()
  SpawnDefaultEntities()
  CreateJail()
end)
