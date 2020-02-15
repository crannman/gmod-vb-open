ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable    = true
ENT.PrintName	 = "Lamp"

function ENT:SetupDataTables()

    self:NetworkVar("Bool", 0, "State")
    self:NetworkVar("String", 0, "DTName")
    self:NetworkVar("String", 1, "DTDesc")
    self:NetworkVar("String", 2, "DTOwner")

end

function ENT:Initialize()

    self:SetState(false)

    if SERVER then
        self:SetModel("models/props_lab/desklamp01.mdl")
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_VPHYSICS)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetUseType(SIMPLE_USE)

        local phys = self:GetPhysicsObject()

        if (IsValid(phys)) then
            phys:Wake()
        end
    end

end