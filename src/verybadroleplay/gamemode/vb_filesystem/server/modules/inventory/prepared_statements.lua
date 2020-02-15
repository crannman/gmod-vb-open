PreparedStatements.Inventory = {}

function PreparedStatements.Inventory.PlayerHasItem(identifier, steamId)

  local stmt = [[
    SELECT COUNT(inventory_id) FROM inventory 
    INNER JOIN item ON inventory.item_id = item.item_id
    WHERE steam_id = ? AND amount > 0 AND item.name = ?
  ]]
  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, steamId)
  preparedQuery:setString(2, identifier)
  preparedQuery:start()
  preparedQuery:wait()

  local data = preparedQuery:getData()
  if data[1]["COUNT(inventory_id)"] > 0 then return true end
  return false
end

function PreparedStatements.Inventory.FetchInventory(steamId)

  local stmt = [[
    SELECT inventory.item_id, inventory.amount, item.name
    FROM inventory 
    INNER JOIN item ON item.item_id = inventory.item_id 
    WHERE inventory.steam_id = ?
  ]]

  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, steamId)
  preparedQuery:start()
  preparedQuery:wait()

  return preparedQuery:getData()

end

function PreparedStatements.Inventory.RemoveItem(steamId, identifier, quantity)

  local stmt = [[
    UPDATE inventory
    INNER JOIN item ON item.item_id = inventory.item_id
    SET inventory.amount = inventory.amount - ?
    WHERE item.name = ? AND inventory.steam_id = ?
  ]]

  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setNumber(1, quantity)
  preparedQuery:setString(2, identifier)
  preparedQuery:setString(3, steamId)
  preparedQuery:start()

end

function PreparedStatements.Inventory.AddItem(steamId, identifier, quantity)

  local stmt = [[
    INSERT INTO inventory(steam_id, item_id, amount)
    SELECT ?, item_id, ? FROM item
    WHERE item.name = ?
    ON DUPLICATE KEY UPDATE
    inventory.amount = inventory.amount + ?
  ]]

  local preparedQuery = VBSQL:Prepare(stmt)
  preparedQuery:setString(1, steamId)
  preparedQuery:setNumber(2, quantity)
  preparedQuery:setString(3, identifier)
  preparedQuery:setNumber(4, quantity)
  preparedQuery:start()
  
end