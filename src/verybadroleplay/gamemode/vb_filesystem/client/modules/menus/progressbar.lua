function CreateProgressBar(infoMessage, Time_in_second, statusMessage)
  --if LocalPlayer():IsModerator() then return end
  RunConsoleCommand("-forward")
  RunConsoleCommand("-back")
  RunConsoleCommand("-moveleft")
  RunConsoleCommand("-moveright")
  if statusMessage ~= "" then
    net.Start("VBNET_ChangeStatue")
    net.WriteString(statusMessage)
    net.SendToServer()
  end

  local pBarMaxWidth = 360
  local iterations = 0
  local progress = 0
  local window = vgui.Create("DFrame")
  window:SetSize(ScrW(), ScrH())
  window:SetTitle("")
  window:SetPos(0, 0)
  window:MakePopup()
  function window:Paint()
    draw.Arc(ScrW() / 2, ScrH() / 2, 18, 3, 0, pBarMaxWidth * progress, 4, COLOR_RGBA_SEMI_BLACK)
    draw.Arc(ScrW() / 2, ScrH() / 2, 22, 3, 0, pBarMaxWidth * progress, 4, COLOR_RGBA_SEMI_BLACK)
    draw.Arc(ScrW() / 2, ScrH() / 2, 20, 3, 0, pBarMaxWidth * progress, 4, COLOR_RGBA_FULL_WHITE)
  end
  window:ShowCloseButton(false)
  window:SetDraggable(false)
  timer.Create("VB::PBAR_TIMER", 1 / 33, 0, function()
    iterations = iterations + 1 / 33

    if iterations + 1 / 33 > Time_in_second then
      timer.Remove("VB::PBAR_TIMER")
      window:Remove()

      if statusMessage ~= "" then
        net.Start("VBNET_ChangeStatue")
        net.WriteString("")
        net.SendToServer()
      end
    end
    progress = math.Round(Perc(Time_in_second, iterations) / 100, 6)
  end)
end

function Perc(tMax, tPos)
  return (100 / tMax) * tPos
end