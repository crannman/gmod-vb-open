--[[-------------------------------------------------------------------------
Real Estate Menu
---------------------------------------------------------------------------]]
local Properties = { }
local VG = vgui.Create
local ActualEntity

net.Receive("VBNET_REALESTATE_ConfirmPlayerIsNearToNPC", function()
  ActualEntity = net.ReadEntity()
  StartRealEstateMenu()
end)

function StartRealEstateMenu()
  net.Start("VBNET::Properties::RetrieveBuyableProperties")
  net.WriteEntity(ActualEntity)
  net.SendToServer()

  net.Receive("VBNET::Properties::SendPropertiesToPlayer", function(len, ply)
    VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::RealEstate")
    Properties = net.ReadTable()
    CreateRealEstateMenu()
  end)
end

local function getNumberOwnablePropertiesByLocalPlayer()
  local count = 0
  for k, v in SortedPairsByMemberValue(Properties, "Name") do
    if Entity(v["doorsGroup__entityID"][1]):GetEntOwner() == LocalPlayer():GetCompleteName()
    or Entity(v["doorsGroup__entityID"][1]):GetEntOwner() == "" 
    or Entity(v["doorsGroup__entityID"][1]):GetEntOwner() == "world" then
      count = count + 1
    end
  end
  return count
end

function CreateRealEstateMenu()
  if getNumberOwnablePropertiesByLocalPlayer() == 0 then
    MessageBoxShow(Translate("global_error"), Translate("re_no_properties_available"))
    return false
  end
  local window = VG("DFrame")
  window:SetSize(325, 375)
  window:Center()
  window:SetTitle(Translate("re_window_title"))
  window.lblTitle:SetTextColor(COLOR_WHITE)
  window.lblTitle:SetFont("VBFONT_DERMANORMAL")
  window:MakePopup()

  window.Paint = function()
    draw.RoundedBoxEx(5, 0, 25, window:GetWide(), window:GetTall() - 25, COLOR_MENU_BAR, false, false, true, true)
    draw.RoundedBoxEx(5, 0, 0, window:GetWide(), 25, COLOR_MENU_BACK, true, true, false, false)
  end

  local windowScrollPanel = VG("DScrollPanel", window)
  windowScrollPanel:Dock(FILL)
  windowScrollPanel:GetVBar():SetWidth(0)
  for _, v in SortedPairsByMemberValue(Properties, "Name") do
    if Entity(v["doorsGroup__entityID"][1]):GetEntOwner() ~= LocalPlayer():GetCompleteName() 
    and Entity(v["doorsGroup__entityID"][1]):GetEntOwner() ~= "" 
    and Entity(v["doorsGroup__entityID"][1]):GetEntOwner() ~= "world" then
      continue
    end
    local panel = windowScrollPanel:Add("DPanel")
    panel:Dock(TOP)
    panel:DockMargin(0, 0, 0, 5)
    panel:SetSize(windowScrollPanel:GetWide() - 10, 75)
    panel:SetPos(5, 0)

    panel.Paint = function()
      draw.RoundedBox(0, 0, 0, panel:GetWide(), panel:GetTall(), COLOR_GREYBLUE)
    end

    local actionButton = CreateButton(panel)

    if Entity(v["doorsGroup__entityID"][1]):GetEntOwner() == LocalPlayer():GetCompleteName() then
      actionButton:SetText(Translate("re_sell"))
    else
      actionButton:SetText(Translate("re_buy"))
    end

    actionButton:SetSize(60, 35)
    actionButton:SetPos(250, panel:GetTall() - 40)

    actionButton.DoClick = function()
      if Entity(v["doorsGroup__entityID"][1]):GetEntOwner() == LocalPlayer():GetCompleteName() then
        net.Start("VBNET::Properties::SellProperty")
        net.WriteString(v["Name"])
        net.SendToServer()
        actionButton:SetText(Translate("re_buy"))
        window:Close()
        MessageBoxShow(Translate("re_selling_confirmation"), Translate("re_selling_message"), 50)
      elseif LocalPlayer():CanAfford(v["Price"]) then
        net.Start("VBNET::Properties::BuyProperty")
        net.WriteString(v["Name"])
        net.SendToServer()
        actionButton:SetText(Translate("re_sell"))
        window:Close()
        MessageBoxShow(Translate("re_buying_confirmation"), Translate("re_buying_message"), 50)
      else
        MessageBoxShow(Translate("global_error"), Translate("re_cannot_afford"), 50)
      end
    end

    local propertyImage = VG("DImage", panel)
    propertyImage:SetSize(panel:GetTall() - 10, panel:GetTall() - 10)
    propertyImage:SetPos(5, 5)
    propertyImage:SetImage("scripted/breen_fakemonitor_1")
    local labelInfo = Label(Translate("re_property_info", v["Name"], FormatMoney(v["Price"])), panel)
    labelInfo:SetPos(panel:GetTall(), 5)
    labelInfo:SetTextColor(COLOR_WHITE)
    labelInfo:SetFont("VBFONT_DERMANORMAL")
    labelInfo:SizeToContents()
  end
end