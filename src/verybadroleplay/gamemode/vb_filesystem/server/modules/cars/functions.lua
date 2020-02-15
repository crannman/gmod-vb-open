function GetVehicleModificationPrice(identifier, list)
  local sum = 0
  for k,v in pairs(list) do
    if k == "MF::CHANGE_COLOR" then
      sum = sum + 1000
    end

    if k == "MF::CHANGE_LICENSE_PLATE" then
      sum = sum + 3000
    end

    if k == "MF::CHANGE_BUMPERF" then
      sum = sum + VehTable[identifier]["Bodygroups"]["Bumperf"]["Submodels"][v]["Price"]
    end

    if k == "MF::CHANGE_SPOILER" then
      sum = sum + VehTable[identifier]["Bodygroups"]["Wing"]["Submodels"][v]["Price"]
    end

    if k == "MF::CHANGE_BUMPERR" then
      sum = sum + VehTable[identifier]["Bodygroups"]["Bumperr"]["Submodels"][v]["Price"]
    end
    
    if k == "MF::CHANGE_HOOD" then
      sum = sum + VehTable[identifier]["Bodygroups"]["Hood"]["Submodels"][v]["Price"]
    end

    if k == "MF::CHANGE_SKIRT" then
      sum = sum + VehTable[identifier]["Bodygroups"]["Skirt"]["Submodels"][v]["Price"]
    end

    if k == "MF::CHANGE_WHEEL" then
      sum = sum + VehTable[identifier]["Bodygroups"]["Wheel"]["Submodels"][v]["Price"]
    end

  end
  return sum
end

function MakeBodyGroupsIdentifierFromVehicle(veh)

  local tbl = veh:GetBodyGroups()
  local identifier = ""
  for k,v in ipairs(tbl) do
    identifier = identifier .. veh:GetBodygroup(k - 1)
  end
  return identifier
end

function MakeBodyGroupsIdentifier(identifier, modificationsList, baseIdentifier)

  baseIdentifier = baseIdentifier or VehTable[identifier]["DefaultBodyGroups"]
  for k,v in pairs(modificationsList) do
    if k == "MF::CHANGE_BUMPERF" then
      baseIdentifier = baseIdentifier:SetChar(VehTable[identifier]["Bodygroups"]["Bumperf"]["Id"] + 1, v)
    end
    if k == "MF::CHANGE_SPOILER" then
      baseIdentifier = baseIdentifier:SetChar(VehTable[identifier]["Bodygroups"]["Wing"]["Id"] + 1, v)
    end
    if k == "MF::CHANGE_BUMPERR" then
      baseIdentifier = baseIdentifier:SetChar(VehTable[identifier]["Bodygroups"]["Bumperr"]["Id"] + 1, v)
    end
    if k == "MF::CHANGE_WHEEL" then
      baseIdentifier = baseIdentifier:SetChar(VehTable[identifier]["Bodygroups"]["Wheel"]["Id"] + 1, v)
    end
    if k == "MF::CHANGE_HOOD" then
      baseIdentifier = baseIdentifier:SetChar(VehTable[identifier]["Bodygroups"]["Hood"]["Id"] + 1, v)
    end
    if k == "MF::CHANGE_SKIRT" then
      baseIdentifier = baseIdentifier:SetChar(VehTable[identifier]["Bodygroups"]["Skirt"]["Id"] + 1, v)
    end
  end
  return baseIdentifier
end

function UpdateCarModifications(playerSteamId, vehIdentifier, veh, modificationsList)
  if modificationsList["MF::CHANGE_COLOR"] then
    local hexColor = ColorRGBToHex(modificationsList["MF::CHANGE_COLOR"])
    veh:SetColor(modificationsList["MF::CHANGE_COLOR"])
    PreparedStatements.Cars.ModifyColor(vehIdentifier, playerSteamId, hexColor)
  end

  if modificationsList["MF::CHANGE_LICENSE_PLATE"] then
    local licensePlate = modificationsList["MF::CHANGE_LICENSE_PLATE"]
    for k,v in ipairs(veh:GetChildren()) do
      if v:GetClass() == "vbrp_license_plate" then v:SetDTLicense(licensePlate) end
    end
    PreparedStatements.Cars.ModifyLicensePlate(vehIdentifier, playerSteamId, licensePlate)
  end

  if modificationsList["MF::CHANGE_BUMPERF"] or
    modificationsList["MF::CHANGE_SPOILER"]  or
    modificationsList["MF::CHANGE_BUMPERR"]  or
    modificationsList["MF::CHANGE_WHEEL"]    or
    modificationsList["MF::CHANGE_HOOD"]     or
    modificationsList["MF::CHANGE_SKIRT"]    then
    local bodygroups = MakeBodyGroupsIdentifier(vehIdentifier, modificationsList, MakeBodyGroupsIdentifierFromVehicle(veh))
    veh:SetBodyGroups(bodygroups)
    PreparedStatements.Cars.ModifyBodyGroups(vehIdentifier, playerSteamId, bodygroups)
  end
end