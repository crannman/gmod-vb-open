ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable    = true
ENT.PrintName	 = "ViewEntity"

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

  if SERVER then
    self:SetDTName("ViewEntity")
    self:SetDTDesc("DONT_SPAWN")
    self:SetDTOwner("world")
  end

end

function ENT:Initialize()

  if SERVER then
    self:SetModel("models/MaxOfS2D/camera.mdl")
    self:SetSolid(SOLID_NONE)
    self:SetPos(Vector(-3750, -4621, 904))
    self:SetAngles(Angle(20, 0, 0))
  end

end