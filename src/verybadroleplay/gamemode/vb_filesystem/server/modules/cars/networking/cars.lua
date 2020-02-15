local addNetworkString = util.AddNetworkString

addNetworkString("VBNET::Cars::GetVehiclesInfo")
addNetworkString("VBNET::Cars::SendVehiclesInfos")
addNetworkString("VBNET::Cars::GetOwnedVehicles")
addNetworkString("VBNET::Cars::SendOwnedVehicles")
addNetworkString("VBNET::Cars::BuyVehicle")
addNetworkString("VBNET::Cars::SellVehicle")
addNetworkString("VBNET::Cars::SpawnVehicle")
addNetworkString("VBNET::Cars::StoreVehicle")
addNetworkString("VBNET::Cars::ModifyVehicle")
addNetworkString("VBNET::Cars::StartVehicleModification")
addNetworkString("VBNET::Cars::PlayerCanDrawCustomizationMenu")
addNetworkString("VBNET::Cars::Error::CouldNotOpenCustomizationMenu")
addNetworkString("VBNET::Cars::PlayerLeavedVehicleWithinParking")

net.Receive("VBNET::Cars::ModifyVehicle", function(len, pl)

  local vehModel = net.ReadString()
  local vehId = ""
  local steamId = pl:SteamID()
  local modificationsList = net.ReadTable()

  for identifier, properties in pairs(VehTable) do
    if properties.Model == vehModel then 
      vehId = identifier
      break
    end
  end 

  if not table.IsEmpty(modificationsList) then
    for k, v in ipairs(ents.FindInBox(VehCustomizingLocation.Min, VehCustomizingLocation.Max)) do
      if v:GetClass() == "prop_vehicle_jeep" and v:GetNWString("VB::NW::Car::Owner") == pl:SteamID() then
          local price = GetVehicleModificationPrice(vehId, modificationsList)
          if pl:CanAfford(price) then
            pl:UpdateMoney(price, "sub")
            UpdateCarModifications(steamId, vehId, v, modificationsList)
          end
        break
      end
    end      
  end

end)

net.Receive("VBNET::Cars::StartVehicleModification", function(len, pl)
  
  local vehFound = false
  local veh = {}
  for k, v in ipairs(ents.FindInBox(VehCustomizingLocation.Min, VehCustomizingLocation.Max)) do
    if v:GetClass() == "prop_vehicle_jeep" and v:GetNWString("VB::NW::Car::Owner") == pl:SteamID() then
      vehFound = true
      veh = v
      break
    end
  end
  
  if vehFound and veh then 
    local vehBodyGroups = {}
    for k,v in pairs(VehTable) do
      if VehTable[k]["Model"] == veh:GetModel() then
        vehBodyGroups = VehTable[k]["Bodygroups"]
        break
      end
    end
    net.Start("VBNET::Cars::PlayerCanDrawCustomizationMenu")
    net.WriteTable(veh:GetColor())
    net.WriteString(veh:GetModel())
    net.WriteTable(vehBodyGroups)
    net.WriteString(MakeBodyGroupsIdentifierFromVehicle(veh))
    net.Send(pl)
  else
    net.Start("VBNET::Cars::Error::CouldNotOpenCustomizationMenu")
    net.Send(pl)
  end

end)

net.Receive("VBNET::Cars::GetVehiclesInfo", function(len , pl)

  net.Start("VBNET::Cars::SendVehiclesInfos")
  net.WriteTable(VehTable)
  net.Send(pl)

end)

net.Receive("VBNET::Cars::BuyVehicle", function(len, pl) 

  local identifier = net.ReadString()
  local steamId = pl:SteamID()
  local color = ColorRGBToHex(net.ReadTable())
  local veh = Either(VehTable[identifier], VehTable[identifier], nil)
  if not veh then return false end
  if pl:CanAfford(veh.Price) then
    pl:UpdateMoney(veh.Price, "sub")
    VBSQL:Query([[
      SET @CAR_ID = (SELECT car_id FROM car WHERE car.identifier = ']] .. VBSQL:Escape(identifier) .. [[');
      SET @PLAYER_ID = (SELECT player_id FROM players WHERE players.steam_id = ']] .. VBSQL:Escape(steamId) .. [[');
      INSERT into garage(player_id, car_id, color, bodygroups) 
      VALUES(@PLAYER_ID, @CAR_ID, ']] .. VBSQL:Escape(color) .. [[', ']] .. VBSQL:Escape(veh["DefaultBodyGroups"]) .. [[');
    ]])
  end

end)

