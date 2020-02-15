ENT.Type         = "anim"
ENT.Base         = "base_anim"
ENT.Spawnable     = true

function ENT:SetupDataTables()
    
    self:NetworkVar("Int", 0, "DTAmount")
    self:NetworkVar("String", 0, "DTOwner")

end

function ENT:Initialize()

    if SERVER then
        self:SetModel("models/props/cs_assault/money.mdl")
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