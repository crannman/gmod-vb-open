--[[-------------------------------------------------------------------------
Inventory menu
---------------------------------------------------------------------------]]
local lastCall = nil
hook.Add("PlayerButtonDown", "ShowInventory", function(ply, button)
  if button == KEY_F1 and IsFirstTimePredicted() then
    if not lastCall then
      lastCall = CurTime() + 2
    elseif lastCall > CurTime() then
      ClientsideNotify("Wait a bit before reopening this menu!")
      return false
    else
      lastCall = nil
    end

    net.Start("VBNET::Inventory::HasOpenedInventory")
    net.SendToServer()
  end
end)

VBInventoryItem = { }
net.Receive("VBNET::Inventory::SendToPlayer", function(len, ply)
  VBRP.log(string.format("Received: %s", string.NiceSize(len / 8)), "VB-Framework::Inventory")
  local length = net.ReadUInt(16)
  local data = util.Decompress(net.ReadData(length))
  VBInventoryItem = util.JSONToTable(data)
  ShowInventory()
end)

local gradient = Material("gui/gradient_up")

local function sendInventoryRequest(item, type, action)
  action = action or nil
  type = type or nil
  if type == "Weapons" and action == "EQUIP" then
    net.Start("VBNET::Inventory::Weapons::RequestEquip")
    net.WriteString(item)
    net.SendToServer()
    return true
  end
  net.Start("VBNET::Inventory::" .. type .. "::RequestDrop")
  net.WriteString(item)
  net.SendToServer()
  return true
end

