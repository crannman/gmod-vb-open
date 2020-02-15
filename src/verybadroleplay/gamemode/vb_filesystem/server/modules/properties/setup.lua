--[[-------------------------------------------------------------------------
Properties Manager
---------------------------------------------------------------------------]]
RealEstateAgencies = {
  ["Francois Maqueraux"] = {
    Category = "PrivateHouse"
  },
  ["Pierre Aglou"] = {
    Category = "Hotel"
  },
  ["Martin Blake"] = {
    Category = "Industrial"
  },
  ["Olivia Bach"] = {
    Category = "Market"
  }
}
VBRP_Properties = {
  [1] = {
    Name = "Flea Market",
    isBuyable = false,
    doorsGroup = { 2989, 2988 },
    Price = 0,
    Category = "unavailable"
  },
  [2] = {
    Name = "Magasin A",
    isBuyable = true,
    doorsGroup = { 3376, 3387 },
    Price = 1000,
    Category = "Market"
  },
  [3] = {
    Name = "Administration Building",
    isBuyable = false,
    doorsGroup = { 2697, 2696, 2486, 2695 },
    Price = 0,
    Category = "unavailable"
  },
  [4] = {
    Name = "Room A",
    isBuyable = true,
    doorsGroup = { 2262, 2297 },
    Price = 350,
    Category = "Hotel"
  },
  [5] = {
    Name = "Room B",
    isBuyable = true,
    doorsGroup = { 2261, 2292 },
    Price = 350,
    Category = "Hotel"
  },
  [6] = {
    Name = "Room C",
    isBuyable = true,
    doorsGroup = { 2263, 2296 },
    Price = 350,
    Category = "Hotel"
  },
  [7] = {
    Name = "Room D",
    isBuyable = true,
    doorsGroup = { 2264, 2293 },
    Price = 350,
    Category = "Hotel"
  },
  [8] = {
    Name = "Room E",
    isBuyable = true,
    doorsGroup = { 2265, 2295 },
    Price = 350,
    Category = "Hotel"
  },
  [9] = {
    Name = "Room F",
    isBuyable = true,
    doorsGroup = { 2266, 2294 },
    Price = 350,
    Category = "Hotel"
  },
  [10] = {
    Name = "Tides Hotel",
    isBuyable = false,
    doorsGroup = { 2183, 2182, 2185, 2184 },
    Price = 0,
    Category = "unavailable"
  },
  [11] = {
    Name = "Bank",
    isBuyable = false,
    doorsGroup = { 2812, 2813, 2820 },
    Price = 0,
    Category = "unavailable"
  },
  [12] = {
    Name = "Magasin B",
    isBuyable = true,
    doorsGroup = { 3481 },
    Price = 750,
    Category = "Market"
  },
  [13] = {
    Name = "Magasin C",
    isBuyable = true,
    doorsGroup = { 3371 },
    Price = 750,
    Category = "Market"
  },
  [14] = {
    Name = "Real Estate Agency",
    isBuyable = false,
    doorsGroup = { 3377 },
    Price = 0,
    Category = "unavailable"
  },
  [15] = {
    Name = "Clothes shop",
    isBuyable = false,
    doorsGroup = { 2985, 2984 },
    Price = 0,
    Category = "unavailable"
  },
  [16] = {
    Name = "Gas station",
    isBuyable = false,
    doorsGroup = { 2808, 2807 },
    Price = 0,
    category = "unavailable"
  },
  [17] = {
    Name = "Burger King",
    isBuyable = true,
    doorsGroup = { 2806, 2805, 1429 },
    Price = 2500,
    Category = "Market"
  }
}
-- @desc Enregistre les propriétés sur le serveur;
-- @realm Server;
function RegisterProperties()
  for _, properties in pairs(VBRP_Properties) do
    VBRP.log("Registered new property: " .. properties["Name"], "VB-Framework::Properties")
    for _, v in pairs(properties["doorsGroup"]) do
      local entity = ents.GetMapCreatedEntity(v)
      local controller = ents.Create("vbrp_door_network_controller")
      controller:SetPos(entity:GetPos())
      controller:SetDTName(properties["Name"])
      controller:SetDTOwner("world")
      if properties["isBuyable"] then
        controller:SetDTPrice(properties["Price"])
        entity:Fire("Lock")
      end
      controller:Spawn()
      controller:SetParent(entity)
    end
  end
end

hook.Add("VBHOOK::Internal::RegisterProperties", "VBHOOK::RegisterProperties", RegisterProperties)