net.Receive("VBNET::Cars::GetOwnedVehicles", function(len, pl)

  local steamId = pl:SteamID()
  local query = VBSQL:Query([[
    SELECT car.identifier, garage.color, garage.bodygroups
    FROM car, garage 
    LEFT JOIN players ON players.player_id = garage.player_id 
    WHERE players.steam_id = ']] .. VBSQL:Escape(steamId) ..[[' AND car.car_id = garage.car_id;
  ]])
  query:wait()
  local vehToSend = {}
  for k,v in ipairs(query:getData()) do
    vehToSend[k] = {
      Name = VehTable[v.identifier]["Name"],
      Model = VehTable[v.identifier]["Model"],
      Color = HexToColorRGB(v.color),
      Bodygroups = v.bodygroups
    }
  end
  net.Start("VBNET::Cars::SendOwnedVehicles")
  net.WriteTable(vehToSend)
  net.Send(pl)

end)

net.Receive("VBNET::Cars::StoreVehicle", function(len, pl)

  for k,v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
    if v:GetNWString("VB::NW::Car::Owner") == pl:SteamID() then
      v:Remove()
    end
  end

end) 

net.Receive("VBNET::Cars::SpawnVehicle", function(len, pl)

  for k, v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
    if v:GetNWString("VB::NW::Car::Owner") == pl:SteamID() then
      v:Remove()
    end
  end

  local steamId = pl:SteamID()
  local vehName = net.ReadString()
  local location = Either(pl:IsNearToNPC(RetrieveNPCFromName("Calvin Benson")), 0, 1)
  local vehColor = net.ReadColor()
  local vehBodyGroups = net.ReadString()
  local class = ""
  for k, v in pairs(VehTable) do
    if v.Name == vehName then
      class = k
    end  
  end
  
  local licensePlate = PreparedStatements.Cars.RetrieveCarProperties(class, steamId)[1]['license_plate']

  local spawnIndex = 0
  for k,v in ipairs(VehSpawnPoints[Either(location == 0, "Garage", "CarDealer")]) do
    local min, max = GetWorldBoxCornerVectors(v[1], Vector(-128,-64, 0), Vector(128, 64, 128), v[2])
    if #ents.FindInBox(min, max) > 0 then continue end
    if #ents.FindInBox(min, max) == 0 then
      spawnIndex = k
      break
    end
  end

  local car = ents.Create("prop_vehicle_jeep")
  car:SetPos(VehSpawnPoints[Either(location == 0, "Garage", "CarDealer")][spawnIndex][1])
  car:SetAngles(Either(location == 0, Angle(0, 180, 0), Angle(0, -20, 0)))
  car:SetModel(VehTable[class]["Model"])
  car:SetKeyValue("vehiclescript", VehTable[class]["Script"])
  car:SetColor(vehColor)
  car:Spawn()
  -- Make sure to reset every bodygroups before modifying them
  car:SetBodyGroups(VehTable[class]["DefaultBodyGroups"])
  car:SetBodyGroups(vehBodyGroups)
  car:SetNWString("VB::NW::Car::Owner", pl:SteamID())

  local license = ents.Create("vbrp_license_plate")
  license:SetParent(car)
  license:SetPos(util.LocalToWorld(car, VehTable[class]["LicensePos"]))
  license:SetDTLicense(licensePlate)
  license:Spawn()

  local trunk = ents.Create("vbrp_vehicle_trunk")
  trunk:SetParent(car)
  trunk:SetPos(util.LocalToWorld(car, VehTable[class]["TrunkPos"]))
  trunk:SetAngles(car:LocalToWorldAngles(Angle(0,180,0)))
  trunk:Spawn()
  trunk.TrunkLimit = VehTable[class]["TrunkLimit"]

end)