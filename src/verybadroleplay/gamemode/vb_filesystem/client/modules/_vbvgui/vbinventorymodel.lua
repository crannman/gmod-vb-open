
local BASE = baseclass.Get("DModelPanel")

local PANEL = {}

function PANEL:Init()

  self.Quantity = 0
  self.QuantityLabel = vgui.Create("DLabel", self)
  self.QuantityLabel:SetText(Translate("inv_quantity_short", self.Quantity))
  self.QuantityLabel:SetFont("VBFONT_InventoryTiny")
  self.QuantityLabel:SetSize(75, 10)
  self.QuantityLabel:SetPos(5, 65)

end

function PANEL:Paint(w, h)

  draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 150))
  draw.RoundedBoxEx(0, 0, 60, 80, 20, Color(0, 0, 0, 100), false, false, true, true)
  draw.RoundedBoxEx(0, 0, 0, 80, 20, Color(0, 0, 0, 100), false, false, true, true)

  BASE.Paint(self, w, h)

end

function PANEL:SetQuantity(quantity)

  self.Quantity = quantity
  self.QuantityLabel:SetText(Translate("inv_quantity_short", self.Quantity))

end

function PANEL:GetQuantity()

  return tonumber(self.Quantity)

end

VBVGUI:Register("InventoryModel", PANEL, VBVGUI:GetCompleteIdentifier("3DRotatingModel"))