local vgc = vgui.Create
function CreateTextEntry(parent, fontToApply)
  parent = parent or nil
  local textEntry = vgc("DTextEntry", parent)
  textEntry:SetFont(fontToApply)
  function textEntry:OnCaretChanged()
    local caretPos = self:GetCaretPos()
    self:SetCaretPos(caretPos)
    self.CaretTextPos = self:GetText():sub(0, self:GetCaretPos())
    surface.SetFont(fontToApply)
    self.CaretOffset = surface.GetTextSize(self.CaretTextPos)
  end
  function textEntry:Paint()
    surface.SetFont(fontToApply)
    local size_w, size_h = surface.GetTextSize(self:GetText())
    if not self.CaretOffset then
      self.CaretOffset = 0
    end
    if self.OldCaretPos and self.OldCaretPos ~= self:GetCaretPos() then
      self:OnCaretChanged()
    end
    if self:HasFocus() then
      draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_TEXTENTRY_FOCUS)
      draw.DrawText(self:GetText(), fontToApply, 5, self:GetTall() / 2 - size_h / 2, COLOR_WHITE, TEXT_ALIGN_LEFT)
      surface.SetDrawColor(COLOR_TEXTENTRY_BORDER)
      surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
    else
      draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_TEXTENTRY_NOFOCUS)
      draw.DrawText(self:GetText(), fontToApply, 5, self:GetTall() / 2 - size_h / 2, COLOR_WHITE, TEXT_ALIGN_LEFT)
    end
    if not self.NextBlink then
      self.NextBlink = CurTime() + .5
    end
    if self:GetText() == "" then
      draw.DrawText(self:GetPlaceholderText(), fontToApply, 5, self:GetTall() / 2 - size_h / 2, COLOR_SLIGHTLYGREY, TEXT_ALIGN_LEFT)
    end
    if self:HasFocus() then
      if self.NextBlink < CurTime() then
        draw.DrawText("|", fontToApply, self.CaretOffset + 5, self:GetTall() / 2 - size_h / 2, COLOR_WHITE)
        if self.NextBlink + .5 < CurTime() then
          self.NextBlink = nil
        end
      end
    end
    self.OldCaretPos = self:GetCaretPos()
  end
  return textEntry
end