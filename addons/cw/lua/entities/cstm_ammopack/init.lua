AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Items/BoxMRounds.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.CanHurt = true
	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self.HP = 50
	self.Caliber = "9x19MM"
	self.Amount = 20
end

function ENT:SpawnFunction(ply, tr)
    if (!tr.Hit) then return end
	
    local ent = ents.Create("cstm_ammopack")
    ent:SetPos(tr.HitPos + tr.HitNormal * 16) 
    ent:Spawn()
    ent:Activate()
 
    return ent
end

function ENT:Use()
	return false
end

local dmg, wep, am, amc, cl, ammo, ED, pos, mag

function ENT:OnTakeDamage(dmginfo)
	if self.Exploded then
		return
	end
	
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.02)
	
	dmg = dmginfo:GetDamage()
	self.HP = self.HP - dmg
	
	if self.HP <= 0 then
		self.Exploded = true
		
		pos = self:GetPos()
		util.BlastDamage(dmginfo:GetInflictor(), dmginfo:GetAttacker(), pos + Vector(0, 0, 32), 384, 50)
		
		ED = EffectData()
		ED:SetOrigin(pos)
		ED:SetScale(1)
		
		util.Effect("Explosion", ED)
		SafeRemoveEntity(self)
	end
end

function ENT:OnRemove()
return false
end

function ENT:Use(activator, caller)
	activator:GiveAmmo(self.Amount, self.Caliber)
	self:Remove()
end
