AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Items/BoxMRounds.mdl") 
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	local phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end
end

function ENT:SpawnFunction( ply, tr )
    if ( !tr.Hit ) then return end
	
    local ent = ents.Create("upgr_gren_default")
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
    ent:Spawn()
    ent:Activate()
 
    return ent
end

function ENT:OnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end

local wep, f

function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		wep = activator:GetActiveWeapon()
		
		if IsValid(wep) then
			if wep.Attachments then
				f = false
				
				for i = 1, #wep.Attachments do
					for k, v in pairs(wep.Attachments[i]) do
						if v == "grenadelauncher" then
							f = true
						end
					end
				end
				
				if f and (wep.BlastRadius != 512 or wep.GrenadeType != "gren_explosive") then
					wep.GrenadeType = "gren_explosive"
					wep.BlastRadius = 512
					wep.BlastDamage = 90
					wep.Secondary.Ammo = "40MM_HE"
					
					umsg.Start("40MMTYPE", activator)
						umsg.Short(1)
					umsg.End()
					
					self:Remove()
				end
			end
		end
	end
end

function ENT:OnRemove()
return false
end 