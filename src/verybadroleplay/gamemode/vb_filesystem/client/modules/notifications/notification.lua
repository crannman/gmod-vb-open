local notificationCount = 0
local create = vgui.Create
local sW = ScrW()

function CreateNotification(content)
  chat.PlaySound()
  local numberButtons = #content.Buttons
  local window = CreateWindowFrame()
  window:SetSize(300, 150)
  window:SetPos(sW + 10, 40 + notificationCount * 155)
  window:SetTitle(content.Title)
  local frameTall = window:GetTall()
  local richText = create("RichText", window)
  function richText:PerformLayout()
    self:SetFontInternal("VBFONT_DERMANORMAL")
    self:SetFGColor(COLOR_WHITE)
  end
  function window:OnClose()
    notificationCount = notificationCount - 1
  end
  if content.Duration > 0 then
    window:ShowCloseButton(false)
  end
  richText:SetText(content.TextContent)
  richText:SetPos(5, 30)
  richText:SetSize(290, frameTall - 40)
  richText:SetVerticalScrollbarEnabled(false)
  if numberButtons > 0 then
    local margin = 5
    local buttonSizeX = (300 - margin * (numberButtons + 1)) / numberButtons
    for k,v in ipairs(content.Buttons) do
      local button = CreateButtonAlt(window)
      button:SetSize(buttonSizeX, 25)
      button:SetPos(margin + (k - 1) * (margin + buttonSizeX), frameTall - 35)
      button:SetText(v.Label)
      function button:DoClick()
        v.Action(self)
      end
    end
  end
  window:MoveTo(sW - 330, 40 + notificationCount * 155, 0.3, 0, -1, function(animData, panel)
    local x, y = panel:GetPos()
    panel:MoveTo(sW - 300, y, 0.2, 0, -1, function(animdata, panel)
      panel:MoveTo(sW - 310, y, 0.2, 0, -1, function(animData, panel)
        if content.Duration > 0 then
          timer.Simple(content.Duration, function()
            if window:IsValid() then
              panel:MoveTo(sW + 10, y, 0.3, 0, -1, function(animData, panel)
                  panel:Remove()
                  notificationCount = notificationCount - 1
                  content.Callback()
                end)
            end
          end)
        end
      end)
    end)
  end)
  notificationCount = notificationCount + 1
end

concommand.Add("test_notify", function()
  local content = {
    Title = "Test Notification",
    TextContent = "Text content of the test notification",
    Callback = function() print("This is called when the notification disappears") end,
    Duration = 5,
    Buttons = {
      [1] = {
        Label = "Test #1",
        Action = function() print("Action #1") end
      },
      [2] = {
        Label = "Test #2",
        Action = function() print("Action #2") end
      },
      [3] = {
        Label = "Test #2",
        Action = function() print("Action #3") end
      }
    }
  }
  CreateNotification(content)
end, _, "", FCVAR_CLIENTCMD_CAN_EXECUTE)