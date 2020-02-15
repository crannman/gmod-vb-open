local addNetworkString = util.AddNetworkString
local recv = net.Receive
local start = net.Start
local writetbl = net.WriteTable
local send = net.Send
local readentity = net.ReadEntity
local readstr = net.ReadString
local spairs = SortedPairs
local insert = table.insert
local pairs = pairs
local getMapCreatedEntity = ents.GetMapCreatedEntity
addNetworkString("VBNET::Properties::RetrieveBuyableProperties")
addNetworkString("VBNET::Properties::SendPropertiesToPlayer")
addNetworkString("VBNET::Properties::BuyProperty")
addNetworkString("VBNET::Properties::SellProperty")


recv("VBNET::Properties::RetrieveBuyableProperties", function(len, ply)
  local entity = readentity()
  local agentCategory = RealEstateAgencies[entity:GetEntityName()]["Category"]
  local doors = { }
  local temp = { }
  for _, property in spairs(VBRP_Properties) do
    temp = property
    temp["doorsGroup__entityID"] = {}
    if temp["isBuyable"] and temp["Category"] == agentCategory then
      for k, v in pairs(temp["doorsGroup"]) do
        insert(temp["doorsGroup__entityID"], getMapCreatedEntity(v):EntIndex())
      end
      doors[temp] = temp
    end
  end
  start("VBNET::Properties::SendPropertiesToPlayer")
  writetbl(doors)
  send(ply)
end)

recv("VBNET::Properties::BuyProperty", function(len, ply)
  local networkedString = readstr()
  local property

  for _, v in pairs(VBRP_Properties) do
    if v["Name"] == networkedString then
      property = v
    end
  end

  local price = property["Price"]

  if ply:CanAfford(price) then
    ply:UpdateMoney(price, "sub")

    for _, Id in pairs(property["doorsGroup"]) do
      local entity = getMapCreatedEntity(Id)
      entity:SetDoorOwner(ply:SteamID())
    end
  end
end)

recv("VBNET::Properties::SellProperty", function(len, ply)
  local networkedString = readstr()
  local property

  for _, v in pairs(VBRP_Properties) do
    if v["Name"] == networkedString then
      property = v
    end
  end

  local sellMoney = math.floor(property["Price"] / 2)
  ply:UpdateMoney(sellMoney, "add")

  for _, Id in pairs(property["doorsGroup"]) do
    local entity = getMapCreatedEntity(Id)
    entity:SetDoorOwner("world")

    if not entity:IsDoorLocked() then
      entity:Fire("lock")
    end

    if entity:IsDoorOpened() then
      entity:Fire("close", "", 0.1)
    end
  end
end)