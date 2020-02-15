
local BASE = baseclass.Get("DModelPanel")

local PANEL = {}

function PANEL:Init()

  self.Identifier = "NULL_ITEM"

  self.Price = 10
  self.PriceLabel = vgui.Create("DLabel", self)
  self.PriceLabel:SetText(FormatMoney(self.Price))
  self.PriceLabel:SetTextColor(Either(LocalPlayer():CanAfford(self.Price), COLOR_GREEN, COLOR_RED))
  self.PriceLabel:SetFont("VBFONT_InventoryTiny")
  self.PriceLabel:SetSize(75, 10)
  self.PriceLabel:SetPos(5, 65)

end

function PANEL:Paint(w, h)

  draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
  draw.RoundedBoxEx(0, 0, 60, 80, 20, Color(0, 0, 0, 100), false, false, true, true)
  draw.RoundedBoxEx(0, 0, 0, 80, 20, Color(0, 0, 0, 100), false, false, true, true)

  BASE.Paint(self, w, h)

end

function PANEL:SetPrice(price)

  self.Price = price
  self.PriceLabel:SetText(FormatMoney(self.Price))

end

function PANEL:GetPrice()

  return tonumber(self.Price)

end

VBVGUI:Register("ShopModel", PANEL, VBVGUI:GetCompleteIdentifier("3DRotatingModel"))