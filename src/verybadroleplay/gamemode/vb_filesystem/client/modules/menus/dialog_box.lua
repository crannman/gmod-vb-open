-- @desc Cr�er un dialogue avec des boutons en fonction du NPC;
-- @args string NPCName, table DialogSettings;
-- @realm Client;
function CreateNPCDialog(npcName, dialogSettings)
  local textDialog = ""
  local buttonCount = 0

  for _, v in pairs(dialogSettings) do
    if v["Type"] == "NPC_Dialog" then
      textDialog = v["Text"]()
    end

    if v["Type"] == "NPC_Answer" then
      buttonCount = buttonCount + 1
    end
  end

  local buttonSize = 35
  local baseSizeH = 75
  local size = baseSizeH + buttonCount * buttonSize + 15
  local window = vgui.Create("DFrame")
  window:SetSize(300, size)
  window:Center()
  window.lblTitle:SetFont("VBFONT_DERMANORMAL")
  window.lblTitle:SetColor(COLOR_WHITE)
  window:ShowCloseButton(true)
  -- window:SetTitle("Dialogue avec " .. npcName)
  window:SetTitle(Translate("dialog_title", npcName))
  function window:Paint()
    draw.RoundedBoxEx(5, 0, 25, window:GetWide(), window:GetTall() - 25, COLOR_MENU_BAR, false, false, true, true)
    draw.RoundedBoxEx(5, 0, 0, window:GetWide(), 25, COLOR_MENU_BACK, true, true, false, false)
  end

  window:MakePopup()
  local label = Label(textDialog, window)
  local _, lineHeight = label:GetTextSize()
  local h = GetParagraphHeight(textDialog, lineHeight) + 5
  label:SetPos(25, 15)
  label:SetSize(250, 50 + h)
  label:SetWrap(true)
  label:SetFont("VBFONT_DERMANORMAL")

  local offset = 80

  for k, v in SortedPairs(dialogSettings) do
    if v["Type"] == "NPC_Answer" then
      local button = k
      button = CreateButtonAlt(window)
      button:SetSize(250, buttonSize - 5)
      button:SetPos(25, offset)
      button:SetText(v["Text"]())

      button.DoClick = v["Action"]
      offset = offset + buttonSize
    end
  end
end