local cellId = -1
net.Receive("VBNET::Jobs::Police::OpenJailMenu", function()

  cellId = net.ReadInt(16)
  OpenJailMenu()

end)

local create = vgui.Create
local clamp = math.Clamp

function OpenJailMenu()

  local duration = 1

  local window = CreateWindowFrame()
  window:SetSize(250, 85)
  window:Center()
  window:SetTitle("Arrestation")
  window:ShowCloseButton(true)
  window:MakePopup()

  local label = create("DLabel", window)
  label:SetSize(80, 20)
  label:SetPos(5, 30)
  label:SetTextColor(COLOR_WHITE)
  label:SetFont("VBFONT_DERMANORMAL")
  label:SetText("Durée (min): ")
  
  local numWang = create("DNumberWang", window)
  numWang:SetMax(15)
  numWang:SetMin(1)
  numWang:SetSize(160, 20)
  numWang:SetPos(85, 30)
  numWang:SetValue(1)
  function numWang:OnValueChanged(val)
    duration = clamp(val, 1, 15)
  end

  local btnConfirm = CreateButtonAlt(window)
  btnConfirm:SetSize(240, 25)
  btnConfirm:SetPos(5, 55)
  btnConfirm:SetText("Confirmer l'arrestation")
  function btnConfirm:DoClick()
    net.Start("VBNET::Jobs::Police::ArrestPlayer")
    net.WriteInt(cellId, 16)
    net.WriteFloat(clamp(duration, 1, 15) * 60)
    net.SendToServer()
    window:Close()
  end
end