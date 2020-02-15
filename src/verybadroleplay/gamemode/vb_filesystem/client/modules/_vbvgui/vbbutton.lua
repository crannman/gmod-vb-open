local PANEL = {}

function PANEL:Init()

  self:SetFont("VBFONT_DERMANORMAL")
  self:SetTextColor(COLOR_WHITE)
  self.AlternativeColorScheme = false

end

function PANEL:Paint(w, h)

  if self.AlternativeColorScheme then
    draw.RoundedBox(0, 0, 0, w, h, COLOR_BUTTON_NORMAL)
    if self:IsHovered() then
      draw.RoundedBox(0, 0, 0, w, h, COLOR_BUTTON_HOVER)
    end
    if self:IsDown() then
      draw.RoundedBox(0, 0, 0, w, h, COLOR_BUTTON_CLICKED)
    end
  else
    draw.RoundedBox(0, 0, 0, w, h, COLOR_BUTTON_NORMAL_ALT)
    if self:IsHovered() then
      draw.RoundedBox(0, 0, 0, w, h, COLOR_BUTTON_HOVER_ALT)
    end
    if self:IsDown() then
      draw.RoundedBox(0, 0, 0, w, h, COLOR_BUTTON_CLICKED_ALT)
    end
  end

end

VBVGUI:Register("Button", PANEL, "DButton")