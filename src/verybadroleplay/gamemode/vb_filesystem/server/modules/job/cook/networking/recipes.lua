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

addNetworkString("VBNET::Jobs::Cook::Recipes::GetRecipes")
addNetworkString("VBNET::Jobs::Cook::Recipes::BeginRecipe")
addNetworkString("VBNET::Jobs::Cook::Recipes::UpdateStoveRecipe")
local validEntity = {
  ["vbrp_stove"] = true,
  ["vbrp_frying_pan"] = true,
  ["vbrp_stove"] = true,
}

function OpenRecipesMenu(ent, pl)

  if pl:Team() == TEAM_COOK and isvalid(ent) and validEntity[ent:GetClass()] then
    local foodTable = VBRP_Cooking:GetFoodTable()
    local payload = {}
    for k, food in ipairs(foodTable) do
      if food["AvailableIn"][ent:GetClass()] then
        table.insert(payload, {
          Identifier = food.Identifier,
          PrettyName = food.PrettyName,
          Recipe = food.Recipe,
          RecipeString = VBRP_Cooking:GetIngredientsToString(food.Identifier)
        })
      end
    end
    start("VBNET::Jobs::Cook::Recipes::GetRecipes")
    writetbl(payload)
    writeent(ent)
    send(pl)
  end

end

recv("VBNET::Jobs::Cook::Recipes::BeginRecipe", function(len, pl)

  local identifier = rdstr()
  local ent = rdent()
  if pl:Team() ~= TEAM_COOK or not isvalid(ent) or not validEntity[ent:GetClass()] then return false end

  local food = VBRP_Cooking:GetFood(identifier)
  if not food then return false end
  ent:UpdateActiveRecipe(food, pl)

end)