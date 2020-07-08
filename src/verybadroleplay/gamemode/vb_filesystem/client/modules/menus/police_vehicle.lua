local lastCall = nil
hook.Add("OnSpawnMenuOpen", "VBHOOK::ShowPoliceVehicleContextMenu", function()
  ply = LocalPlayer()
  if ply:InVehicle() and VBJOB.GetJob(ply).Police then
    if not lastCall then
      lastCall = CurTime() + 2
    elseif lastCall > CurTime() then
      ClientsideNotify("Wait a bit before reopening this menu!")
      return false
    else
      lastCall = nil
    end
    net.Start("VBNET::Jobs::Police::OpenPoliceVehicleContextMenu")
    net.SendToServer()
  end
end)

net.Receive("VBNET::Jobs::Police::ShouldShowPoliceVehicleContextMenu", function(len, pl)

  local inVehicle = net.ReadBool()
  if inVehicle then
    ShowPoliceVehicleContextMenu()
  else
    ClientsideNotify("You must be in a police car to open this menu!")
  end

end)

function ShowPoliceVehicleContextMenu()

  local window = CreateWindowFrame()
  window:SetTitle("pol_veh_ctx_menu")
  window:SetSize(350, 135)
  window:SetPos((ScrW() - window:GetWide()) / 2, ScrH() - window:GetTall() - 100)
  window:ShowCloseButton(true)
  window:MakePopup()

  local buttonRadio = CreateButtonAlt(window)
  buttonRadio:SetPos(5, 30)
  buttonRadio:SetSize(window:GetWide() - 10, 30)
  buttonRadio:SetText(Either(LocalPlayer():GetWeapon("vbrp_police_radio"):GetDTRadioActivated(), "Disable radio", "Activate radio"))
  function buttonRadio:DoClick()
    net.Start("VBNET::SWEP::PoliceRadio::Toggle")
    net.SendToServer()
    buttonRadio:SetText(Either(buttonRadio:GetText() == "Activate radio", "Disable radio", "Activate radio"))
    window:Close()
  end

  local buttonCentral = CreateButtonAlt(window)
  buttonCentral:SetSize(window:GetWide() - 10, 30)
  buttonCentral:SetPos(5, 65)
  buttonCentral:SetText("Show central")
  function buttonCentral:DoClick()
    OpenPoliceCentralMenu(false)
    window:Close()
  end

  local buttonRadar = CreateButtonAlt(window)
  buttonRadar:SetSize(window:GetWide() - 10, 30)
  buttonRadar:SetPos(5, 100)
  buttonRadar:SetText("Activate the radar")
  function buttonRadar:DoClick()
    buttonRadar:SetText(Either(buttonRadar:GetText() == "Activate radar", "Disable radar", "Activate radar"))
  end
end
