local PANEL = {}

PANEL.ColorSet = {
  {
    ["LIST_BACKGROUND"]  = COLOR_LIST_BACKGROUND,
    ["LIST_COL"]         = COLOR_LIST_COL_NORMAL,
    ["LIST_COL_BORDER"]  = COLOR_LIST_COL_BORDER,
    ["LINE_EVEN"]        = COLOR_LIST_LINE_EVEN,
    ["LINE_ODD"]         = COLOR_LIST_LINE_ODD,
    ["LINE_SELECTED"]    = COLOR_LIST_LINE_SELECTED,
    ["LINE_HOVER"]       = COLOR_LIST_LINE_HOVER
  },
  {
    ["LIST_BACKGROUND"]  = COLOR_LIST_BACKGROUND_ALT,
    ["LIST_COL"]         = COLOR_LIST_COL_NORMAL_ALT,
    ["LIST_COL_BORDER"]  = COLOR_LIST_COL_BORDER_ALT,
    ["LINE_EVEN"]        = COLOR_LIST_LINE_EVEN_ALT,
    ["LINE_ODD"]         = COLOR_LIST_LINE_ODD_ALT,
    ["LINE_SELECTED"]    = COLOR_LIST_LINE_SELECTED_ALT,
    ["LINE_HOVER"]       = COLOR_LIST_LINE_HOVER_ALT
  },
}

function PANEL:Init()

  self.AlternateColorScheme = false

end

function PANEL:Paint()

  draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_BACKGROUND)

end

function PANEL:PaintList()
  local colorScheme = Either(self.AlternativeColorScheme, self.ColorSet[2], self.ColorSet[1])

  for k, column in ipairs(self.Columns) do
    column.Header:SetFont("VBFONT_DERMANORMAL")
    column.Header:SetColor(COLOR_WHITE)
    function column.Header:Paint()
      draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), colorScheme["LIST_COL"])
      surface.SetDrawColor(colorScheme["LIST_COL_BORDER"])
      surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
    end
  end

  for k, line in ipairs(self.Lines) do
    for j, label in ipairs(line.Columns) do
      label:SetFont("VBFONT_DERMANORMAL")
      label:SetColor(COLOR_WHITE)
    end
    function line:Paint()
      if k % 2 == 0 then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), colorScheme["LINE_EVEN"])
      else
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), colorScheme["LINE_ODD"])
      end
      if self:IsSelected() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), colorScheme["LINE_SELECTED"])
      end
      if self:IsHovered() and not self:IsSelected() then
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), colorScheme["LINE_HOVER"])
      end
    end
  end

end

VBVGUI:Register("ListView", PANEL, "DListView")