--[[-------------------------------------------------------------------------
Flea Menu
---------------------------------------------------------------------------]]
--local SW = ScrW()
--local SH = ScrH()
--local Client = LocalPlayer()
local fleaItems = { }

function CreateFleaMarketMenu()
  local window = vgui.Create("DFrame")
  window:SetTitle(Translate("fl_market_title"))
  window:SetSize(800, 450)
  window:Center()
  window:MakePopup()
  window.lblTitle:SetFont("VBFONT_DERMANORMAL")
  window.lblTitle:SetTextColor(COLOR_WHITE)

  window.Paint = function()
    draw.RoundedBoxEx(5, 0, 25, window:GetWide(), window:GetTall() - 25, COLOR_MENU_BAR, false, false, true, true)
    draw.RoundedBoxEx(5, 0, 0, window:GetWide(), 25, COLOR_MENU_BACK, true, true, false, false)
  end

  local windowScrollPanel = vgui.Create("DScrollPanel", window)
  windowScrollPanel:Dock(FILL)
  windowScrollPanel:GetVBar():SetWidth(0)
  local verticalOffset = 5
  local xPos = 0
  local yPos = 0
  local i = 1

  for _, v in pairs(fleaItems) do
    if i == 1 then
      xPos = 0
      yPos = verticalOffset
    end

    if i % 2 == 0 then
      xPos = window:GetWide() / 2
      yPos = verticalOffset
      verticalOffset = verticalOffset + 80 + 10
    end

    if i % 2 == 1 and i ~= 1 then
      xPos = 0
      yPos = verticalOffset
    end

    local itemPanel = windowScrollPanel:Add("DPanel")
    itemPanel:SetSize((window:GetWide() / 2) - 10, 80)
    itemPanel:SetPos(xPos, yPos)

    itemPanel.Paint = function()
      draw.RoundedBox(0, 0, 0, itemPanel:GetWide(), itemPanel:GetTall(), COLOR_GREYBLUE)
    end

    local panel = vgui.Create("DModelPanel", itemPanel)
    panel:SetSize(75, 75)
    panel:SetModel(v["Model"])
    GenerateView(panel)
    panel:SetPos(0, 5)
    panel:SetTooltip(v["Desc"])
    buyText = Translate("fl_quantity_required")
    quantity = 0
    local buyButton = vgui.Create("DButton", itemPanel)
    buyButton:SetSize(115, 35)
    buyButton:SetPos(itemPanel:GetWide() - 125, itemPanel:GetTall() / 2 - 5)
    buyButton:SetFont("VBFONT_DERMANORMAL")
    buyButton:SetText(buyText)
    buyButton:SetEnabled(false)
    buyButton:SetTextColor(COLOR_GREY)

    buyButton.Paint = function()
      draw.RoundedBox(0, 0, 0, buyButton:GetWide(), buyButton:GetTall(), COLOR_BUTTON_NORMAL)

      if buyButton:IsHovered() then
        draw.RoundedBox(0, 0, 0, buyButton:GetWide(), buyButton:GetTall(), COLOR_BUTTON_HOVER)
      end

      if buyButton:IsDown() then
        draw.RoundedBox(0, 0, 0, buyButton:GetWide(), buyButton:GetTall(), COLOR_BUTTON_CLICKED)
      end
    end

    buyButton.DoClick = function()
      net.Start("VBNET::Inventory::Flea::BuyItem")
      net.WriteString(v["Identifier"])
      net.WriteInt(quantity, 16)
      net.SendToServer()
    end

    local label = Label(Translate("fl_description"), itemPanel)
    label:SetFont("VBFONT_DERMANORMAL")
    label:SetPos(80, 8)
    label:SizeToContents()
    label:SetTextColor(COLOR_WHITE)
    local itemPrice = v["MarketPrice"]
    local qtySelector = vgui.Create("DNumberWang", itemPanel)
    qtySelector:SetPos(itemPanel:GetWide() - 55, 5)
    qtySelector:SetSize(40, 20)
    qtySelector:SetMinMax(0, 20)

    function qtySelector:OnValueChanged(val)
      quantity = val

      if tonumber(val) > 0 then
        buyText = Translate("fl_buy", FormatMoney(itemPrice * val))
        buyButton:SetText(buyText)
        buyButton:SetTextColor(COLOR_WHITE)
        buyButton:SetEnabled(true)
      else
        buyText = Translate("fl_quantity_required")
        buyButton:SetTextColor(COLOR_GREY)
        buyButton:SetEnabled(false)
        buyButton:SetText(buyText)
      end
    end

    local label2 = Label(Translate("fl_quantity"), itemPanel)
    label2:SetFont("VBFONT_DERMANORMAL")
    label2:SetPos(itemPanel:GetWide() - 125, 8)
    label2:SizeToContents()
    label2:SetTextColor(COLOR_WHITE)
    local itemDesc = v["Name"]
    local labelDesc = Label(itemDesc, itemPanel)
    labelDesc:SetFont("VBFONT_DERMANORMAL")
    labelDesc:SetPos(80, 12)
    labelDesc:SetSize(150, 65)
    labelDesc:SetWrap(true)
    labelDesc:SetTextColor(COLOR_WHITE)
    i = i + 1
  end

  --when loaded flush table in order to refresh data next time.
  FleaItem = { }
end

function StartFleaMarketMenu()
  net.Start("VBNET::Inventory::Flea::RetrieveItems")
  net.SendToServer()
end

net.Receive("VBNET::Inventory::Flea::SendItems", function(len, pl)

  local length = net.ReadUInt(16)
  local data = net.ReadData(length)

  fleaItems = util.JSONToTable(util.Decompress(data))
  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::Itemstore")
  CreateFleaMarketMenu()

end)
net.Receive("VBNET::Inventory::Flea::CannotBuyItem", function(len, pl)
  MessageBoxShow("Flea", Translate("fl_cannot_afford"))
end)