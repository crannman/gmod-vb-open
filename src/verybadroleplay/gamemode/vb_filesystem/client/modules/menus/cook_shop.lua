net.Receive("VBNET::Jobs::Cook::Ingredients::SendIngredients", function(len, pl)

  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::GroceryStore")
  local length = net.ReadUInt(16)
  local data = util.Decompress(net.ReadData(length))
  OpenCookShop(util.JSONToTable(data))

end)


function OpenCookShop(payload)
  if LocalPlayer():Team() ~= TEAM_COOK then return false end

  local window = VBVGUI:Create("Window")
  window:SetSize(690, 400)
  window:Center()
  window:SetTitle("cook_shop_title")
  window:ShowCloseButton(true)
  window:MakePopup()

  local categories = VBVGUI:Create("PropertySheet", window)

  local vegetables = VBVGUI:Create("ScrollableGridLayout", window)
  categories:AddSheet("Fruits et légumes", vegetables.ScrollPanel)

  local meat = VBVGUI:Create("ScrollableGridLayout", window)
  categories:AddSheet("Viande", meat.ScrollPanel)
  
  local dairy = VBVGUI:Create("ScrollableGridLayout", window)
  categories:AddSheet("Produits laitiers", dairy.ScrollPanel)

  local misc = VBVGUI:Create("ScrollableGridLayout", window)
  categories:AddSheet("Divers", misc.ScrollPanel)

  for k,v in ipairs(payload) do

    local item = VBVGUI:Create("ShopModel")
    item:SetSize(80, 80)
    item:SetModel(v.Model)
    item:SetPrice(removedecimals(v.Price))
    item:SetName(v.PrettyName)
    item.Identifier = v.Identifier
    item:SetDescription(string.format("Poids %.2f kg", v.Weight))
    function item:DoClick()
      local menu = DermaMenu(self)
      local btn = menu:AddOption(string.format("Acheter un(e) %s", self:GetName():lower()), function()
        if LocalPlayer():CanAfford(item:GetPrice()) then
          net.Start("VBNET::Jobs::Cook::Ingredients::Buy")
          net.WriteString(item.Identifier)
          net.SendToServer()
        else
          ClientsideNotify("Vous n'avez pas assez d'argent")
        end
      end)
      menu:Open()
    end

    if v.Category == "Vegetable" then
      vegetables:Add(item)
    elseif v.Category == "Meat" then
      meat:Add(item)
    elseif v.Category == "Dairy" then
      dairy:Add(item)
    else
      misc:Add(item)
    end

  end

end