ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable    = true
ENT.PrintName	 = "License plate"

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTLicense")

  if SERVER then
    self:SetDTLicense("VBRP - 1337")
  end

end