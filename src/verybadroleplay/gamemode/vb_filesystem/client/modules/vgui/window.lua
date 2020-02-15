local vgc = vgui.Create
function CreateWindowFrame(parent)
  parent = parent or nil
  local window = vgc("DFrame", parent)
  window.lblTitle:SetFont("VBFONT_DERMANORMAL")
  window.lblTitle:SetTextColor(COLOR_WHITE)
  function window:Paint()
    draw.RoundedBoxEx(5, 0, 25, window:GetWide(), window:GetTall() - 25, COLOR_MENU_BAR, false, false, true, true)
    draw.RoundedBoxEx(5, 0, 0, window:GetWide(), 25, COLOR_MENU_BACK, true, true, false, false)
    surface.SetDrawColor(Color(20, 20, 20, 100))
    surface.DrawOutlinedRect(0, 0, window:GetWide(), window:GetTall())
  end
  return window
end