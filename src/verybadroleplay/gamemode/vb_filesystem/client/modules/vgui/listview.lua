function CreateListView(parent)
  parent = parent or nil
  local listview = vgui.Create("DListView", parent)

  function listview:RefreshPaint()

    function listview:Paint()
      draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_BACKGROUND)
    end
    for k, column in pairs(listview.Columns) do
  
      --function column.Header:DoClick() return end
  
      column.Header:SetFont("VBFONT_DERMANORMAL")
      column.Header:SetColor(COLOR_WHITE)
  
      function column.Header:Paint()
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_COL_NORMAL)
        surface.SetDrawColor(COLOR_LIST_COL_BORDER)
        surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
      end
  
    end
  
    for k, line in pairs(listview.Lines) do
  
      for i, label in pairs(line.Columns) do
        label:SetFont("VBFONT_DERMANORMAL")
        label:SetColor(COLOR_WHITE)
      end
  
      function line:Paint()
        if k % 2 == 0 then
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_EVEN)
        else
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_ODD)
        end
        if self:IsSelected() then
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_SELECTED)
        end
        if self:IsHovered() and not self:IsSelected() then
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_HOVER)
        end
      end
  
    end
  

  end
  return listview
end

function CreateListViewAlt(parent)
  parent = parent or nil
  local listview = vgui.Create("DListView", parent)

  function listview:RefreshPaint()

    function listview:Paint()
      draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_BACKGROUND_ALT)
    end
    for k, column in pairs(listview.Columns) do
  
      --function column.Header:DoClick() return end
  
      column.Header:SetFont("VBFONT_DERMANORMAL")
      column.Header:SetColor(COLOR_WHITE)
  
      function column.Header:Paint()
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_COL_NORMAL_ALT)
        surface.SetDrawColor(COLOR_LIST_COL_BORDER)
        surface.DrawOutlinedRect(0, 0, self:GetWide(), self:GetTall())
      end
  
    end
  
    for k, line in pairs(listview.Lines) do
  
      for i, label in pairs(line.Columns) do
        label:SetFont("VBFONT_DERMANORMAL")
        label:SetColor(COLOR_WHITE)
      end
  
      function line:Paint()
        if k % 2 == 0 then
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_EVEN_ALT)
        else
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_ODD_ALT)
        end
        if self:IsSelected() then
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_SELECTED_ALT)
        end
        if self:IsHovered() and not self:IsSelected() then
          draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_LINE_HOVER_ALT)
        end
      end
  
    end
  

  end
  return listview
end
