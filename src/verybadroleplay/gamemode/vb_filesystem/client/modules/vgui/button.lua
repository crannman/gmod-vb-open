local vgc = vgui.Create


function CreateButton(parent)
  parent = parent or nil
  local button = vgc("DButton", parent)
  button:SetFont("VBFONT_DERMANORMAL")
  button:SetTextColor(COLOR_WHITE)
  function button:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_NORMAL)
    if self:IsHovered() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_HOVER)
    end
    if self:IsDown() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_CLICKED)
    end
  end
  return button
end 

function CreateButtonAlt(parent)
  local button = CreateButton(parent)
  function button:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_NORMAL_ALT)
    if self:IsHovered() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_HOVER_ALT)
    end
    if self:IsDown() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BUTTON_CLICKED_ALT)
    end
  end
  return button
end
