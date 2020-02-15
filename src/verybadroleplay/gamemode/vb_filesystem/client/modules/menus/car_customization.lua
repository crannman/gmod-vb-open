local vehColor = COLOR_WHITE
local vehModel = "models/buggy.mdl"
local vehBodyGroups = {}
local vehCurrentBodyGroups = ""
local currentShowedPanel = ""
local modificationList = {}

local translate = Translate

net.Receive("VBNET::Cars::PlayerCanDrawCustomizationMenu", function()

  vehColor = net.ReadTable()
  vehModel = net.ReadString()
  vehBodyGroups = net.ReadTable()
  vehCurrentBodyGroups = net.ReadString()
  DrawCarCustomizationMenu()
end)

net.Receive("VBNET::Cars::Error::CouldNotOpenCustomizationMenu", function()

  MessageBoxShow(translate("global_error"), "Vous devez venir avec votre véhicule !")

end)

function StartCarCustomizationMenu()

  net.Start("VBNET::Cars::StartVehicleModification")
  net.SendToServer()

end

local create = vgui.Create
local function createCategoryButton(label, panToDraw, parent)

  local button = create("DButton", parent)
  button:SetSize(100, 35)
  button:SetFont("VBFONT_DERMANORMAL")
  button:SetTextColor(COLOR_WHITE)
  button:SetText(label)
  button.CurrentlySelected = false
  function button:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_NORMAL_ALT)
    if self:IsHovered() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_HOVER_ALT)
    end
    if self:IsDown() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_CLICKED_ALT)
    end
    draw.RoundedBox(0, 0, self:GetTall() - 3, self:GetWide(), 3, Either(self.CurrentlySelected, COLOR_CUST_ACTIVE_SECTION, COLOR_CUST_INACTIVE_SECTION))
  end
  function button:DoClick()
    
    if currentShowedPanel ~= "" then
      currentShowedPanel:Hide()
      currentShowedPanel = panToDraw
      if panToDraw.HasEventListener then
        panToDraw:OnShow()
      end
      panToDraw:Show()
    else
      currentShowedPanel = panToDraw
    end

    for k, v in ipairs(parent:GetChildren()) do
      if v.CurrentlySelected then v.CurrentlySelected = false end
    end

    self.CurrentlySelected = true

  end
  return button
end

