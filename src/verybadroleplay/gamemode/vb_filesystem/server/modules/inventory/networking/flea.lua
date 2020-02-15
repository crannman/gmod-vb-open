util.AddNetworkString("VBNET::Inventory::Flea::RetrieveItems")
util.AddNetworkString("VBNET::Inventory::Flea::SendItems")
util.AddNetworkString("VBNET::Inventory::Flea::BuyItem")
util.AddNetworkString("VBNET::Inventory::Flea::CannotBuyItem")

net.Receive("VBNET::Inventory::Flea::RetrieveItems", function(len, pl)

  local table = { }
  for k, v in pairs(VBCLASS_ITEM.Items) do
    if v["IsBuyableFromFlea"] then
      table[k] = v
    end
  end
  local data = util.Compress(util.TableToJSON(table))
  local length = data:len()

  net.Start("VBNET::Inventory::Flea::SendItems")
  net.WriteUInt(length, 16)
  net.WriteData(data, length)
  net.Send(pl)

end)

net.Receive("VBNET::Inventory::Flea::BuyItem", function(len, pl)

  local identifier = net.ReadString()
  local quantity = net.ReadInt(16)
  if quantity < 0 then return end
  local t = VBCLASS_ITEM:GetItemProperties(identifier)
  local price = t["MarketPrice"] * quantity

  if pl:CanAfford(price) then
    pl:UpdateMoney(price, "sub")
    pl:UpdateInventory(identifier, "add", quantity)
  else
    net.Start("VBNET::Inventory::Flea::CannotBuyItem")
    net.Send(ply)
  end

end)
