local addNetworkString = util.AddNetworkString
local isvalid = IsValid
local fmt = string.format
local recv = net.Receive
local vec3 = Vector
local ang = Angle
local clr = Color
local random = math.random
local l2w = util.LocalToWorld
local makeent = ents.Create
local findInBox = ents.FindInBox
local AMMO_INDEX = 3
local policeVehSpawnPoints = {
  { vec3(-6900, -9215, -120), ang(0, 90, 0) },
  { vec3(-6900, -9472, -120), ang(0, 90, 0) },
  { vec3(-6900, -9756, -120), ang(0, 90, 0) },
  { vec3(-6900, -10011, -120), ang(0, 90, 0) },
  { vec3(-7634, -10011, -120), ang(0, -90, 0) },
  { vec3(-7634, -9215, -120), ang(0, -90, 0) },
  { vec3(-7634, -9472, -120), ang(0, -90, 0) },
  { vec3(-7634, -9756, -120), ang(0, -90, 0) },
}
addNetworkString("VBNET::Jobs::Police::SpawnVehicle")
addNetworkString("VBNET::Jobs::Police::StoreVehicle")
addNetworkString("VBNET::Jobs::Police::OpenPoliceVehicleContextMenu")
addNetworkString("VBNET::Jobs::Police::ShouldShowPoliceVehicleContextMenu")
addNetworkString("VBNET::Jobs::Police::Trunk::SpawnItem")
addNetworkString("VBNET::Jobs::Police::Trunk::Open")

recv("VBNET::Jobs::Police::OpenPoliceVehicleContextMenu", function(len, pl)

  local isInPoliceVehicle = false
  local veh = pl:GetVehicle()
  local script = veh:GetKeyValues()["VehicleScript"]
  local isPassenger = isvalid(veh:GetParent()) and veh:GetClass() == "prop_vehicle_prisoner_pod"

  if isPassenger then 
    script = veh:GetParent():GetKeyValues()["VehicleScript"]
  end

  if VBJOB.GetJob(pl).Police and isvalid(pl) and pl:Alive() and pl:InVehicle() and script == "scripts/vehicles/mas_ghibli_pol.txt" then
    isInPoliceVehicle = true
  end

  net.Start("VBNET::Jobs::Police::ShouldShowPoliceVehicleContextMenu")
  net.WriteBool(isInPoliceVehicle)
  net.Send(pl)

end)

recv("VBNET::Jobs::Police::Trunk::SpawnItem", function(len, pl)

  local items = {
    {
      Class = "vbrp_item",
      Model = "models/props_wasteland/barricade001a.mdl",
      Name = "Barricade de police",
      Desc = "",
    },
    {
      Class = "vbrp_item",
      Model = "models/props_wasteland/barricade002a.mdl",
      Name = "Barricade de police",
      Desc = "",
    },
    {
      Class = "Ammo"
    }
  }

  local trunk = net.ReadEntity()
  local idx = net.ReadInt(8)
  if not trunk:GetDTLocked() and items[idx] then

    if idx == AMMO_INDEX then 
      local weapon = pl:GetWeapon("cstm_pistol_glock18")
      pl:GiveLimitedAmmo(weapon)
      if IsValid(pl:HeavyWeapon()) then
        pl:GiveLimitedAmmo(pl:HeavyWeapon())
      end
      return false
    end

    local item = items[idx]
    local ent = makeent(item.Class)
    ent:SetDTOwner(pl:SteamID())
    ent:SetDTName(item.Name)
    ent:SetDTDesc(item.Desc)
    ent:SetModel(item.Model)
    ent:SetPos(trunk:LocalToWorld(vec3(ent:OBBMaxs().x / 2, 30 + ent:OBBMaxs().y, 10 + ent:OBBMaxs().z)))
    ent:Spawn()
    function ent:Use(activator, caller, useType, value)
      if caller:IsArrested() then return false end
        if self:GetEntOwner() == caller:GetCompleteName() or GetPlayerBySteamID(self:GetDTOwner()):IsFriendWith(caller:SteamID()) then
          self:Remove()
        end
      end
    end

end)

