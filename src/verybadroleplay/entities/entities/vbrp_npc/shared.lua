AddCSLuaFile()
ENT.Base = "base_nextbot"
ENT.Spawnable = true

function ENT:SetupDataTables()

    self:NetworkVar("String", 0, "DTName")
    self:NetworkVar("String", 1, "DTDesc")
    self:NetworkVar("String", 2, "DTOwner")

    if SERVER then
        self:SetDTOwner("world")
    end
end

function ENT:UpdateTransmitState()
    return TRANSMIT_NEVER
end