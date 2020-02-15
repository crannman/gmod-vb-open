local BASE = baseclass.Get("DTooltip")

function BASE:Init()

	self:SetDrawOnTop( true )
	self.DeleteContentsOnClose = false
	self:SetText( "" )
  self:SetFont("VBFONT_DERMANORMAL")
  self:SetTextColor(COLOR_WHITE)
  
end

function BASE:Paint(w, h)

  self:PositionTooltip()
  draw.RoundedBox(5, 0, 0, w, h, Color(42, 42, 42))

end