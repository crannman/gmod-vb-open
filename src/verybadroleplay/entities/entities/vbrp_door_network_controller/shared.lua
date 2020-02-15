ENT.Type         = "point"
ENT.Base         = "base_point"
ENT.Spawnable     = false

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")
  self:NetworkVar("Int", 0, "DTPrice")
end
