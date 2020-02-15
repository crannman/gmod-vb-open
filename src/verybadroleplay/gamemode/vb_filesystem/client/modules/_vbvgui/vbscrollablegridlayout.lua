local PANEL = {}


function PANEL:Init()

  local parent = self:GetParent()

  self.ScrollPanel = VBVGUI:Create("ScrollPanel", parent)
  self.Layout = VBVGUI:Create("GridLayout", self.ScrollPanel)
  self:SetSize(0, 0)
  
end

function PANEL:Add(panel)

  return self.Layout:Add(panel)

end

VBVGUI:Register("ScrollableGridLayout", PANEL)