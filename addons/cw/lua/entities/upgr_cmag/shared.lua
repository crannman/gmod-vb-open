ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Beta C-magazine"
ENT.Author = "L337N008"
ENT.Information = [[A Beta C-magazine.
Ammo in mag gets increased to 100 rounds.
Reload speed decreased to 80%]]
ENT.Spawnable = true
ENT.AdminSpawnable = true 
ENT.Category = "CW Weapon Attachments"

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

end