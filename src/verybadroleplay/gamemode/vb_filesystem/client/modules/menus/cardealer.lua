local create = vgui.Create
local vehTable = {}
net.Receive("VBNET::Cars::SendVehiclesInfos", function(len, pl)
  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::CarDealer")
  vehTable = net.ReadTable()
  DrawCarDealerMenu()

end)

function StartCarDealerMenu()
  net.Start("VBNET::Cars::GetVehiclesInfo")
  net.SendToServer()
end

function DrawCarDealerMenu()
  local window = CreateWindowFrame()
  window:SetSize(750, 450)
  window:Center()
  window:MakePopup()
  window:SetTitle(Translate("cd_window_title2"))

  local panel = create("DPanel", window)
  panel:SetSize(435, 260)
  panel:SetPos(310, 30)

  function panel:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_MENU_BACK_ALT1)
  end

  local model = create("DModelPanel", panel)
  model:Dock(FILL)

  local mixer = create("DColorMixer", window)
  mixer:SetSize(435, 150)
  mixer:SetPos(310, window:GetTall() - mixer:GetTall() - 5)
  mixer:SetAlphaBar(false)
  function mixer:ValueChanged(newCol)
    if model.Entity then
      model:SetColor(newCol)
    end
  end

  local button = CreateButtonAlt(window)
  button:SetPos(5, window:GetTall() - 45)
  button:SetSize(300, 40)
  button:SetText(Translate("cd_select_veh_to_buy"))


  local listView = CreateListView(window)
  listView:SetPos(5, 30)
  listView:SetSize(300, window:GetTall() - 80)
  listView:AddColumn(Translate("cd_veh_available"))
  for k, v in pairs(vehTable) do
    line = listView:AddLine(v.Name)
  end
  function listView:OnRowSelected(rowIndex, row)
    local chosenVeh = {}
    for k, v in pairs(vehTable) do
      if v.Name == row:GetValue(1) then
        chosenVeh = v
      end
    end
    model:SetModel(chosenVeh.Model)
    GenerateView(model)
    model:SetFOV(45)
    button:SetText(Translate("cd_buy", FormatMoney(chosenVeh.Price)))
  end

  listView:RefreshPaint()

  function button:DoClick()
    local chosenVeh = nil
    local identifier = ""
    local lineId = listView:GetSelectedLine()
    if not lineId then return false end
    for k, v in pairs(vehTable) do
      if v.Name == listView:GetLine(lineId):GetValue(1) then
        chosenVeh = v
        identifier = k
      end
    end
    local content = {
      Text = Translate("cd_cardealer_confirm_buy", chosenVeh.Name, FormatMoney(chosenVeh.Price)),
      Title = Translate("cd_buy_window_title"),
      Buttons = {
        [1] = {
          Label = Translate("cd_answer_yes"),
          Callback = function()
            net.Start("VBNET::Cars::BuyVehicle")
            net.WriteString(identifier)
            net.WriteTable(mixer:GetColor())
            net.SendToServer()
          end
        },
        [2] = {
          Label = Translate("cd_answer_no"),
          Callback = nil
        }
      }
    }
    CustomMessageBoxShow(content)
  end
end