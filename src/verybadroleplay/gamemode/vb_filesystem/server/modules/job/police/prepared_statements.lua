PreparedStatements.Police = {}
PreparedStatements.Police.Central = {}

function PreparedStatements.Police.Central.GetPlayerSteamIDFromCompleteName(firstName, lastName)
  
  local stmt = [[
    SELECT players.steam_id FROM players
    WHERE players.first_name = ? AND players.last_name = ?;
  ]]

  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, firstName)
  preparedQuery:setString(2, lastName)
  preparedQuery:start()
  preparedQuery:wait()
  
  return preparedQuery:getData()
end

function PreparedStatements.Police.Central.GetVehicles(steamId)

  local stmt = [[
    SELECT car.identifier, garage.license_plate, garage.color FROM car, garage
    LEFT JOIN players on players.player_id = garage.player_id
    WHERE players.steam_id = ? AND car.car_id = garage.car_id;
  ]]

  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, steamId)
  preparedQuery:start()
  preparedQuery:wait()

  return preparedQuery:getData()
end

function PreparedStatements.Police.Central.GetVehiclesByLicense(license)

  local stmt = [[
    SELECT players.first_name, players.last_name, car.identifier, garage.license_plate, garage.color FROM car, garage
    LEFT JOIN players on players.player_id = garage.player_id
    WHERE garage.license_plate LIKE ? AND car.car_id = garage.car_id;
  ]]

  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, license)
  preparedQuery:start()
  preparedQuery:wait()

  return preparedQuery:getData()
end