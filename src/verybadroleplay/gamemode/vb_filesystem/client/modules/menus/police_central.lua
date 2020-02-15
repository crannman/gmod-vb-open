local create = vgui.Create
local fmt = string.format
local strftime = string.FormattedTime
local lv
local lv2
local lv3
local lb
function OpenPoliceCentralMenu(extended)

  if not VBJOB.GetJob(LocalPlayer()).Police then return false end

  local window = CreateWindowFrame()
  window:SetSize(800, 500)
  window:Center()
  window:SetTitle(Translate("pol_cen_title"))
  window:MakePopup()

  local pan = create("DPanel", window)
  pan:SetSize(window:GetWide() - 10, 200)
  pan:SetPos(5, 30)
  function pan:Paint() draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_BACK_PANEL) end

  local listView = CreateListView(pan)
  listView:Dock(FILL)
  listView:AddColumn(Translate("pol_cen_lst_name"))
  listView:AddColumn(Translate("pol_cen_lst_job"))
  for k, v in ipairs(player.GetHumans()) do
    if VBJOB.GetJob(v).Police then
      listView:AddLine(v:GetCompleteName(), Translate(VBJOB.GetJob(v).PrettyName))
    end
  end
  function listView:RefreshLayout()
    self:Clear()
    for k, v in ipairs(player.GetHumans()) do
      if VBJOB.GetJob(v).Police then
        self:AddLine(v:GetCompleteName(), Translate(VBJOB.GetJob(v).PrettyName))
      end
    end
    self:RefreshPaint()
  end
  listView:RefreshPaint()

  if LocalPlayer():IsPoliceChief() then
    function listView:OnRowSelected(rowId, row)
      if row:GetValue(1) == LocalPlayer():GetCompleteName() then return false end
      local menu = DermaMenu(row)
      menu:AddOption(Either(GetPlayerByName(row:GetValue(1)):Team() == TEAM_SWAT, "Retirer SWAT", "Ajouter SWAT"), function()
        net.Start("VBNET::Jobs::Police::Central::SetSWAT")
        net.WriteString(row:GetValue(1))
        net.SendToServer()
        listView:RefreshLayout()
      end)
      menu:AddOption("Kick", function()
        net.Start("VBNET::Jobs::Police::Central::Kick")
        net.WriteString(row:GetValue(1))
        net.SendToServer()
        listView:RefreshLayout()
      end)
      menu:AddOption("Blacklist (Futur)", function() return false end)
      menu:Open()
    end
  end

  local sheet = create("DPropertySheet", window)
  sheet:SetPos(5, 235)
  sheet:SetSize(window:GetWide() - 10, window:GetTall() - 240)
  function sheet:Paint() draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_SHEET_BACK) end

  local spanel1 = create("DPanel", window)
  sheet:AddSheet("Recherche de véhicule", spanel1)
  function spanel1:Paint() draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_SHEET_TAB_FOCUS) end
  
  local vehListView = CreateListViewAlt(spanel1)
  lv = vehListView
  vehListView:SetPos(sheet:GetWide() - window:GetWide() / 1.51 - 20, 5)
  vehListView:SetSize(window:GetWide() / 1.51, sheet:GetTall() - 70)
  vehListView:AddColumn(Translate("pol_cen_lst_veh_mdl"))
  vehListView:AddColumn(Translate("pol_cen_lst_pl_name"))
  vehListView:AddColumn(Translate("pol_cen_lst_veh_license")):SetFixedWidth(100)
  vehListView:AddColumn(Translate("pol_cen_lst_veh_clr")):SetFixedWidth(110)
  vehListView:RefreshPaint()

  local lblSearchPlVeh = create("DLabel", spanel1)
  lblSearchPlVeh:SetPos(5, 10)
  lblSearchPlVeh:SetTextColor(COLOR_WHITE)
  lblSearchPlVeh:SetFont("VBFONT_DERMANORMAL")
  lblSearchPlVeh:SetText("Rechercher les véhicules d'une personne")
  lblSearchPlVeh:SizeToContents()

  local textName = CreateTextEntry(spanel1, "VBFONT_DERMANORMAL")
  textName:SetPos(5, 30)
  textName:SetSize(lblSearchPlVeh:GetWide(), 25)
  textName:SetPlaceholderText("Prénom nom")

  local btnSearchPlVeh = CreateButtonAlt(spanel1)
  btnSearchPlVeh:SetPos(5, 60)
  btnSearchPlVeh:SetSize(lblSearchPlVeh:GetWide(), 25)
  btnSearchPlVeh:SetText("Rechercher")

  function btnSearchPlVeh:DoClick()

    if textName:GetText() ~= "" then
      lup = textName:GetText()
      net.Start("VBNET::Jobs::Police::Central::SearchPlayerVehiclesInDB")
      net.WriteString(textName:GetText())
      net.SendToServer()
    end
  end

  local lblSearchByLicense = create("DLabel", spanel1)
  lblSearchByLicense:SetPos(5, 100)
  lblSearchByLicense:SetTextColor(COLOR_WHITE)
  lblSearchByLicense:SetFont("VBFONT_DERMANORMAL")
  lblSearchByLicense:SetText("Rechercher un véhicule à partir de \nla plaque d'immatriculation")
  lblSearchByLicense:SizeToContents()

  local textLicense = CreateTextEntry(spanel1, "VBFONT_DERMANORMAL")
  textLicense:SetPos(5, 135)
  textLicense:SetSize(lblSearchPlVeh:GetWide(), 25)
  textLicense:SetPlaceholderText("Plaque d'immatriculation")

  local btnSearchVehLic = CreateButtonAlt(spanel1)
  btnSearchVehLic:SetPos(5, 165)
  btnSearchVehLic:SetSize(lblSearchPlVeh:GetWide(), 25)
  btnSearchVehLic:SetText("Rechercher")

  function btnSearchVehLic:DoClick()

    if textLicense:GetText() ~= "" then
      lup = textLicense:GetText()
      net.Start("VBNET::Jobs::Police::Central::SearchByLicense")
      net.WriteString(textLicense:GetText())
      net.SendToServer()
    end
  end

  local lblRecordFound = create("DLabel", spanel1)
  lb = lblRecordFound
  lblRecordFound:SetPos(lblSearchPlVeh:GetWide() + 20, sheet:GetTall() - 60)
  lblRecordFound:SetTextColor(COLOR_WHITE)
  lblRecordFound:SetFont("VBFONT_DERMANORMAL")
  lblRecordFound:SetText("")
  lblRecordFound:SizeToContents()

  local spanel2 = create("DPanel", window)
  local tab = sheet:AddSheet("Véhicules déployés", spanel2)
  function spanel2:Paint() draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_SHEET_TAB_FOCUS) end
  
  local deployedVehListView = CreateListViewAlt(spanel2)
  lv2 = deployedVehListView
  deployedVehListView:AddColumn(Translate("pol_cen_lst_pl_name"))
  deployedVehListView:AddColumn(Translate("pol_cen_lst_veh_license"))
  deployedVehListView:SetPos(5, 5)
  deployedVehListView:SetSize(sheet:GetWide() - 25, sheet:GetTall() - 46)
  deployedVehListView:RefreshPaint()
  function sheet:OnActiveTabChanged(old, new)
    if new == tab["Tab"] then
      net.Start("VBNET::Jobs::Police::Central::GetDeployedVehicles")
      net.SendToServer()
    end
  end

  if extended then
    local spanel3 = create("DPanel", window)
    local tab2 = sheet:AddSheet("Gestion de la prison", spanel3)
    function spanel3:Paint() draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_SHEET_TAB_FOCUS) end
    local prisonerListView = CreateListViewAlt(spanel3)
    lv3 = prisonerListView
    prisonerListView:AddColumn(Translate("pol_cen_lst_pl_name"))
    prisonerListView:AddColumn(Translate("pol_cen_lst_arby"))
    prisonerListView:AddColumn(Translate("pol_cen_lst_hrst"))
    prisonerListView:AddColumn(Translate("pol_cen_lst_hren"))
    prisonerListView:SetPos(5, 5)
    prisonerListView:SetSize(sheet:GetWide() - 25, sheet:GetTall() - 46)
    prisonerListView:RefreshPaint()
    function prisonerListView:OnRowSelected(rowId, row)
      local menu = DermaMenu(row)
      menu:AddOption(Translate("pol_cen_menu_unarrest"), function()
        net.Start("VBNET::Jobs::Police::Central::UnarrestPlayer")
        net.WriteString(row:GetValue(1))
        net.SendToServer()
        sheet:OnActiveTabChanged(nil, tab2["Tab"])
      end)
      menu:Open()
    end
    function sheet:OnActiveTabChanged(old, new)
      if new == tab["Tab"] then
        net.Start("VBNET::Jobs::Police::Central::GetDeployedVehicles")
        net.SendToServer()
      end
      if new == tab2["Tab"] then
        net.Start("VBNET::Jobs::Police::Central::GetPrisonData")
        net.SendToServer()
      end
    end
  end


  for k, v in pairs(sheet.Items) do
    if not v.Tab then continue end
    function v.Tab:Paint()
      v.Tab:SetFont("VBFONT_DERMANORMAL")
      if v.Tab == sheet:GetActiveTab() then
        draw.RoundedBox(0, Either(v.Tab:GetText() == "Recherche de véhicule", 5, 0), 0, Either(v.Tab:GetText() == "Recherche de véhicule", self:GetWide() - 5, self:GetWide()), self:GetTall(), COLOR_SHEET_TAB_FOCUS)
      else
        draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), COLOR_SHEET_BACK)
      end
    end
  end

