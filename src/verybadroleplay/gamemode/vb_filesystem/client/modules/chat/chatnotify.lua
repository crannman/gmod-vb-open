net.Receive("VBNET_ChatNotify", function()
  UpdateChatBuffer(unpack(net.ReadTable()))
end)

function ClientsideNotify(message)

  net.Start("VBNET_ClientsideChatNotify")
  net.WriteString(message)
  net.SendToServer()

end