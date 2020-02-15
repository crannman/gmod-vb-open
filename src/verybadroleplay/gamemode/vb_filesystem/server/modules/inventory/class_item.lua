--[[-------------------------------------------------------------------------
Class: VBCLASS_ITEM

Properties:
Name, Desc, Model, Health, Category, Owner, Quantity, IsStackable

Methods :
NewItem(), Destroy(), StoreToInventory()
---------------------------------------------------------------------------]]
VBCLASS_ITEM = VBCLASS_ITEM or {}
VBCLASS_ITEM.__index = VBCLASS_ITEM
VBCLASS_ITEM.Items =VBCLASS_ITEM.Items or {}
VBCLASS_ITEM.Identifier = ""
VBCLASS_ITEM.Name = ""
VBCLASS_ITEM.Desc = ""
VBCLASS_ITEM.Model = ""
VBCLASS_ITEM.Health = 0
VBCLASS_ITEM.Category = "base_class_item"
VBCLASS_ITEM.MarketPrice = 0
VBCLASS_ITEM.Owner = nil
VBCLASS_ITEM.Quantity = 0
VBCLASS_ITEM.IsStackable = false
VBCLASS_ITEM.IsBuyableFromFlea = false
VBCLASS_ITEM.Entity = ""
--[[-------------------------------------------------------------------------
Item instantiation
---------------------------------------------------------------------------]]

-- @desc Enregistre un object Item;
-- @args string ItemIdentifier, table Item;
-- @realm Server;
function RegisterItem(identifier, item)
  VBCLASS_ITEM.Items[identifier] = item
  util.PrecacheModel(item.Model)
  VBRP.log("Created and cached object : [" .. item.Name .. "]", "VB-Framework::ItemSystem")
end

-- @desc Récupère un objet Item partir l'attribut 'Entity';
-- @args string classname;
-- @realm Server;
-- @return object Item;
function RetrieveEntityFromClassName(className)
  for _,v in pairs(VBCLASS_ITEM.Items) do
    if v["Entity"] == className then
      return v
    end
  end
  return nil
end

-- @desc Récupère les propriété d'un objet Item;
-- @args string ItemIdentifier;
-- @realm Server;
function VBCLASS_ITEM:GetItemProperties(item)
  return VBCLASS_ITEM.Items[item]
end

-- @desc Détruit un objet;
-- @realm Server;
function VBCLASS_ITEM:Destroy()
  if self.Health <= 0 then
    self:Remove()
  end
end

function LoadItems()
  local weaponsPath = "verybadroleplay/gamemode/vb_filesystem/server/modules/inventory/setup/weapons"
  local entitiesPath = "verybadroleplay/gamemode/vb_filesystem/server/modules/inventory/setup/entities"
  local propsPath = "verybadroleplay/gamemode/vb_filesystem/server/modules/inventory/setup/props"

  local weapons = file.Find(weaponsPath .. "/*.json", "LUA")
  local props = file.Find(propsPath .. "/*.json", "LUA")
  local entities = file.Find(entitiesPath .. "/*.json", "LUA")

  for k, v in pairs(weapons) do
    local tbl = util.JSONToTable(file.Read(weaponsPath .. "/" .. v, "LUA"))
    RegisterItem(tbl.Identifier, tbl)
  end

  for k, v in pairs(props) do
    local tbl = util.JSONToTable(file.Read(propsPath .. "/" .. v, "LUA"))
    RegisterItem(tbl.Identifier, tbl)
  end

  for k, v in pairs(entities) do
    local tbl = util.JSONToTable(file.Read(entitiesPath .. "/" .. v, "LUA"))
    RegisterItem(tbl.Identifier, tbl)
  end

end


function LoadItemsIntoDataBase()
  for _, v in pairs(VBCLASS_ITEM.Items) do
    query = "INSERT IGNORE INTO item(name) VALUES('" .. VBSQL:Escape(v["Identifier"]) .. "');"
    VBSQL:Query(query)
  end
  VBRP.log("Inserted new objects into database.", "VB-Framework::ItemSystem")
end

function RegisterNewItem(type, json)

  local path = ""
  local weaponsPath = "verybadroleplay/gamemode/vb_filesystem/server/modules/inventory/setup/weapons"
  local entitiesPath = "verybadroleplay/gamemode/vb_filesystem/server/modules/inventory/setup/entities"
  local propsPath = "verybadroleplay/gamemode/vb_filesystem/server/modules/inventory/setup/props"
  
  if type == "weapon" then
    path = weaponsPath
  end

  if type == "entity" then
    path = entitiesPath
  end

  if type == "prop" then
    path = propsPath
  end

  path = path .. "/" .. json
  
  local identifier = ""
  local tbl = util.JSONToTable(file.Read(path, "LUA"))
  identifier = tbl.Identifier

  RegisterItem(identifier, tbl)
  VBSQL:Query([[
    INSERT INTO item(name) VALUES(']] .. VBSQL:Escape(identifier) .. [[');
  ]])

end