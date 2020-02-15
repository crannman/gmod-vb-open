function OpenPoliceArmory()
  if not LocalPlayer():GetJob().AccessToArmory then 
    ClientsideNotify(Translate("pol_wep_arm_noaccess"))
    return false 
  end

  local window = CreateWindowFrame()
  window:SetSize(300, 150)
  window:SetTitle(Translate("pol_wep_arm_title"))
  window:Center()
  window:MakePopup()

  local buttonSnip = CreateButtonAlt(window)
  buttonSnip:SetSize(window:GetWide() - 10, 25)
  buttonSnip:SetPos(5, 30)
  buttonSnip:SetText(Translate("pol_wep_arm_get_snip"))

  function buttonSnip:DoClick()
    window:Close()
    net.Start("VBNET::Jobs::Police::Armory::GetWeapon")
    net.WriteInt(1, 8)
    net.SendToServer()
  end

  local buttonRif = CreateButtonAlt(window)
  buttonRif:SetSize(window:GetWide() - 10, 25)
  buttonRif:SetPos(5, 60)
  buttonRif:SetText(Translate("pol_wep_arm_get_rif"))
  function buttonRif:DoClick()
    window:Close()
    net.Start("VBNET::Jobs::Police::Armory::GetWeapon")
    net.WriteInt(2, 8)
    net.SendToServer()
  end

  local buttonShot = CreateButtonAlt(window)
  buttonShot:SetSize(window:GetWide() - 10, 25)
  buttonShot:SetPos(5, 90)
  buttonShot:SetText(Translate("pol_wep_arm_get_shot"))
  function buttonShot:DoClick()
    window:Close()
    net.Start("VBNET::Jobs::Police::Armory::GetWeapon")
    net.WriteInt(3, 8)
    net.SendToServer()
  end

  local buttonRif2 = CreateButtonAlt(window)
  buttonRif2:SetSize(window:GetWide() - 10, 25)
  buttonRif2:SetPos(5, 120)
  buttonRif2:SetText(Translate("pol_wep_arm_get_rif2"))
  function buttonRif2:DoClick()
    window:Close()
    net.Start("VBNET::Jobs::Police::Armory::GetWeapon")
    net.WriteInt(4, 8)
    net.SendToServer()
  end

end