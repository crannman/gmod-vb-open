net.Receive("VBNET::Groups::RequestPlayerToJoinGroup", function()
  
  local group = net.ReadString()
  local content = {
    Title = Translate("op_received_invitation"),
    TextContent = Translate("op_invite_message", group),
    Callback = function() return false end,
    Duration = 20,
    Buttons = {
      [1] = {
        Label = Translate("op_accept_invite"),
        Action = function(self)
          net.Start("VBNET::Groups::PlayerJoinGroup")
          net.WriteString(group)
          net.SendToServer()
          self:GetParent():Close()
        end
      },
      [2] = {
        Label = Translate("op_deny_invite"),
        Action = function(self)
          self:GetParent():Close()
        end
      },
    }
  }
  CreateNotification(content)

end)