recv("VBNET::Jobs::Police::SpawnVehicle", function(len, pl)

  for k,v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
    if v:GetNWString("VB::NW::Car::Owner") == pl:SteamID() then
      v:Remove()
    end
  end

  local spawnIndex = 0
  for k,v in ipairs(policeVehSpawnPoints) do
    local min, max = GetWorldBoxCornerVectors(v[1], vec3(-128,-64, 0), vec3(128, 64, 128), v[2])
    if #findInBox(min, max) > 0 then continue end
    if #findInBox(min, max) == 0 then
      spawnIndex = k
      break
    end
  end

  if spawnIndex == 0 then NotifyPlayer([[Une place doit se libérer avant de faire apparaître une nouveau véhicule !]], pl) return false end

  local veh = ents.Create("prop_vehicle_jeep")
  veh:SetModel("models/tdmcars/mas_ghibli.mdl")
  veh:SetPos(policeVehSpawnPoints[spawnIndex][1])
  veh:SetAngles(policeVehSpawnPoints[spawnIndex][2])
  veh:SetKeyValue("vehiclescript", "scripts/vehicles/mas_ghibli_pol.txt")
  veh:SetColor(clr(255, 255, 255))
  veh:SetSkin(random(1, 2))
  veh:Spawn()
  veh:SetNWString("VB::NW::Car::Owner", pl:SteamID())

  local prop1 = ents.Create("prop_dynamic_ornament")
  prop1:SetParent(veh)
  prop1:SetModel("models/sentry/defendertc2.mdl")
  prop1:SetModelScale(0.70, 0)
  prop1:SetPos(l2w(veh, vec3(0, -30, 74)))
  prop1:SetAngles(veh:LocalToWorldAngles(ang(0,180,0)))
  prop1:Spawn()
  prop1:Fire("DisableCollision")
  prop1:DrawShadow(true)
  prop1:SetNoDraw(false)

  local prop2 = ents.Create("prop_dynamic_ornament")
  prop2:SetParent(veh)
  prop2:SetModel("models/sentry/police/pushbar.mdl")
  prop2:SetModelScale(0.70, 0)
  prop2:SetPos(l2w(veh, vec3(0, 117, 24)))
  prop2:SetAngles(veh:LocalToWorldAngles(ang(0,0,0)))
  prop2:Spawn()
  prop2:Fire("DisableCollision")
  prop2:DrawShadow(true)
  prop2:SetNoDraw(false)

  local license = ents.Create("vbrp_license_plate")
  license:SetParent(veh)
  license:SetPos(l2w(veh, vec3(0, -120, 43)))
  license:SetDTLicense(fmt("2-19-1-%d%d%d", random(0, 9), random(0, 9), random(0, 9)))
  license:Spawn()

  local trunk = ents.Create("vbrp_vehicle_trunk")
  trunk:SetParent(veh)
  trunk:SetPos(l2w(veh, vec3(0, -105, 50)))
  trunk:SetAngles(veh:LocalToWorldAngles(ang(0,180,0)))
  trunk:Spawn()
  trunk.TrunkLimit = 5

  
  function trunk:Use(activator, caller, useType, value)

    if self:GetDTLocked() then activator:LuaRun("ClientsideNotify('This trunk is locked...')") return false end
    if caller:IsArrested() or not VBJOB.GetJob(caller).Police then return false end
    local Items = {
      {
        Name = "Barricade de police",
        Model = "models/props_wasteland/barricade001a.mdl",
        Desc = "",
      },
      {
        Name = "Barricade de police",
        Model = "models/props_wasteland/barricade002a.mdl",
        Desc = "",
      },
      {
        Name = "Munitions",
        Model = "models/Items/BoxMRounds.mdl",
        Desc = "",
      }
    }
    net.Start("VBNET::Jobs::Police::Trunk::Open")
    net.WriteEntity(self)
    net.WriteTable(Items)
    net.Send(activator)
  end

  function trunk:StartTouch() return false end

end)
