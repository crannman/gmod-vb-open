ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable    = true
ENT.PrintName	 = "Light"

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")
  self:NetworkVar("String", 3, "DTLightIdentifier")
  self:NetworkVar("Bool", 0, "DTState")

  if SERVER then
    self:SetDTName("VBLight")
    self:SetDTDesc("DONT_SPAWN_FROM_CREATE_ENTITY")
    self:SetDTOwner("world")
  end

end

function ENT:Initialize()
  -- Vector(-3770, -4621, 924)
  if SERVER then
    self:SetModel("models/maxofs2d/light_tubular.mdl")
    self:SetSolid(SOLID_NONE)
  end

end