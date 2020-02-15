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
	
    local ent = ents.Create("upgr_ammo")
    ent:SetPos( tr.HitPos + tr.HitNormal * 16 ) 
    ent:Spawn()
    ent:Activate()
 
    return ent
end

function ENT:OnTakeDamage(dmginfo)
	self:GetPhysicsObject():AddVelocity(dmginfo:GetDamageForce() * 0.1)
end

local wep

function ENT:Use(activator, caller)
	if activator:IsPlayer() then
		wep = activator:GetActiveWeapon()
		am = wep:GetPrimaryAmmoType()
		
		if am != -1 then
			amc = activator:GetAmmoCount(am)
			
			if wep.Primary and wep.Primary.ClipSize then
				mag = wep:Clip1()
				
				if wep.Primary.ClipSize * 6 * (wep.MaxAmmoMod and wep.MaxAmmoMod or 1) + math.Clamp(wep.Primary.ClipSize - mag, 0, wep.Primary.ClipSize) > amc then
					activator:EmitSound("items/ammo_pickup.wav", 60, 100)
					
					ammo = math.Clamp(amc + (wep.Primary.ClipSize > 50 and wep.Primary.ClipSize / 2 or wep.Primary.ClipSize) * (wep.GiveAmmoMod and wep.GiveAmmoMod or 1), 0, wep.Primary.ClipSize * 6 * (wep.MaxAmmoMod and wep.MaxAmmoMod or 1) + math.Clamp(wep.Primary.ClipSize - mag, 0, wep.Primary.ClipSize))
					activator:SetAmmo(ammo, am)
				end
			end
		end
		
		cl = wep:GetClass()
		
		for k2, v2 in ipairs(activator:GetWeapons()) do
			am = v2:GetPrimaryAmmoType()
			amc = activator:GetAmmoCount(am)
			
			if amc == 0 and v2:Clip1() == 0 and cl != v2:GetClass() then
				if v2.Primary and v2.Primary.ClipSize then
					activator:SetAmmo(v2.Primary.ClipSize * 0.5, am)
				else
					activator:SetAmmo(15, am)
				end
			end
		end
		
		if wep.Secondary and wep.Secondary.Ammo != "none" and activator:GetAmmoCount(wep.Secondary.Ammo) < 6 then
			activator:GiveAmmo(1, wep.Secondary.Ammo)
		end
		self:Remove()
	end
end

function ENT:OnRemove()
return false
end 