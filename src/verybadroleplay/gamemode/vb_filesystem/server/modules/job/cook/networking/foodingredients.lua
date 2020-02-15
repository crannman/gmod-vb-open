local addNetworkString = util.AddNetworkString
local isvalid = IsValid
local recv = net.Receive
local writestr = net.WriteString
local writetbl = net.WriteTable
local writeent = net.WriteEntity
local rdent = net.ReadEntity
local rdstr = net.ReadString
local start = net.Start
local send = net.Send

addNetworkString("VBNET::Jobs::Cook::Ingredients::OpenCookShop")
addNetworkString("VBNET::Jobs::Cook::Ingredients::Buy")
addNetworkString("VBNET::Jobs::Cook::Ingredients::Drop")
addNetworkString("VBNET::Jobs::Cook::Ingredients::SendIngredients")

net.Receive("VBNET::Jobs::Cook::Ingredients::Drop", function(len, pl)

  local identifier = rdstr()
  if not pl:Team() == TEAM_COOK then return false end
  if not VBRP_Cooking.Inventories[pl:SteamID64()] or not VBRP_Cooking.Inventories[pl:SteamID64()][identifier] then return false end 
  
  local ingr = VBRP_Cooking.Inventories[pl:SteamID64()][identifier]
  local properties = VBRP_Cooking.Ingredients[identifier]
  pl:SetDTFoodWeight(math.Clamp(pl:GetDTFoodWeight() - ingr.Weight, 0, 15))

  if ingr.Quantity - 1 <= 0 then
    VBRP_Cooking.Inventories[pl:SteamID64()][identifier] = nil
  else
    ingr.Quantity = ingr.Quantity - 1
  end

  local foodingredient = ents.Create("vbrp_foodingredients")
  local obbMaxs = foodingredient:OBBMaxs()
  foodingredient:SetModel(properties.Model)
  foodingredient:SetPos(pl:GetSpawnVector() + Vector(0, 0, obbMaxs.z / 2) )
  foodingredient:Spawn()
  foodingredient:SetDTName(properties.PrettyName)
  foodingredient:SetDTDesc("")
  foodingredient:SetDTOwner(pl:SteamID())
  foodingredient:SetDTIdentifier(identifier)

end)

net.Receive("VBNET::Jobs::Cook::Ingredients::Buy", function(len, pl)

  local identifier = rdstr()

  VBRP_Cooking:StoreToInventory(pl, identifier, true)

end)

net.Receive("VBNET::Jobs::Cook::Ingredients::OpenCookShop", function(len, pl)

  if pl:Team() == TEAM_COOK then

    local payload = {}
    for k,v in pairs(VBRP_Cooking.Ingredients) do
      if v.Buyable then
        v.Identifier = k
        table.insert(payload, v)
      end
    end

    local data = util.Compress(util.TableToJSON(payload))
    local len = data:len()

    net.Start("VBNET::Jobs::Cook::Ingredients::SendIngredients")
    net.WriteUInt(len, 16)
    net.WriteData(data, len)
    net.Send(pl)

  end

end)