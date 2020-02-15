local BASE = baseclass.Get("DMenu")

function BASE:Paint(w, h)

  draw.RoundedBox(5, 0, 0, w, h, Color(42, 42, 42))
  surface.SetDrawColor(Color(52, 52, 52))
  surface.DrawOutlinedRect(0, 0, w, h)

end

function BASE:AddOption(strText, funcFunction)

	local pnl = vgui.Create("DMenuOption", self)
	pnl:SetMenu(self)
    pnl:SetText(strText)
    pnl:SetFont("VBFONT_DERMANORMAL")
    pnl:SetTextColor(COLOR_WHITE)
	if funcFunction then pnl.DoClick = funcFunction end
	self:AddPanel( pnl )
	return pnl

end