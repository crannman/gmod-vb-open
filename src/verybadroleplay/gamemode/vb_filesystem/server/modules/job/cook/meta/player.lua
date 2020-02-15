local VBRP_Player = FindMetaTable("Player")

function VBRP_Player:FlushFoodIngredientsInventory()

  VBRP_Cooking.Inventories[self:SteamID64()] = nil
  self:SetDTFoodWeight(0)
  
end