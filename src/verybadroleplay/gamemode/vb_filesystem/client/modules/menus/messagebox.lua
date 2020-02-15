-- @desc Créer une boite de dialogue pouvant contenir un titre et un text personnalisà;
-- @args string Title, string Text;
-- @realm Client;
function MessageBoxShow(title, text, maxWidth)

  text = string.WrapText(text, maxWidth or 75)
  local window = vgui.Create("DFrame")
  local startTime = SysTime()
  window:SetSize(300, 90) -- without content
  window:SetTitle(title)
  window.lblTitle:SetFont("VBFONT_DERMANORMAL")
  window.lblTitle:SetColor(COLOR_WHITE)
  window:Center()
  window:ShowCloseButton(false)
  window.Paint = function()
    Derma_DrawBackgroundBlur(window, startTime)
    draw.RoundedBoxEx(5, 1, 27, window:GetWide() - 2, window:GetTall() - 26, COLOR_MENU_BAR, false, false, true, true)
    draw.RoundedBoxEx(5, 1, 0, window:GetWide() - 2, 27, COLOR_MENU_BACK, true, true, false, false)
  end

  window:MakePopup()
  local Message = Label(text, window)
  local _, lineHeight = Message:GetTextSize()
  local h = GetParagraphHeight(text, lineHeight)
  Message:SetPos(10, 35)
  Message:SetSize(280, h)
  window:SetSize(300, 90 + h)
  Message:SetFont("VBFONT_DERMANORMAL")
  Message:SetTextColor(COLOR_WHITE)

  local button = CreateButtonAlt(window)
  button:SetSize(200, 30)
  button:SetText("Okay")
  button:SetPos(window:GetWide() / 2 - 100, 50 + h)
  
  button.DoClick = function()
    window:Close()
  end

end

function CustomMessageBoxShow(tableContent, maxWidth)

  if tableContent == nil then return false end

  local text = string.WrapText(tableContent.Text, maxWidth or 75)
  local window = vgui.Create("DFrame")
  local startTime = SysTime()
  window:SetSize(300, 90) -- without content
  window:SetTitle(tableContent.Title)
  window.lblTitle:SetFont("VBFONT_DERMANORMAL")
  window.lblTitle:SetColor(COLOR_WHITE)
  window:Center()
  window:ShowCloseButton(false)
  window.Paint = function()
    Derma_DrawBackgroundBlur(window, startTime)
    draw.RoundedBoxEx(5, 1, 27, window:GetWide() - 2, window:GetTall() - 26, COLOR_MENU_BAR, false, false, true, true)
    draw.RoundedBoxEx(5, 1, 0, window:GetWide() - 2, 27, COLOR_MENU_BACK, true, true, false, false)
  end

  window:MakePopup()
  local Message = Label(text, window)
  local _, lineHeight = Message:GetTextSize()
  local h = GetParagraphHeight(text, lineHeight)
  Message:SetPos(10, 35)
  Message:SetSize(280, h + 20)
  window:SetSize(300, 80 + h + #tableContent.Buttons * 30 + #tableContent.Buttons * 5)
  Message:SetFont("VBFONT_DERMANORMAL")
  Message:SetTextColor(COLOR_WHITE)
  Message:SetWrap(true)
  for k, v in ipairs(tableContent.Buttons) do
    local button = CreateButtonAlt(window)
    button:SetSize(200, 30)
    button:SetText(v.Label)
    button:SetPos(window:GetWide() / 2 - 100, 30 + h + k * 30 + 5 * k)
    button.DoClick = function()
      if v.Callback ~= nil then
        v.Callback()
      end
      window:Close()
    end
  end

end