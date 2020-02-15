ENT.Type          = "anim"
ENT.Base          = "base_anim"
ENT.Spawnable     = true

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

  -- Energy to give when consumed
  self:NetworkVar("Float", 0, "DTEnergy")
  
  -- Should also act as an ingredient ?
  self:NetworkVar("Bool", 0, "DTIngredient")
end