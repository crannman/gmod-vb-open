ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable    = true
ENT.PrintName	 = "Vehicle Trunk"


function ENT:SetupDataTables()

  self:NetworkVar("Bool", 0, "DTLocked")
  
  if SERVER then
    self:SetDTLocked(true)
  end
end

