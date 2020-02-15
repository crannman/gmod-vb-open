
local fmt = string.format

net.Receive("VBNET::Jobs::Cook::Recipes::GetRecipes", function(len, pl)
  
  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::Cooking::Recipes")
  local data = net.ReadTable()
  local ent = net.ReadEntity()
  OpenRecipesMenu(data, ent)

end)


function OpenRecipesMenu(data, ent)
  if LocalPlayer():Team() ~= TEAM_COOK then return false end
  
  local chosenRecipe = ""

  local window = CreateWindowFrame()
  window:SetSize(500, 200)
  window:Center()
  window:SetTitle("cook_recipes_menu_title")
  window:ShowCloseButton(true)
  window:MakePopup()

  local buttonConfirm = CreateButtonAlt(window)
  buttonConfirm:SetPos(5, window:GetTall() - 35)
  buttonConfirm:SetSize(window:GetWide() - 10, 25)
  buttonConfirm:SetText("Confirmer la recette choisie (Aucune recette)")

  local listView = CreateListView(window)
  listView:SetSize(window:GetWide() - 10, window:GetTall() - 70)
  listView:SetPos(5, 30)
  listView:AddColumn("cook_recipes_name")
  listView:AddColumn("cook_required_ingredients")
  for k, v in ipairs(data) do
    local line = listView:AddLine(v.PrettyName, v.RecipeString)
    line.DataIndex = k
  end
  function listView:OnRowSelected(rowId, row)
    local food = data[row.DataIndex]
    chosenRecipe = food.Identifier
    buttonConfirm:SetText(fmt("Confirmer la recette choisie (%s)", food.PrettyName))
  end
  listView:RefreshPaint()
  function buttonConfirm:DoClick()
    if chosenRecipe ~= "" then
      print("true")
      net.Start("VBNET::Jobs::Cook::Recipes::BeginRecipe")
      net.WriteString(chosenRecipe)
      net.WriteEntity(ent)
      net.SendToServer()
    end
  end

end