function ShowInventory()
  local cl = LocalPlayer()
  local window = CreateWindowFrame()
  window:SetSize(805, 450)
  window:Center()
  window:SetTitle(Translate("inv_window_title"))
  window:MakePopup()

  local pmPanel = vgui.Create("DPanel", window)
  pmPanel:SetPos(5, 25)
  pmPanel:SetSize(300, window:GetTall() - 30)

  pmPanel.Paint = function()
    draw.RoundedBox(5, 0, 0, pmPanel:GetWide(), pmPanel:GetTall(), COLOR_MENU_BAR)
  end

  local pModelPanel = VBVGUI:Create("BodyPanel", pmPanel)
  pModelPanel:SetSize(300, 300)

  local heavyWeaponPanel = vgui.Create("DPanel", pmPanel)
  heavyWeaponPanel:SetSize(pmPanel:GetWide() - 100, 80)
  heavyWeaponPanel:SetPos(5, 320)

  function heavyWeaponPanel:Paint()
    draw.RoundedBox(5, 0, 0, heavyWeaponPanel:GetWide(), heavyWeaponPanel:GetTall(), Color(0, 0, 0, 100))
  end

  local textHeavyWeapon = Label(Translate("inv_heavy_weapon"), pmPanel)
  textHeavyWeapon:SetFont("VBFONT_DERMANORMAL")
  textHeavyWeapon:SetTextColor(COLOR_WHITE)
  textHeavyWeapon:SetPos(5, 405)
  textHeavyWeapon:SizeToContents()

  if cl:HasHeavyWeapon() then
    local currentWeapon = cl:HeavyWeapon()
    local heavyWeaponModelPanel = VBVGUI:Create("WeaponModelPanel", heavyWeaponPanel)
    heavyWeaponModelPanel:SetPos(0, 0)
    heavyWeaponModelPanel:SetSize(heavyWeaponPanel:GetWide(), heavyWeaponPanel:GetTall())
    heavyWeaponModelPanel:SetWeapon(currentWeapon)
    heavyWeaponModelPanel.Window = window
  end

  local lightweightWeapon = vgui.Create("DPanel", pmPanel)
  lightweightWeapon:SetSize(80, 80)
  lightweightWeapon:SetPos(pmPanel:GetWide() - 85, 320)

  function lightweightWeapon:Paint()
    draw.RoundedBox(5, 0, 0, lightweightWeapon:GetWide(), lightweightWeapon:GetTall(), Color(0, 0, 0, 100))
  end

  local textLight = Label(Translate("inv_light_weapon"), pmPanel)
  textLight:SetFont("VBFONT_DERMANORMAL")
  textLight:SetTextColor(COLOR_WHITE)
  textLight:SetPos(pmPanel:GetWide() - 85, 405)
  textLight:SizeToContents()

  if cl:HasLightWeapon() then
    local currentWeapon = cl:LightWeapon()
    local lwWeaponModelPanel = VBVGUI:Create("WeaponModelPanel", lightweightWeapon)
    lwWeaponModelPanel:SetPos(0, 0)
    lwWeaponModelPanel:SetSize(lightweightWeapon:GetWide(), lightweightWeapon:GetTall())
    lwWeaponModelPanel:SetWeapon(currentWeapon)
    lwWeaponModelPanel.Window = window
  end

  local invPanel = vgui.Create("DPanel", window)
  invPanel:SetPos(310, 25)
  invPanel:SetSize(490, window:GetTall() - 30)

  local itemCategories = VBVGUI:Create("PropertySheet", invPanel)

  local market = VBVGUI:Create("ScrollableGridLayout", itemCategories)
  local weapons = VBVGUI:Create("ScrollableGridLayout", itemCategories)
  local ammunition = VBVGUI:Create("ScrollableGridLayout", itemCategories)
  local equipments = VBVGUI:Create("ScrollableGridLayout", itemCategories)
  local misc = VBVGUI:Create("ScrollableGridLayout", itemCategories)
  local cook = VBVGUI:Create("ScrollableGridLayout", itemCategories)
  local furnitures = VBVGUI:Create("ScrollableGridLayout", itemCategories)

  local categories = {
    ["FURNITURE"]  = { Name = Translate("inv_furniture"),  Panel = furnitures,
      F = function(item, panel, menu)
        menu:AddOption("Poser", function()
          if item.Quantity - 1 <= 0 then panel:Remove() else panel:SetQuantity(item.Quantity - 1) end
          sendInventoryRequest(item.Identifier, "Items")
        end)
      end
    },
    ["WEAPONS"]= { Name = Translate("inv_weapons"), Panel = weapons,
      F = function(item, panel, menu)
        menu:AddOption(Translate("inv_equip"), function()
          if LocalPlayer():HasHeavyWeapon() and IsVBHeavyWeaponFromIdentifier(item.Identifier) then ClientsideNotify(Translate("notify_already_have_hv_wep")) return false end
          if LocalPlayer():HasLightWeapon() and IsVBLightWeaponFromIdentifier(i) then ClientsideNotify(Translate("notify_already_have_lw_wep")) return false end
          if item.Quantity - 1 <= 0 then CreateProgressBar(Translate("inv_equip_weapon"), 2, Translate("inv_equip_weapon_status")) window:Close()
          else item.Quantity = item.Quantity - 1 panel:SetQuantity(item.Quantity)  CreateProgressBar(Translate("inv_equip_weapon"), 2, Translate("inv_equip_weapon_status")) window:Close() end
          sendInventoryRequest(item.Identifier, "Weapons", "EQUIP")
        end)
        menu:AddOption("Poser", function()
          if item.Quantity - 1 <= 0 then panel:Remove() else item.Quantity = item.Quantity - 1 panel:SetQuantity(item.Quantity)  end
          sendInventoryRequest(item.Identifier, "Weapons")
        end)
      end
    },
    ["AMMUNITION"] = { Name = Translate("inv_ammunition"), Panel = ammunition,
      F = function(item, panel, menu)
        menu:AddOption("Poser", function()
          if item.Quantity - 1 <= 0 then panel:Remove() else item.Quantity = item.Quantity - 1 panel:SetQuantity(item.Quantity)  end
          sendInventoryRequest(item.Identifier, "Entities")
        end)
      end
    },
    ["EQUIPMENTS"] = { Name = Translate("inv_equipments"), Panel = equipments,
      F = function(item, panel, menu)
        menu:AddOption("Poser", function()
          if item.Quantity - 1 <= 0 then panel:Remove() else item.Quantity = item.Quantity - 1 panel:SetQuantity(item.Quantity) end
          sendInventoryRequest(item.Identifier, "Entities")
        end)
      end
    },
    ["MARKET"] = { Name = Translate("inv_market"), Panel = market,
      F = function(item, panel, menu)
        menu:AddOption("Poser", function()
          if item.Quantity - 1 <= 0 then panel:Remove() else item.Quantity = item.Quantity - 1 panel:SetQuantity(item.Quantity)  end
          sendInventoryRequest(item.Identifier, "Entities")
        end)
      end
    },
    ["MISC"] = { Name = Translate("inv_misc"), Panel = misc,
      F = function(item, panel, menu)
        menu:AddOption("Poser", function()
          if item.Quantity - 1 <= 0 then panel:Remove() else item.Quantity = item.Quantity - 1 panel:SetQuantity(item.Quantity)  end
          sendInventoryRequest(item.Identifier, "Entities")
        end)
      end
    },
    ["COOKING"] = { Name = "Cuisine", Panel = cook,
      F = function(item, panel, menu)
        menu:AddOption("Poser", function()
        if item.Quantity - 1 <= 0 then panel:Remove() else item.Quantity = item.Quantity - 1 panel:SetQuantity(item.Quantity)  end
        net.Start("VBNET::Jobs::Cook::Ingredients::Drop")
        net.WriteString(item.Identifier)
        net.SendToServer()
        end)
      end
    },
  }

  itemCategories:AddSheet(categories["FURNITURE"]["Name"], furnitures.ScrollPanel)
  itemCategories:AddSheet(categories["MARKET"]["Name"], market.ScrollPanel)
  itemCategories:AddSheet(categories["WEAPONS"]["Name"], weapons.ScrollPanel)
  itemCategories:AddSheet(categories["AMMUNITION"]["Name"], ammunition.ScrollPanel)
  itemCategories:AddSheet(categories["EQUIPMENTS"]["Name"], equipments.ScrollPanel)
  itemCategories:AddSheet(categories["MISC"]["Name"], misc.ScrollPanel)
  itemCategories:AddSheet(categories["COOKING"]["Name"], cook.ScrollPanel)

  for k, v in SortedPairs(VBInventoryItem) do
    local item = VBVGUI:Create("InventoryModel", categories[v.Category]["Panel"].Layout)
    item:SetSize(80, 80)
    item:SetName(v.Name)
    item:SetModel(v.Model)
    item:SetDescription(v.Desc)
    item:SetQuantity(v.Quantity)
    item.Identifier = v.Identifier
    categories[v.Category]["Panel"]:Add(item)
    function item:DoClick()
      local menu = DermaMenu()
      categories[v.Category].F(v, item, menu)
      menu:Open()
    end
  end
end
