local groupMembers = {}
local friendsList = {}

local function isFriendWith(name)
  steamid = GetSteamIDFromPlayerName(name)
  if friendsList[steamid] then
    return true
  end
  return false
end

net.Receive("VBNET::Groups::SendMembers", function()

  groupMembers = net.ReadTable()
  ShowGroupMenu()

end)

net.Receive("VBNET::Friends::SendFriendsList", function(len, pl)

  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::Buddies")
  friendsList = net.ReadTable()
  if LocalPlayer():GetGroupName() ~= "VB-Default-Organization" then
    net.Start("VBNET::Groups::GetMembers")
    net.SendToServer()
  else
    ShowGroupMenu()
  end

end)

hook.Add("PlayerButtonDown", "ShowGroupMenu", function(ply, button)
  if button == KEY_F2 and IsFirstTimePredicted() then
    friendsList = {}
    net.Start("VBNET::Friends::FetchFriendsList")
    net.SendToServer()
  end
end)

function ShowGroupMenu()

  local windowW = ScrW() / 2 - 375
  local windowH = ScrH() / 2 - 225
  local window = CreateWindowFrame()
  window:SetSize(745, 450)
  window:SetTitle(Translate("op_window_title"))
  window:SetPos(windowW, windowH)
  window:ShowCloseButton(true)
  window:MakePopup()


  local propertySheet = vgui.Create("DPropertySheet", window)
  propertySheet:SetPos(5, 30)
  propertySheet:SetSize(window:GetWide() - 10, window:GetTall() - 35)

  function propertySheet:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_GREYBLUE)
  end

  local playerListPanel = vgui.Create("DPanel", propertySheet)

  function playerListPanel:Paint()
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_PANEL)
  end

  lvPlayerList = CreateListView(playerListPanel)
  lvPlayerList:AddColumn(Translate("op_player_name"))
  lvPlayerList:AddColumn(Translate("op_same_org"))
  lvPlayerList:AddColumn(Translate("op_are_friends"))
  lvPlayerList:Dock(FILL)
  for k, v in ipairs(player.GetAll()) do
    if v:IsRegistered() then
      lvPlayerList:AddLine(
        v:GetCompleteName(),
        Either(LocalPlayer():SameGroupAs(v), Translate("op_yes"), Translate("op_no")),
        Either(isFriendWith(v:GetCompleteName()), Translate("op_yes"), Translate("op_no"))
      )
    end
  end

  lvPlayerList:RefreshPaint()

  function lvPlayerList:OnRowSelected(rowIndex, row)
    local clickedPlayerName = lvPlayerList:GetLine(rowIndex):GetColumnText(1)
    if clickedPlayerName == LocalPlayer():GetCompleteName() then return end
    local ctxMenu = DermaMenu()

    if not LocalPlayer():SameGroupAs(clickedPlayerName) and LocalPlayer():GetGroupName() ~= "VB-Default-Organization" and Permission:Can(LocalPlayer():GetDTGroupPermissionMask(), Permission.INVITE) then
      ctxMenu:AddOption(
        Translate("op_invite_org"),
        function()
          net.Start("VBNET::Groups::InvitePlayerToGroup")
          net.WriteString(clickedPlayerName)
          net.WriteString(LocalPlayer():GetGroupName())
          net.SendToServer()
        end
      )
    end
    if not isFriendWith(clickedPlayerName) then
      ctxMenu:AddOption(
        Translate("op_add_friend"),
        function()
          local steamid = GetSteamIDFromPlayerName(clickedPlayerName)
          net.Start("VBNET::Friends::AddFriend")
          net.WriteString(steamid)
          net.SendToServer()
          friendsList[steamid] = true
          self:GetLine(rowIndex):SetColumnText(3, Translate("op_yes"))
        end
      )
    end
    if isFriendWith(clickedPlayerName) then
      ctxMenu:AddOption(
        Translate("op_rem_friend"),
        function()
          local steamid = GetSteamIDFromPlayerName(clickedPlayerName)
          net.Start("VBNET::Friends::RemoveFriend")
          net.WriteString(steamid)
          net.SendToServer()
          self:GetLine(rowIndex):SetColumnText(3, Translate("op_no"))
          friendsList[steamid] = nil
        end
      )
    end
    ctxMenu:Open()

  end
  propertySheet:AddSheet(Translate("op_player_list"), playerListPanel)

  if (LocalPlayer():GetGroupName() ~= "VB-Default-Organization") then

    local orgPanel = vgui.Create("DPanel", propertySheet)
    function orgPanel:Paint()
      draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_LIST_PANEL)
    end

    propertySheet:AddSheet(Translate("op_org"), orgPanel)


    lvOrgList = CreateListView(orgPanel)
    lvOrgList:AddColumn(Translate("op_player_name"))
    lvOrgList:AddColumn(Translate("op_are_friends"))
    lvOrgList:AddColumn(Translate("op_is_online"))
    lvOrgList:AddColumn(Translate("op_perms"))
    lvOrgList:Dock(FILL)
    lvOrgList:AddLine(
      LocalPlayer():GetCompleteName(),
      Translate("op_no"),
      Translate("op_yes"),
      table.concat(Permission:Decompose(LocalPlayer():GetDTGroupPermissionMask()), ", ")
    )
    for k, v in pairs(groupMembers) do
        lvOrgList:AddLine(
          k,
          Either(v.online and isFriendWith(k), Translate("op_yes"), Translate("op_no")),
          Either(v.online, Translate("op_yes"), Translate("op_no")),
          table.concat(Permission:Decompose(v.permissions), ", ")
        )
    end

    lvOrgList:RefreshPaint()

    function lvOrgList:OnRowSelected(rowIndex, row)
      local isLocal = false
      local clickedPlayerName = self:GetLine(rowIndex):GetColumnText(1)
      if clickedPlayerName == LocalPlayer():GetCompleteName() then
        isLocal = true
      end

      local ctxMenu = DermaMenu()

      if isLocal then
        ctxMenu:AddOption(
          Translate("op_quit_org"),
          function()
            net.Start("VBNET::Groups::PlayerQuitGroup")
            net.SendToServer()
            window:Close()
          end
        )
      else
        if Permission:Can(LocalPlayer():GetDTGroupPermissionMask(), Permission.KICK) then
          ctxMenu:AddOption(
            "Kick le joueur",
            function()
              net.Start("VBNET::Groups::KickPlayer")
              net.WriteString(clickedPlayerName)
              net.SendToServer()
            end
          )
        end
        if Permission:Can(LocalPlayer():GetDTGroupPermissionMask(), Permission.ADMIN) then
          ctxMenu:AddOption(
            Translate("op_change_perms"),
            function()
              ShowPermissionsMenu(window, clickedPlayerName, groupMembers[clickedPlayerName]["permissions"])
            end
          )
        end
        if groupMembers[clickedPlayerName].online and not isFriendWith(clickedPlayerName) then
          ctxMenu:AddOption(
            Translate("op_add_friend"),
            function()
              local steamid = GetSteamIDFromPlayerName(clickedPlayerName)
              net.Start("VBNET::Friends::AddFriend")
              net.WriteString(steamid)
              net.SendToServer()
              friendsList[steamid] = true
              self:GetLine(rowIndex):SetColumnText(2, Translate("op_yes"))
            end
          )
        end
        if groupMembers[clickedPlayerName].online and isFriendWith(clickedPlayerName) then
          ctxMenu:AddOption(
            Translate("op_rem_friend"),
            function()
              local steamid = GetSteamIDFromPlayerName(clickedPlayerName)
              net.Start("VBNET::Friends::RemoveFriend")
              net.WriteString(steamid)
              net.SendToServer()
              self:GetLine(rowIndex):SetColumnText(2, Translate("op_no"))
              friendsList[steamid] = nil
            end
          )
        end
      end
      ctxMenu:Open()

    end
  end

  for k, v in pairs(propertySheet.Items) do
    if not v.Tab then continue end
    function v.Tab:Paint()
      v.Tab:SetFont("VBFONT_DERMANORMAL")
      if v.Tab == propertySheet:GetActiveTab() then
        draw.RoundedBox(0, Either(v.Tab:GetText() == Translate("op_player_list"), 5, 0), 0, Either(v.Tab:GetText() == "op_player_list", self:GetWide() - 5, self:GetWide()), self:GetTall(), COLOR_LIST_PANEL)
      else
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_GREYBLUE)
      end
    end
  end

end