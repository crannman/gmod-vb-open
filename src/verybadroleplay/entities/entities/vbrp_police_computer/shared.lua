ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable     = true

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

  if SERVER then

    self:SetDTOwner("world")

  end

end