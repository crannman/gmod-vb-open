ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable     = true

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

  self:NetworkVar("Bool", 0, "DTPlate1")
  self:NetworkVar("Bool", 1, "DTPlate2")
  self:NetworkVar("Bool", 2, "DTPlate3")
  self:NetworkVar("Bool", 3, "DTPlate4")

  self:NetworkVar("Int", 0, "DTAvailablePlates")

  if SERVER then
    self:SetDTPlate1(true)
    self:SetDTPlate2(true)
    self:SetDTPlate3(true)
    self:SetDTPlate4(true)
    self:SetDTAvailablePlates(4)
  end

end