function DrawCarCustomizationMenu()

  local window = CreateWindowFrame()
  window:SetSize(750, 400)
  window:Center()
  window:SetTitle(translate("cd_cust_window_title"))
  window:MakePopup()
  window:SetDraggable(false)

  local panel = create("DPanel", window)
  panel:SetPos(5, 30)
  panel:SetSize(window:GetWide() - 10, window:GetTall() / 2)
  function panel:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_MENU_BACK_ALT1)
  end

  local modelPanel = create("DModelPanel", panel)
  modelPanel:Dock(FILL)
  modelPanel:SetModel(vehModel)
  modelPanel:SetColor(vehColor)
  GenerateView(modelPanel, Vector(1, 1, .5))
  modelPanel.Entity:SetBodyGroups(vehCurrentBodyGroups)
  local mainPanel = create("DPanel", window)
  mainPanel:SetPos(5, window:GetTall() / 2 + 35)
  mainPanel:SetSize(window:GetWide() - 10, window:GetTall() / 2 - 40)
  function mainPanel:Paint() return false end

  local buttonPanel = create("DPanel")
  local windowX, windowY = window:GetPos()
  buttonPanel:SetSize(100, window:GetTall() - 40)
  buttonPanel:SetPos(windowX - buttonPanel:GetWide(), windowY + 30)
  function buttonPanel:Paint() return false end
  function window:OnClose()
    currentShowedPanel = ""
    table.Empty(modificationList)
    buttonPanel:Remove()
  end

  local mixer = create("DColorMixer", mainPanel)
  mixer:Dock(FILL)
  mixer:SetAlphaBar(false)
  function mixer:ValueChanged(newCol)
    if not modificationList["MF::CHANGE_COLOR"] then
      modificationList["MF::CHANGE_COLOR"] = -1
    end
    modificationList["MF::CHANGE_COLOR"] = newCol

    if modelPanel.Entity then
      modelPanel:SetColor(newCol)
    end
  end
  currentShowedPanel = mixer
  
  local licensePanel = create("DPanel", mainPanel)
  licensePanel:Dock(FILL)
  licensePanel:Hide()
  function licensePanel:Paint() return false end
  local licenseEntry = CreateTextEntry(licensePanel, "VBFONT_CHAR_CREATION_MENU")
  licenseEntry:SetSize(265, 25)
  licenseEntry:SetPos((mainPanel:GetWide() - licenseEntry:GetWide()) / 2, (mainPanel:GetTall() - licenseEntry:GetTall()) / 2)
  licenseEntry:SetPlaceholderText("Changer votre plaque d'immatriculation ici")

  local lblLicense = create("DLabel", licensePanel)
  lblLicense:SetSize(265, 30)
  lblLicense:SetPos((mainPanel:GetWide() - lblLicense:GetWide()) / 2, 30)
  lblLicense:SetText("Votre plaque: ")
  lblLicense:SetFont("VBFONT_DERMANORMAL")
  lblLicense:SetTextColor(COLOR_WHITE)

  function licenseEntry:OnTextChanged()
    if self:GetText() ~= "" then
      modificationList["MF::CHANGE_LICENSE_PLATE"] = string.Sanitise(self:GetText(), 9)
    else
      modificationList["MF::CHANGE_LICENSE_PLATE"] = nil
    end
    lblLicense:SetText(string.format("Votre plaque: %s", string.Sanitise(self:GetText(), 9)))
  end

  local basket = CreateListView(mainPanel)
  basket:Dock(FILL)
  function basket:Paint()
    --draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_MENU_BACK_ALT1)
  end
  basket:Hide()
  basket.HasEventListener = true
  function basket:OnShow()
    self:GetChildren()[2]:OnShow()
  end
  
  local categories = {
    { Name = translate("cd_cust_colors"), Identifier = "", NetString = "MF::CHANGE_COLOR", Panel = mixer },
    { Name = "Plaques", Identifier = "", NetString = "MF::CHANGE_LICENSE_PLATE", Panel = licensePanel },
    { Name = translate("cd_cust_wing"), Identifier = "Wing", NetString = "MF::CHANGE_SPOILER", Panel = nil },
    { Name = translate("cd_cust_skirt"), Identifier = "Skirt", NetString = "MF::CHANGE_SKIRT", Panel = nil },
    { Name = translate("cd_cust_hood"), Identifier = "Hood", NetString = "MF::CHANGE_HOOD", Panel = nil },
    { Name = translate("cd_cust_bumperr"), Identifier = "Bumperr", NetString = "MF::CHANGE_BUMPERR", Panel = nil },
    { Name = translate("cd_cust_bumperf"), Identifier = "Bumperf", NetString = "MF::CHANGE_BUMPERF", Panel = nil },
    { Name = translate("cd_cust_wheels"), Identifier = "Wheel", NetString = "MF::CHANGE_WHEEL", Panel = nil },
    { Name = translate("cd_cust_recap"), Identifier = "", NetString = "", Panel = basket },
  }

  for k, v in ipairs(categories) do
    if k == 1 or k == 2 or k == #categories then continue end
    local lv = CreateListView(mainPanel)
    lv:Dock(FILL)
    lv:Hide()
    lv:AddColumn(translate("cd_cust_name"))
    lv:AddColumn(translate("cd_cust_price"))
    if vehBodyGroups[v.Identifier] then
      lv.BodyGroupIndex = vehBodyGroups[v.Identifier]["Id"]
      for index, bgProperties in pairs(vehBodyGroups[v.Identifier]["Submodels"]) do
        local line = lv:AddLine(bgProperties["Text"], FormatMoney(bgProperties["Price"]))
        line.SubModelIndex = index
      end
    else
      v.ShouldHide = true
    end
    lv:RefreshPaint()
    lv:Hide()
    function lv:OnRowSelected(rowIndex, row)
      if not modificationList[v.NetString] then
        modificationList[v.NetString] = -1
      end
      modificationList[v.NetString] = row.SubModelIndex
      if modelPanel.Entity then
        modelPanel.Entity:SetBodygroup(self.BodyGroupIndex, row.SubModelIndex)
      end
    end
    v.Panel= lv
  end


  local lvBasket = CreateListView(basket)
  lvBasket:SetPos(5, 5)
  lvBasket:SetSize(mainPanel:GetWide() / 2, mainPanel:GetTall() - 10)
  lvBasket:AddColumn(translate("cd_cust_name"))
  local priceCol = lvBasket:AddColumn(translate("cd_cust_price")):SetFixedWidth(75)
  lvBasket:RefreshPaint()
  function lvBasket:OnShow()
    self:Clear()
    for identifier, v in pairs(modificationList) do 
      if identifier == "MF::CHANGE_COLOR" then
        lvBasket:AddLine(translate("cd_cust_recap_colors", v.r, v.g, v.b), FormatMoney(1000))
      end
      if identifier == "MF::CHANGE_LICENSE_PLATE" then
        lvBasket:AddLine(string.format("Plaque d'immatriculation [%s]", v), FormatMoney(3000))
      end
      if identifier == "MF::CHANGE_BUMPERF" then
        lvBasket:AddLine(translate("cd_cust_recap_bumperf", vehBodyGroups["Bumperf"]["Submodels"][v]["Text"]), FormatMoney(vehBodyGroups["Bumperf"]["Submodels"][v]["Price"]))
      end
      if identifier == "MF::CHANGE_BUMPERR" then
        lvBasket:AddLine(translate("cd_cust_recap_bumperr", vehBodyGroups["Bumperr"]["Submodels"][v]["Text"]), FormatMoney(vehBodyGroups["Bumperr"]["Submodels"][v]["Price"]))
      end
      if identifier == "MF::CHANGE_SPOILER" then
        lvBasket:AddLine(translate("cd_cust_recap_wing", vehBodyGroups["Wing"]["Submodels"][v]["Text"]), FormatMoney(vehBodyGroups["Wing"]["Submodels"][v]["Price"]))
      end
      if identifier == "MF::CHANGE_HOOD" then
        lvBasket:AddLine(translate("cd_cust_recap_hood", vehBodyGroups["Hood"]["Submodels"][v]["Text"]), FormatMoney(vehBodyGroups["Hood"]["Submodels"][v]["Price"]))
      end
      if identifier == "MF::CHANGE_SKIRT" then
        lvBasket:AddLine(translate("cd_cust_recap_skirt", vehBodyGroups["Skirt"]["Submodels"][v]["Text"]), FormatMoney(vehBodyGroups["Skirt"]["Submodels"][v]["Price"]))
      end
      if identifier == "MF::CHANGE_WHEEL" then
        lvBasket:AddLine(translate("cd_cust_recap_wheels", vehBodyGroups["Wheel"]["Submodels"][v]["Text"]), FormatMoney(vehBodyGroups["Wheel"]["Submodels"][v]["Price"]))
      end
    end
    self:RefreshPaint()
  end
  local basketResetButton = CreateButtonAlt(basket)
  basketResetButton:SetSize(mainPanel:GetWide() / 2 - 15, 25)
  basketResetButton:SetPos(mainPanel:GetWide() / 2 + 10, mainPanel:GetTall() - 60)
  basketResetButton:SetText(translate("cd_cust_reset"))
  function basketResetButton:DoClick()
    lvBasket:Clear()
    table.Empty(modificationList)
    modelPanel:SetModel(vehModel)
    modelPanel:SetColor(vehColor)
    modelPanel.Entity:SetBodyGroups(vehCurrentBodyGroups)
  end
  local basketConfirmButton = CreateButtonAlt(basket)
  basketConfirmButton:SetSize(mainPanel:GetWide() / 2 - 15, 25)
  basketConfirmButton:SetPos(mainPanel:GetWide() / 2 + 10, mainPanel:GetTall() - 30)
  basketConfirmButton:SetText(translate("cd_cust_confirm"))
  function basketConfirmButton:DoClick()
    net.Start("VBNET::Cars::ModifyVehicle")
    net.WriteString(vehModel)
    net.WriteTable(modificationList)
    net.SendToServer()
    window:Close()
  end
  local i = 1
  for k, v in ipairs(categories) do
    if v.ShouldHide then continue end
    local button = createCategoryButton(v.Name, v.Panel, buttonPanel)
    if k == 1 then 
      button.CurrentlySelected = true 
    else
      button:SetPos(0, (i - 1) * 37 )
    end
    i = i + 1 
  end

end