end

net.Receive("VBNET::Jobs::Police::Central::SendCentralData", function (len)

  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::PoliceCentral")
  local payload = net.ReadTable()
  lv:Clear()
  if not table.IsEmpty(payload) then
    for k, v in ipairs(payload) do
      lv:AddLine(v.Name, lup, v.License, string.format("[%d, %d, %d]", v.Color.r, v.Color.g, v.Color.b))
    end
    lb:SetText(fmt("Enregistrements trouvés: %d pour %s", #payload, lup))
    lb:SetTextColor(COLOR_GREEN)
    lb:SizeToContents()
    lv:RefreshPaint()
  else
    lb:SetText(fmt("Aucun enregistrement trouvé pour %s", lup))
    lb:SetTextColor(COLOR_RED)
    lb:SizeToContents()
  end

end)

net.Receive("VBNET::Jobs::Police::Central::SendDeployedVehicles", function (len)
  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::PoliceCentral")
  local tbl = net.ReadTable()
  lv2:Clear()
  for k, v in ipairs(tbl) do
    lv2:AddLine(v.Owner, v.License)
  end
  lv2:RefreshPaint()
end)

net.Receive("VBNET::Jobs::Police::Central::SendPrisonData", function(len)
  
  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::PoliceCentral")
  local payload = net.ReadTable()
  lv3:Clear()
  for k, v in ipairs(payload) do
    lv3:AddLine(v["Name"], v["ArrestedBy"], os.date("%H:%M:%S", v["StartTime"]), os.date("%H:%M:%S", v["EndTime"]))
  end
  lv3:RefreshPaint()
end)