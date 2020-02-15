local vehTable = {}

net.Receive("VBNET::Cars::SendOwnedVehicles", function() 

  vehTable = net.ReadTable()
  if not vehTable[1] then
    MessageBoxShow(Translate("global_error"), "Vous n'avez pas de véhicule...")
    return false
  end
  DrawGarageMenu()

end)

function StartGarageMenu()
  net.Start("VBNET::Cars::GetOwnedVehicles")
  net.SendToServer()
end


function DrawGarageMenu()
  local vehName = ""
  local vehColor = COLOR_WHITE
  local vehBodygroups = ""
  local windowW = ScrW() / 2 - 375
  local windowH = ScrH() / 2 - 225
  local window = CreateWindowFrame()
  window:SetTitle(Translate("cd_window_title"))
  window:SetSize(745, 450)
  window:SetPos(windowW, windowH)
  window:ShowCloseButton(true)
  window:MakePopup()

  local buttonSpawnCar = CreateButtonAlt(window)
  buttonSpawnCar:SetSize(300, 30)
  buttonSpawnCar:SetPos(window:GetWide() - 310, 410)
  buttonSpawnCar:SetText(Translate("cd_spawn_car"))
  function buttonSpawnCar:DoClick()
    self:GetParent():Remove()
  end
  local panelInfoBack = vgui.Create("DPanel", window)
  panelInfoBack:SetSize(415, 95)
  panelInfoBack:SetPos(10, 345)
  function panelInfoBack:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BACK_PANEL)
  end
  local panelModelBack = vgui.Create("DPanel", window)
  panelModelBack:SetSize(415, 300)
  panelModelBack:SetPos(10, 35)
  function panelModelBack:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BACK_PANEL)
  end
  local carModel = vgui.Create("DModelPanel", panelModelBack)
  carModel:SetSize(415, 300)
  function carModel:LayoutEntity(entity) return end

  local carList = CreateListView(window)
  carList:SetMultiSelect(false)
  carList:AddColumn(Translate("cd_my_cars"))
  for k, v in ipairs(vehTable) do
    carList:AddLine(v.Name)
  end

  function carList:OnRowSelected(rowIndex, row)
    local chosenVeh = {}
    for k, v in pairs(vehTable) do
      if v.Name == row:GetValue(1) then
        chosenVeh = v
      end
    end
    vehName = chosenVeh.Name
    vehColor = chosenVeh.Color
    vehBodygroups = chosenVeh.Bodygroups
    carModel:SetModel(chosenVeh.Model)
    carModel:SetColor(vehColor)
    GenerateView(carModel, Vector(0.5 ,0.5, 0.5))
    carModel.Entity:SetBodyGroups(vehBodygroups)
  end

  carList:SetSize(300, 365)
  carList:SetPos(window:GetWide() - 310, 35)
  carList:RefreshPaint()

  function buttonSpawnCar:DoClick()
    if vehIdentifier ~= "" then
      net.Start("VBNET::Cars::SpawnVehicle")
      net.WriteString(vehName)
      net.WriteColor(vehColor)
      net.WriteString(vehBodygroups)
      net.SendToServer()
      window:Close()
    end
  end

end