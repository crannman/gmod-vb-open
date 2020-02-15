AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/items/healthkit.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
	self.CanHurt = true
	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
	
	self.HealthCharge = 200
	self.HealDelay = CurTime()
	timer.Simple(300, function()
		SafeRemoveEntity(self)
	end)
end

function ENT:Use()
return false
end

function ENT:OnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end

local hp

function ENT:Think()
	if SERVER then
		if CurTime() > self.HealDelay then
			for k, v in pairs(ents.FindInSphere(self:GetPos(), 96)) do
				if v:IsPlayer() and v:Alive() then
					if self.HealthCharge > 0 then
						hp = v:Health()
						
						if hp < v:GetMaxHealth() then
							v:SetHealth(hp + 1)
							self.HealthCharge = self.HealthCharge - 1
						end
					else
						SafeRemoveEntity(self)
					end
				end
			end
			self.HealDelay = CurTime() + 0.15
		end
	end
end

function ENT:OnRemove()
return false
end 