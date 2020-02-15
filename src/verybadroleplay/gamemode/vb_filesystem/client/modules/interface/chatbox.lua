local chatBuffer = chatBuffer or {}
local shouldShowChatBox = false
local textInput = ""
local cursorPosition = 0
local cursorUpdate
local bufferShowed = false
VBChat = VBChat or {}

local setFont = surface.SetFont
local setTextPos = surface.SetTextPos
local setTextColor = surface.SetTextColor
local drawText = surface.DrawText
local getTextSize = surface.GetTextSize
local drawRect = surface.DrawRect
local setDrawColor = surface.SetDrawColor
local scrh = ScrH()
local tRemove = table.remove
local tInsert = table.insert
local tReverse = table.Reverse
local iterpairs = pairs
local curtime = CurTime
local clamp = math.Clamp
local istable = istable
local isstring = isstring
local Color = Color

function UpdateChatBuffer(...)
  local varargs = { ... }
  if #chatBuffer >= 20 then
  tRemove(chatBuffer, 1)
  end
  tInsert(chatBuffer, varargs)
  chat.PlaySound()
end

function VBChat.drawText(shouldFade, linepos, args)
  time = time or 0
  local alpha = 255
  local offset = 25
  local colorToWrite = nil
  if shouldFade then
  alpha = 255 * clamp(args[#args] - curtime(), 0, 1)
  end
  if alpha > 0 then
  for k, obj in iterpairs(args) do
    if istable(obj) then
      colorToWrite = Color(obj.r, obj.g, obj.b, alpha)
    elseif isstring(obj) then
      setFont("VBFONT_CHAT")
      local w, h = getTextSize(obj)
      local outlineOffset = 1
      setTextColor(0, 0, 0, alpha)
      
      setTextPos(offset - outlineOffset, (scrh * .85 - 2) - (h * linepos) - outlineOffset)
      drawText(obj)

      setTextPos(offset + outlineOffset, (scrh * .85 - 2) - (h * linepos) + outlineOffset)
      drawText(obj)

      setTextPos(offset + outlineOffset, (scrh * .85 - 2) - (h * linepos) - outlineOffset)
      drawText(obj)

      setTextPos(offset - outlineOffset, (scrh * .85 - 2) - (h * linepos) + outlineOffset)
      drawText(obj)

      setFont("VBFONT_CHAT")
      setTextPos(offset, (scrh * .85 - 2) - (h * linepos))
      setTextColor(colorToWrite)
      drawText(obj)

      offset = offset + w
    end
  end
  end
end

function DrawChatBuffer(shouldFade)
  local buffer_reverse = tReverse(chatBuffer)
  for k, varargs in iterpairs(buffer_reverse) do
    VBChat.drawText(shouldFade, k, varargs)
  end
end

hook.Add("StartChat", "VBHOOK_StartChat", function() 
  if not IsValid(LocalPlayer()) then return false end
  shouldShowChatBox = true
  return true
end)

hook.Add("FinishChat", "VBHOOK_FinishChat", function() 
  shouldShowChatBox = false
end)

hook.Add("ChatTextChanged", "VBHOOK_ChatTextChanged", function(text)
  textInput = text
  cursorPosition = getTextSize(textInput)
end)

hook.Add("HUDPaint", "VBHOOK_ChatPaint", function()
  if shouldShowChatBox then
    local outlineOffset = 1
    DrawChatBuffer(false)
    setFont("VBFONT_CHAT")
    local header = "(Chat): "
    local w, h = getTextSize(textInput)
    local w_2, h_2 = getTextSize(header)
    setDrawColor(20, 20, 20, 120)
    drawRect(20, scrh * .85, w_2 + w + 10, h + 5)
    
    setTextColor(COLOR_BLACK)
    
    setTextPos(25 + outlineOffset, scrh * .85 + 2.5 + outlineOffset)
    drawText(header)
    
    setTextPos(25 + outlineOffset, scrh * .85 + 2.5 - outlineOffset)
    drawText(header)

    setTextPos(25 - outlineOffset, scrh * .85 + 2.5 - outlineOffset)
    drawText(header)

    setTextPos(25 - outlineOffset, scrh * .85 + 2.5 + outlineOffset)
    drawText(header)

    setTextPos(25, scrh * .85 + 2.5)
    setTextColor(200, 200, 200, 255)
    drawText(header)

    setTextColor(COLOR_BLACK)

    setTextPos(25 + outlineOffset + w_2, scrh * .85 + 2.5 + outlineOffset)
    drawText(textInput)
    
    setTextPos(25 + outlineOffset + w_2, scrh * .85 + 2.5 - outlineOffset)
    drawText(textInput)

    setTextPos(25 - outlineOffset + w_2, scrh * .85 + 2.5 - outlineOffset)
    drawText(textInput)

    setTextPos(25 - outlineOffset + w_2, scrh * .85 + 2.5 + outlineOffset)
    drawText(textInput)

    setTextPos(25 + w_2, scrh * .85 + 2.5)
    setTextColor(255, 255, 255, 255)
    drawText(textInput)
  else
    DrawChatBuffer(true)
  end
end)