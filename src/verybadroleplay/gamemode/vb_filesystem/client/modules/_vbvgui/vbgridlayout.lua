local PANEL = {}

function PANEL:Init()

  self:Dock(FILL)
  self:SetSpaceX(15)
  self:SetSpaceY(15)
  self:DockMargin(15, 15, 0, 0)
  self:DockPadding(0, 0, 0, 15)

end

VBVGUI:Register("GridLayout", PANEL, "DIconLayout")