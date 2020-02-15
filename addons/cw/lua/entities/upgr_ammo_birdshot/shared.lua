ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Birdshot ammo"
ENT.Author = "Spy"
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "CW Ammo types"

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

end