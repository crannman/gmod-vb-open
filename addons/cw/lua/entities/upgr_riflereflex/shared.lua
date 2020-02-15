ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Rifle reflex"
ENT.Author = "L337N008"
ENT.Information = [[A reflex sight for rifles.]]
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "CW Weapon Attachments"

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

end