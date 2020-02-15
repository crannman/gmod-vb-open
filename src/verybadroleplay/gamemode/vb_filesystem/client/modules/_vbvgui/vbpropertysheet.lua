local BASE = baseclass.Get("DPropertySheet")
local PANEL = {}

function PANEL:Init()

  self:Dock(FILL)

end

function PANEL:AddSheet(name, pnl, icon)
  icon = icon or nil

  BASE.AddSheet(self, name, pnl, icon)

  for k, v in ipairs(self.Items) do
    if not v.Tab then continue end
    function v.Tab.Paint(_, w, h)
      v.Tab:SetFont("VBFONT_DERMANORMAL")
      if v.Tab == self:GetActiveTab() then
        draw.RoundedBox(0, Either(k == 1, 5, 0), 0, Either(k == 1, self:GetWide() - 5, self:GetWide()), self:GetTall(), Color(48, 58, 76))
      else
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_GREYBLUE)
      end
    end
  end

end

function PANEL:Paint(w, h)
  draw.RoundedBox(0, 0, 0, w, h, COLOR_GREYBLUE)
end

VBVGUI:Register("PropertySheet", PANEL, "DPropertySheet")