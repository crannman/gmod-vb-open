VBRP_Cooking = VBRP_Cooking or {}
VBRP_Cooking.__index = VBRP_Cooking
VBRP_Cooking.Inventories = VBRP_Cooking.Inventories or {}
VBRP_Cooking.FailedEnergy = 5

VBRP_Cooking.Food = {
  {
    Identifier = "shepherds_pie",
    PrettyName = "Hachis parmentiers",
    AvailableIn = {["vbrp_stove"] = true},
    Duration = 15,
    Expiration = 900,
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    IsIngredient = false,
    Energy = 75,
    Recipe = {
      {Quantity = 2, What = "beef"},
      {Quantity = 4, What = "potato"}
    }
  },
  {
    Identifier = "french_fries",
    PrettyName = "Frites",
    AvailableIn = {["vbrp_frying_pan"] = true},
    Duration = 15,
    Expiration = 450,
    IsIngredient = true,
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Energy = 15,
    Recipe = {
      {Quantity = 4, What = "potato"}
    }
  }
}

VBRP_Cooking.CookingStep = {
  "rare",
  "medium",
  "well-done"
}

VBRP_Cooking.Ingredients = {
  ["mushrooms"] = {
    PrettyName = "Mushrooms",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Misc"
  },
  ["cabbage"] = {
    PrettyName = "Cabbage",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Vegetable"
  },
  ["avocado"] = {
    PrettyName = "Avocado",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Vegetable"
  },
  ["eggs"] = {
    PrettyName = "Eggs",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Misc"
  },
  ["vegetable_oil"] = {
    PrettyName = "Vegetable Oil",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Misc"
  },
  ["french_fries"] = {
    PrettyName = "French fries",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = false,
    Category = "Vegetable"
  },
  ["beans"] = {
    PrettyName = "Beans",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Vegetable"
  },
  ["rice"] = {
    PrettyName = "Rice",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Misc"
  },
  ["salmon"] = {
    PrettyName = "Salmon",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Meat"
  },
  ["garlic"] = {
    PrettyName = "Garlic",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Vegetable"
  },
  ["onion"] = {
    PrettyName = "Onion",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Vegetable"
  },
  ["potato"] = {
    PrettyName = "Potato",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Vegetable"
  },
  ["tomato"] = {
    PrettyName = "Tomato",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Vegetable"
  },
  ["flour"] = {
    PrettyName = "Flour",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Misc"
  },
  ["horse"] = {
    PrettyName = "Horse",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Meat"
  },
  ["beef"] = {
    PrettyName = "Beef",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Meat"
  },
  ["pork"] = {
    PrettyName = "Pork",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Meat"
  },
  ["chicken"] = {
    PrettyName = "Chicken",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Meat"
  },
  ["sheep"] = {
    PrettyName = "Sheep",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Meat"
  },
  ["milk"] = {
    PrettyName = "Milk",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Dairy"
  },
  ["swiss_cheese"] = {
    PrettyName = "Swiss cheese",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Dairy"
  },
  ["blue_cheese"] = {
    PrettyName = "Blue cheese",
    Model = Model("models/props_junk/garbage_takeoutcarton001a.mdl"),
    Price = 10,
    Weight = 1.00,
    Buyable = true,
    Category = "Dairy"
  }
}

function VBRP_Cooking:GetFoodTable()
  return self.Food
end

function VBRP_Cooking:GetFood(identifier)
  for k, v in ipairs(self.Food) do
    if v.Identifier == identifier then
      return v
    end
  end
end

function VBRP_Cooking:GetRecipe(recipe)
  for k, v in ipairs(self.Food) do
    if v.Identifier == recipe then
      return v.Recipe
    end
  end
end

function VBRP_Cooking:GetFoodEnergy()
  for k, v in ipairs(self.Food) do
    if v.Identifier == identifier then
      return v.Energy
    end
  end
end

function VBRP_Cooking:GetIngredientsToString(identifier)
  local str = ""
  local recipe = self:GetRecipe(identifier)
  for k, v in ipairs(recipe) do
    str =
      str .. string.format("%s (%d)", self.Ingredients[v.What].PrettyName, v.Quantity) .. Either(k ~= #recipe, ", ", "")
  end
  return str
end

function VBRP_Cooking:GetIngredientsPrettyName(ingredient)
  return self.Ingredients[ingredient].PrettyName
end

function VBRP_Cooking:GetMissingIngredients(recipe, ingredients)
  local recipe = self:GetRecipe(recipe)
  local missing = {}
  for k, ingredient in ipairs(recipe) do
    if ingredient.Quantity ~= ingredient[k] and ingredient.What == ingredients[k].What then
      table.insert(missing, {ingredient.Quantity - ingredients[k].Quantity, ingredients[k].What})
    end
  end
  return missing
end

function VBRP_Cooking:CheckIngredients(recipe, ingredients)
  local recipe = self:GetRecipe(recipe)
  for k, ingredient in ipairs(recipe) do
    if ingredient.Quantity ~= ingredients[k].Quantity then
      return false
    end
  end
  return true
end

function VBRP_Cooking:StoreToInventory(pl, identifier, shouldPay)

  if not pl:Team() == TEAM_COOK then return false end
  if not VBRP_Cooking.Ingredients[identifier] then return false end
  if not VBRP_Cooking.Inventories[pl:SteamID64()] then
    VBRP_Cooking.Inventories[pl:SteamID64()] = {}
  end
  if shouldPay and not pl:CanAfford(VBRP_Cooking.Ingredients[identifier].Price) then return false end
  
  local ingr = VBRP_Cooking.Ingredients[identifier]
  if pl:GetDTFoodWeight() + ingr.Weight > 15 then
    NotifyPlayer("Vous ne pouvez pas acheter cet aliment car vous êtes trop lourd", pl)
    return false
  end

  if shouldPay then
    pl:UpdateMoney(ingr.Price, "sub")
  end

  pl:SetDTFoodWeight(pl:GetDTFoodWeight() + ingr.Weight)
  
  if not VBRP_Cooking.Inventories[pl:SteamID64()][identifier] then
    VBRP_Cooking.Inventories[pl:SteamID64()][identifier] = {
      Quantity = 1,
      Model = ingr.Model,
      Name = ingr.PrettyName,
      Weight = ingr.Weight,
      Category = "COOKING",
    }
  else
    local ingr = VBRP_Cooking.Inventories[pl:SteamID64()][identifier]
    ingr.Quantity = ingr.Quantity + 1 
  end

end