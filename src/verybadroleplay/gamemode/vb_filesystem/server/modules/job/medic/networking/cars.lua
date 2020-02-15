local addNetworkString = util.AddNetworkString
local recv = net.Receive
local vec3 = Vector
local l2w = util.LocalToWorld
local ang = Angle
local findInBox = ents.FindInBox
local clr = Color
addNetworkString("VBNET::Jobs::Medic::SpawnAmbulance")


local ambuSpawnPoints = {
  { vec3(-9165, 9033, 64), ang(0, 180, 0) },
  { vec3(-9165, 9700, 64), ang(0, 180, 0) }
}

recv("VBNET::Jobs::Medic::SpawnAmbulance", function(len, pl)
  if not (pl:Team() == TEAM_MEDIC) then
    return false 
  end
  for k,v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
    if v:GetNWString("VB::NW::Car::Owner") == pl:SteamID() then
      v:Remove()
    end
  end

  local spawnIndex = 0
  for k,v in ipairs(ambuSpawnPoints) do
    local min, max = GetWorldBoxCornerVectors(v[1], vec3(-128,-64, 0), vec3(128, 64, 128), v[2])
    if #findInBox(min, max) > 0 then continue end
    if #findInBox(min, max) == 0 then
      spawnIndex = k
      break
    end
  end

  if spawnIndex == 0 then NotifyPlayer([[Une place doit se libérer avant de faire apparaître un nouveau véhicule !]], pl) return false end

  local veh = ents.Create("prop_vehicle_jeep")
  veh:SetModel("models/lonewolfie/ford_f350_ambu.mdl")
  veh:SetPos(ambuSpawnPoints[spawnIndex][1])
  veh:SetAngles(ambuSpawnPoints[spawnIndex][2])
  veh:SetKeyValue("vehiclescript", "scripts/vehicles/ford_f350_ambu.txt")
  veh:SetSkin(2)
  veh:SetColor(clr(255, 255, 255))
  veh:Spawn()
  veh:SetVehicleEntryAnim(false)
  veh:SetNWString("VB::NW::Car::Owner", pl:SteamID())

  local es = ents.Create("prop_vehicle_prisoner_pod")
  es:SetModel("models/vehicles/prisoner_pod_inner.mdl")
  es:SetParent(veh)
  es:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod_ambu.txt")
  es:SetKeyValue("limitview", "0")
  es:SetKeyValue("vehiclelocked", "1")
  es:SetPos(l2w(veh, Vector(18, -130, 85)))
  es:SetAngles(veh:LocalToWorldAngles(ang(-90,90,180)))
  es:SetRenderMode(RENDERMODE_TRANSALPHA)
  es:SetColor(clr(255, 255, 255, 0))
  es:Spawn()
  es:SetVehicleEntryAnim(false)

end)