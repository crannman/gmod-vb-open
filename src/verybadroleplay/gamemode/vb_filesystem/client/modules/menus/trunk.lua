local create = vgui.Create
local recv = net.Receive
local rdEntity = net.ReadEntity
local rdTab = net.ReadTable
local ipairs = ipairs

recv("VBNET::Car::Trunk::Open", function()

	local entity = rdEntity()
	local items = rdTab()
	OpenTrunkMenu(items, entity)

end)

recv("VBNET::Jobs::Police::Trunk::Open", function()

	local entity = rdEntity()
	local items = rdTab()
	OpenPoliceTrunkMenu(items, entity)

end)

function OpenTrunkMenu(items, entity)

  local window = CreateWindowFrame()
  window:SetSize(345, 115)
  window:Center()
  window:SetTitle("veh_trunk")
  window:MakePopup()
  window:ShowCloseButton(true)

  local scrollPanel = create("DScrollPanel", window)
  scrollPanel:Dock(FILL)
  scrollPanel:GetVBar():SetWidth(0)

  local layout = create("DIconLayout", scrollPanel)
  layout:Dock(FILL)
  layout:SetSpaceX(5)
  layout:SetSpaceY(5)
  layout.Items = {}
  for k, v in ipairs(items) do
    local item = layout:Add(VBItemModel(v.Model, v.Name, v.Desc))
    layout.Items[k] = item
    function item:DoClick()
      local index = -1
      for idx, pan in ipairs(layout.Items) do
        if pan == self then
          index = idx
          break
        end
      end
      net.Start("VBNET::Car::Trunk::RemoveItem")
      net.WriteEntity(entity)
      net.WriteInt(index, 8)
      net.SendToServer()
      self:Remove()
      table.remove(items, index)
      table.remove(layout.Items, index)
    end
  end


end

function OpenPoliceTrunkMenu(items, entity)

  local window = CreateWindowFrame()
  window:SetSize(345, 115)
  window:Center()
  window:SetTitle("veh_trunk")
  window:MakePopup()
  window:ShowCloseButton(true)

  local scrollPanel = create("DScrollPanel", window)
  scrollPanel:Dock(FILL)
  scrollPanel:GetVBar():SetWidth(0)

  local layout = create("DIconLayout", scrollPanel)
  layout:Dock(FILL)
  layout:SetSpaceX(5)
  layout:SetSpaceY(5)
  layout.Items = {}

  for k, v in ipairs(items) do
    local item = layout:Add(VBItemModel(v.Model, v.Name, v.Desc))
    layout.Items[k] = item
    function item:DoClick()
      local index = -1
      for idx, pan in ipairs(layout.Items) do
        if pan == self then
          index = idx
          break
        end
      end
      net.Start("VBNET::Jobs::Police::Trunk::SpawnItem")
      net.WriteEntity(entity)
      net.WriteInt(index, 8)
      net.SendToServer()
      window:Remove()
    end
  end

end