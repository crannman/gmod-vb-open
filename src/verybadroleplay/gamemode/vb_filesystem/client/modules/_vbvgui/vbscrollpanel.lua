local PANEL = {}

function PANEL:Init()

  self:Dock(FILL)
  self:GetVBar():SetWidth(0)

end

function PANEL:Paint()

  draw.RoundedBox(0, 8, 0, self:GetWide() - 16, self:GetTall() - 8, Color(48, 58, 76))

end

VBVGUI:Register("ScrollPanel", PANEL, "DScrollPanel")