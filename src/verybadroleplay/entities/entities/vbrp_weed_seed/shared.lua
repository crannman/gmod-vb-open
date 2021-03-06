ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable    = true
ENT.PrintName	 = "WeedSeed"

function ENT:SetupDataTables()

  self:NetworkVar("String", 0, "DTName")
  self:NetworkVar("String", 1, "DTDesc")
  self:NetworkVar("String", 2, "DTOwner")

end

function ENT:Initialize()

  if SERVER then
    self:SetModel("models/katharsmodels/contraband/zak_wiet/zak_seed.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()

    if IsValid(phys) then
      phys:Wake()
    end
  end

end