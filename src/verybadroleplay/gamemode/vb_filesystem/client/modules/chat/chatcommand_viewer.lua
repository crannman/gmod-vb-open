function ChatViewer(name, nameColor, text, head, headColor, shouldShowCaller, showHead)
  if showHead then
    UpdateChatBuffer(headColor, string.format("(%s)", head), Either(shouldShowCaller, nameColor, ""), Either(shouldShowCaller," " .. name, ""), Color(255, 255, 255), Either(shouldShowCaller, " : ", " "), text, CurTime() + 10)
  else
    UpdateChatBuffer(Either(shouldShowCaller, nameColor, ""), Either(shouldShowCaller, " " .. name, ""), Color(255, 255, 255), Either(shouldShowCaller, " : ", " "), text, CurTime() + 10)
  end
end


net.Receive("VBNET_StartChatViewer", function()
  local name = net.ReadString()
  local nameColor = net.ReadColor()

  local head = net.ReadString()
  local text = net.ReadString()

  local headColor = net.ReadColor()
  local shouldShowCaller = net.ReadBool()
  local showHead = net.ReadBool()
  ChatViewer(name, nameColor, text, head, headColor, shouldShowCaller, showHead)
end)

net.Receive("VBNET_StartChatViewerWithCustomLayout", function()

  local t = net.ReadTable()
  UpdateChatBuffer(unpack(t))

end)