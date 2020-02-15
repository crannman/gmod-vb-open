local PANEL = {}

function PANEL:Init()

  self.lblTitle:SetFont("VBFONT_DERMANORMAL")
  self.lblTitle:SetTextColor(COLOR_WHITE)

end

function PANEL:Paint(w, h)

  draw.RoundedBoxEx(5, 0, 25, w, h - 25, COLOR_MENU_BAR, false, false, true, true)
  draw.RoundedBoxEx(5, 0, 0, w, 25, COLOR_MENU_BACK, true, true, false, false)
  surface.SetDrawColor(Color(20, 20, 20, 100))
  surface.DrawOutlinedRect(0, 0, w, h)

end

VBVGUI:Register("Window", PANEL, "DFrame")