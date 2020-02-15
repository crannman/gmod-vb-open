PreparedStatements.Cars = {}

function PreparedStatements.Cars.RetrieveCarProperties(identifier, steamId)

  local stmt = [[
    SELECT g.car_id, g.player_id, g.license_plate, g.bodygroups, g.color FROM garage AS g
    INNER JOIN car AS c ON g.car_id = c.car_id
    INNER JOIN players AS p ON g.player_id = p.player_id
    WHERE c.identifier = ? AND p.steam_id = ?
  ]]
  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, identifier)
  preparedQuery:setString(2, steamId)
  preparedQuery:start()
  preparedQuery:wait()

  return preparedQuery:getData()
end

-- Refactoring ?
function PreparedStatements.Cars.ModifyColor(identifier, steamId, color)

  local stmt = [[
    UPDATE garage g
    INNER JOIN car c ON c.car_id = g.car_id
    INNER JOIN players p ON g.player_id = p.player_id
    SET g.color = ?
    WHERE c.identifier = ? AND p.steam_id = ?;
  ]]
  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, color)
  preparedQuery:setString(2, identifier)
  preparedQuery:setString(3, steamId)
  preparedQuery:start()
end

function PreparedStatements.Cars.ModifyBodyGroups(identifier, steamId, bodygroups)

    local stmt = [[
    UPDATE garage g
    INNER JOIN car c ON c.car_id = g.car_id
    INNER JOIN players p ON g.player_id = p.player_id
    SET g.bodygroups = ?
    WHERE c.identifier = ? AND p.steam_id = ?;
    ]]
    local preparedQuery = VBSQL:Prepare(stmt)
    preparedQuery:setString(1, bodygroups)
    preparedQuery:setString(2, identifier)
    preparedQuery:setString(3, steamId)
    preparedQuery:start()
end

function PreparedStatements.Cars.ModifyLicensePlate(identifier, steamId, newLicense)

  local stmt = [[
    UPDATE garage g
    INNER JOIN car c ON c.car_id = g.car_id
    INNER JOIN players p ON g.player_id = p.player_id
    SET g.license_plate = ?
    WHERE c.identifier = ? AND p.steam_id = ?;
  ]]
  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, newLicense)
  preparedQuery:setString(2, identifier)
  preparedQuery:setString(3, steamId)
  preparedQuery:start()
end