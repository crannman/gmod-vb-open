function ShowPermissionsMenu(parent, name, mask)
  local window = vgui.Create("DFrame")
  local startTime = SysTime()
  window:SetSize(300, 150)
  window:SetTitle(Translate("op_perms"))
  window.lblTitle:SetFont("VBFONT_DERMANORMAL")
  window.lblTitle:SetColor(COLOR_WHITE)
  window:Center()
  window.Paint = function()
    Derma_DrawBackgroundBlur(window, startTime)
    draw.RoundedBoxEx(5, 1, 27, window:GetWide() - 2, window:GetTall() - 26, COLOR_MENU_BAR, false, false, true, true)
    draw.RoundedBoxEx(5, 1, 0, window:GetWide() - 2, 27, COLOR_MENU_BACK, true, true, false, false)
  end
  window:ShowCloseButton(true)
  window:MakePopup()
  local cbxInvite = vgui.Create("DCheckBoxLabel", window)
  local cbxKick = vgui.Create("DCheckBoxLabel", window)
  local cbxAdmin = vgui.Create("DCheckBoxLabel", window)

  cbxInvite.PermsValue = Permission.INVITE
  cbxInvite:SetText("Inviter un joueur")
  cbxInvite:SetValue(0)
  cbxInvite:SizeToContents()
  cbxInvite:SetPos(75, 35)
  function cbxInvite:OnChange(checked)
    if cbxAdmin:GetChecked() then
      cbxAdmin:SetChecked(false)
    end
  end

  cbxKick.PermsValue = Permission.KICK
  cbxKick:SetPos(75, 60)
  cbxKick:SetText("Kick un joueur")
  cbxKick:SetValue(0)
  cbxKick:SizeToContents()
  function cbxKick:OnChange(checked)
    if cbxAdmin:GetChecked() then
      cbxAdmin:SetChecked(false)
    end
  end

  cbxAdmin.PermsValue = Permission.ADMIN
  cbxAdmin:SetPos(75, 85)
  cbxAdmin:SetText("Administrateur du groupe")
  cbxAdmin:SetValue(0)
  cbxAdmin:SizeToContents()
  function cbxAdmin:OnChange(checked)
    if checked then
      cbxKick:SetChecked(true)
      cbxInvite:SetChecked(true)
    end
  end

  if Permission:Can(mask, Permission.ADMIN) then
    cbxAdmin:SetChecked(true)
    cbxKick:SetChecked(true)
    cbxInvite:SetChecked(true)
  else
    if Permission:Can(mask, Permission.INVITE) then
      cbxInvite:SetChecked(true)
    end
    if Permission:Can(mask, Permission.KICK) then
      cbxKick:SetChecked(true)
    end
  end

  local btnConfirm = CreateButtonAlt(window)
  btnConfirm:SetSize(200, 30)
  btnConfirm:SetPos(window:GetWide() / 2 - 100, 110)
  btnConfirm:SetText("Confirmer")
  function btnConfirm:DoClick()
    local perms = {}
    if cbxAdmin:GetChecked() then
      table.insert(perms, cbxAdmin.PermsValue)
    else
      if cbxKick:GetChecked() then
        table.insert(perms, cbxKick.PermsValue)
      end
      if cbxInvite:GetChecked() then
        table.insert(perms, cbxInvite.PermsValue)
      end
    end
    local bitMask = Permission:Pipe(unpack(perms))
    net.Start("VBNET::Groups::PlayerChangePermission")
    net.WriteString(name)
    net.WriteInt(bitMask, 9)
    net.SendToServer()
    window:Close()
    parent:Close()
    ClientsideNotify("Vous venez de modifier les permissions de " .. name)
  end
end