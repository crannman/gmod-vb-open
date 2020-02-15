local addNetworkString = util.AddNetworkString
local recv = net.Receive
local rdstr = net.ReadString
local ipairs = ipairs
local isvalid = IsValid
local fmt = string.format

addNetworkString("VBNET::Jobs::Police::Central::SearchPlayerVehiclesInDB")
addNetworkString("VBNET::Jobs::Police::Central::SearchByLicense")
addNetworkString("VBNET::Jobs::Police::Central::SendCentralData")
addNetworkString("VBNET::Jobs::Police::Central::GetDeployedVehicles")
addNetworkString("VBNET::Jobs::Police::Central::SendDeployedVehicles")
addNetworkString("VBNET::Jobs::Police::Central::GetPrisonData")
addNetworkString("VBNET::Jobs::Police::Central::SendPrisonData")
addNetworkString("VBNET::Jobs::Police::Central::UnarrestPlayer")
addNetworkString("VBNET::Jobs::Police::Central::SetSWAT")
addNetworkString("VBNET::Jobs::Police::Central::Kick")

recv("VBNET::Jobs::Police::Central::SetSWAT", function(len, pl)

  local cop = GetPlayerByName(rdstr())
  if IsValid(cop) and cop:GetJob().Police then
    
    VBJOB.SetJob(cop, Either(cop:Team() == TEAM_SWAT, TEAM_COP, TEAM_SWAT))
  end

end)

recv("VBNET::Jobs::Police::Central::Kick", function(len, pl)

  local cop = GetPlayerByName(rdstr())
  if IsValid(cop) and cop:GetJob().Police then
    VBJOB.SetJob(cop, TEAM_CITIZEN)
  end
  
end)


recv("VBNET::Jobs::Police::Central::UnarrestPlayer", function(len, pl)
  if not pl:GetJob().Police then return false end
  local arrested = GetPlayerByName(rdstr())
  if isvalid(arrested) and arrested:IsArrested() and VBRP_Arrested_Players[arrested:SteamID()] then
    local playerWhoArrested = GetPlayerBySteamID(VBRP_Arrested_Players[arrested:SteamID()]["ArrestedBy"])
    if pl == playerWhoArrested or not isvalid(playerWhoArrested) or not playerWhoArrested:GetJob().Police then
      if timer.Exists("VBTIMER::JAIL_TIME::" .. arrested:SteamID64()) then
        timer.Remove("VBTIMER::JAIL_TIME::" .. arrested:SteamID64())
      end
      for k, v in ipairs(VBRP_Jails) do
        if GetPlayerInCellFromMapId(v.Door) == arrested then
          ents.GetMapCreatedEntity(v.Door):Fire("unlock")
          break
        end
      end
      NotifyPlayer(fmt("Vous avez été libéré par %s", pl:GetCompleteName()), arrested)
      NotifyPlayer(fmt("Vous avez libéré %s", arrested:GetCompleteName()), pl)
      VBRP_Arrested_Players[arrested:SteamID()] = nil
      arrested:SetPos(Vector(-6913, -9200, -431))
      arrested:SetAngles(Angle(0, 90, 0))
      arrested:SetDTArrested(false)
      arrested:SetDTStatus("")
      arrested:MakeLoadout()
      arrested:SetRunSpeed(320)
      arrested.IsInJail = false
    else
      NotifyPlayer(fmt("Vous ne pouvez pas libérer %s car le policier qui a arrêté cette personne est encore en service", arrested:GetCompleteName()), pl)
    end
  end
end)

recv("VBNET::Jobs::Police::Central::GetPrisonData", function(len, pl)

  if not VBJOB.GetJob(pl).Police then return false end
  local payload = {}
  for k,v in ipairs(VBRP_Jails) do
    local arrested = GetPlayerInCellFromMapId(v.Door)
    if arrested == nil then continue end
    if arrested and timer.Exists("VBTIMER::JAIL_TIME::" .. arrested:SteamID64()) then
      table.insert(payload, {
        Name = arrested:GetCompleteName(),
        StartTime = VBRP_Arrested_Players[arrested:SteamID()]["StartTime"],
        EndTime = VBRP_Arrested_Players[arrested:SteamID()]["EndTime"],
        ArrestedBy = VBRP_Arrested_Players[arrested:SteamID()]["ArrestedBy"]
      })
    end
  end
  net.Start("VBNET::Jobs::Police::Central::SendPrisonData")
  net.WriteTable(payload)
  net.Send(pl)

end)

recv("VBNET::Jobs::Police::Central::GetDeployedVehicles", function(len, pl)

  if not VBJOB.GetJob(pl).Police then return false end

  local payload = {}
  for k,v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
    if v:GetKeyValues()["VehicleScript"] == "scripts/vehicles/mas_ghibli_pol.txt" then
      local license
      for i,j in ipairs(v:GetChildren()) do
        if j:GetClass() == "vbrp_license_plate" then 
          license = j:GetDTLicense() 
          break
        end
      end
      payload[k] = {
        Owner = v:GetEntOwner(),
        License = license
      }
    end
  end
  net.Start("VBNET::Jobs::Police::Central::SendDeployedVehicles")
  net.WriteTable(payload)
  net.Send(pl)

end)

recv("VBNET::Jobs::Police::Central::SearchByLicense", function(len, pl)

  if not VBJOB.GetJob(pl).Police then return false end
  
  local license = rdstr()
  local data = PreparedStatements.Police.Central.GetVehiclesByLicense(license)
  if data == nil then
    net.Start("VBNET::Jobs::Police::Central::SendCentralData") 
    net.WriteTable({})
    net.Send(pl)
    return false
  end

  local tbl = {}
  for k, v in ipairs(data) do
    tbl[k] = {
      PName = v["first_name"] .. " " .. v["last_name"],
      Name = VehTable[v.identifier]["Name"],
      License = v["license_plate"],
      Color = HexToColorRGB(v["color"])
    }
  end
  net.Start("VBNET::Jobs::Police::Central::SendCentralData")
  net.WriteTable(tbl)
  net.Send(pl)

end)

recv("VBNET::Jobs::Police::Central::SearchPlayerVehiclesInDB", function(len, pl)

  if not VBJOB.GetJob(pl).Police then return false end

  local name = rdstr():Split(" ")
  
  if not name[2] or not name[1] then
    net.Start("VBNET::Jobs::Police::Central::SendCentralData") 
    net.WriteTable({})
    net.Send(pl)
    return false
  end

  local data = PreparedStatements.Police.Central.GetPlayerSteamIDFromCompleteName(name[1], name[2])[1]
  if data == nil then 
    net.Start("VBNET::Jobs::Police::Central::SendCentralData") 
    net.WriteTable({})
    net.Send(pl)
    return false
  end

  local steamId = data["steam_id"]

  local data = PreparedStatements.Police.Central.GetVehicles(steamId)

  if data == nil then
    net.Start("VBNET::Jobs::Police::Central::SendCentralData")
    net.WriteTable({})
    net.Send(pl)
    return false
  end

  local tbl = {}
  for k, v in ipairs(data) do
    tbl[k] = {
      PName = pl:GetCompleteName(),
      Name = VehTable[v.identifier]["Name"],
      License = v["license_plate"],
      Color = HexToColorRGB(v["color"])
    }
  end
  net.Start("VBNET::Jobs::Police::Central::SendCentralData")
  net.WriteTable(tbl)
  net.Send(pl)

end)
