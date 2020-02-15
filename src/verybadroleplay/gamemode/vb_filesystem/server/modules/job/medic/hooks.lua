local addEventListener = hook.Add
local fmt = string.format
local findInSphere = ents.FindInSphere
local findByClass = ents.FindByClass
local ipairs = ipairs
local notify = NotifyPlayer
local isvalid = IsValid
local AMBULANCE_SCRIPT = "scripts/vehicles/scripts/vehicles/ford_f350_ambu.txt"
local AMBULANCE_POD_SCRIPT = "scripts/vehicles/prisoner_pod_ambu.txt"
local HOSPITAL_BED_SCRIPT = "scripts/vehicles/prisoner_pod_non_interactive.txt"
local timerSimple = timer.Simple
local timerCreate = timer.Create
local vec3 = Vector
local ang = Angle

addEventListener("KeyPress", "VBHOOK::RagdollUse", function(pl, key)

  local target = pl:GetEyeTrace().Entity
  if pl:Team() == TEAM_MEDIC and key == IN_USE and isvalid(target) and target:GetClass() == "prop_ragdoll" and not (pl:EyePos():DistToSqr(target:GetPos()) > 120 * 120) and target.CanBeSentToAmbulance then
    local veh
    local deadPl = target:GetCreator()
    for k, v in ipairs(findInSphere(deadPl:GetPos(), 750)) do
      if v:GetNWString("VB::NW::Car::Owner") == pl:SteamID() then
        for u, w in ipairs(v:GetChildren()) do
          if w:GetKeyValues()["vehiclescript"] == AMBULANCE_POD_SCRIPT then
            veh = w
          end
        end
      end
    end
    if veh ~= nil then
      deadPl:Spawn()
      deadPl:SetHealth(20)
      deadPl:EnterVehicle(veh)
      timer.Create("VBTIMER::AmbulanceTimer::" .. deadPl:SteamID64(), 120, 1, function()
        -- if the timer deletion doesn't work check if the player is recovering..
        if deadPl.Recovery then return false end
        deadPl:SetDTUnconscious(false)
        deadPl:ExitVehicle()
        deadPl:Spawn()
        notify("Votre sauvetage a échoué, vous êtes décédé.", deadPl)
        notify("Vous avez échoué, la victime est morte car vous avez été trop lent.", pl)
        deadPl:UpdateMoney(450, "sub")
        timer.Destroy("VBTIMER::AmbulanceTimer::" .. deadPl:SteamID64())
      end)
    else
      notify("Vous devez rapprocher votre ambulance pour y placer votre victime", pl)          
    end
  end

end)

addEventListener("CanPlayerEnterVehicle", "VBHOOK::EnterNonInteractiveVehicle", function(pl, veh, role)

  if isvalid(veh:GetParent()) and veh:GetKeyValues()["vehiclescript"] == AMBULANCE_POD_SCRIPT then
    if pl:GetDTUnconscious() then return true end
    return false
  end

  if isvalid(veh) and veh:GetKeyValues()["vehiclescript"] == HOSPITAL_BED_SCRIPT and pl.Recovery then
    return true
  end

end)

addEventListener("CanExitVehicle", "VBHOOK::ExitNonInteractiveVehicle", function(veh, pl)

  if isvalid(veh:GetParent()) and veh:GetKeyValues()["vehiclescript"] == AMBULANCE_POD_SCRIPT then
    if not pl:GetDTUnconscious() then return true end
    return false
  end

  if isvalid(veh) and veh:GetKeyValues()["vehiclescript"] == HOSPITAL_BED_SCRIPT then
    if pl.Recovery then 
      return false
    end
    return true
  end

end)

local hospitalSpawnPoints = {
  { vec3(-10252, 9404, 72), ang(0, 0, 0) }
}

local function pickFirstBedAvailable()

  for k,v in ipairs(findByClass("prop_vehicle_prisoner_pod")) do
    if v:GetKeyValues()["vehiclescript"] == HOSPITAL_BED_SCRIPT and not isvalid(v:GetDriver()) then
      return v
    end
  end

end

addEventListener("PlayerLeaveVehicle", "VBHOOK::CheckAmbulance", function(pl, veh)

  if not veh:GetKeyValues()["vehiclescript"] == AMBULANCE_SCRIPT then return false end
  if pl:Team() ~= TEAM_MEDIC then return false end

  local pod
  for k, v in ipairs(veh:GetChildren()) do
    if v:GetKeyValues()["vehiclescript"] == AMBULANCE_POD_SCRIPT then
      pod = v
      break
    end
  end

  if not isvalid(pod) or not isvalid(pod:GetDriver()) then return false end
  local playerToRevive = pod:GetDriver()
  
  if pl:GetPos():WithinAABox(vec3(-12069, 8333, 355), vec3(-8476, 9866, 64)) then
    timer.Destroy("VBTIMER::AmbulanceTimer::" .. playerToRevive:SteamID64())
    playerToRevive:SetDTUnconscious(false)
    playerToRevive:ExitVehicle()
    playerToRevive.Recovery = true
    playerToRevive:EnterVehicle(pickFirstBedAvailable())
    notify(fmt("Vous venez de sauvez %s !", playerToRevive:GetCompleteName()), pl)
    notify(fmt("Vous avez été sauvé par %s !", pl:GetCompleteName()), playerToRevive)
    notify("Vous êtes maintenant en convalescence, vous pourrez sortir quand vous aurez récupéré à 100%.", playerToRevive)
    playerToRevive:SetHealth(50)
    playerToRevive:HealOverTime(50, 50)
    timer.Simple(50, function() 
      playerToRevive.Recovery = false
      playerToRevive:ExitVehicle()
      notify("Vous avez récupéré, vous pouvez désormais partir de la clinique.", playerToRevive)
      playerToRevive:Spawn()
      playerToRevive:SetPos(hospitalSpawnPoints[1][1])
      playerToRevive:SetAngles(hospitalSpawnPoints[1][2])
    end)

  end

end)