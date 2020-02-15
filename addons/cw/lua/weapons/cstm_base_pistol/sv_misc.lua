local CT, nade, EA, phys, cl
local trace, tr = {}, {}

function SWEP:Melee(ply, wep)
	if wep.Safe then
		return
	end
	
	if wep.ReloadTime then
		return
	end
	
	CT = CurTime()
	
	if CT < wep.MeleeDelay then
		return
	end
	
	wep:SetDTInt(3, 15)
	
	wep.MeleeDelay = CT + 0.5
	wep.ReloadDelay = CT + 0.5
	wep.AttachDelay = CT + 0.5
	wep:SetNextPrimaryFire(CT + 0.5)
	wep:SetNextSecondaryFire(CT + 0.5)
	
	ply:EmitSound("npc/fast_zombie/claw_miss1.wav", 80, 100)
	ply:ViewPunch(Angle(-5, 10, 0))
	ply:DoAnimationEvent(ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND)
	
	timer.Simple(0.1, function()
		if not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
			return
		end
		
		tr.start = ply:GetShootPos()
		tr.endpos = tr.start + ply:GetAimVector() * 50
		tr.filter = ply
		tr.mins = Vector(-8, -8, -8)
		tr.maxs = Vector(8, 8, 8)
		
		trace = util.TraceHull(tr)
		
		if trace.Hit then
			ent = trace.Entity
			physobj = ent:GetPhysicsObject()
			cl = ent:GetClass()
			
			if physobj:IsValid() then
				physobj:AddVelocity(ply:GetAimVector() * 250)
			end
				
			if ent:IsPlayer() or ent:IsNPC() then
				ent:TakeDamage(math.random(wep.MeleeDamageMin, wep.MeleeDamageMax), ply, ply)
				
				if ent:IsNPC() then
					ent:SetVelocity(ply:GetForward() * 2000)
				end
			else
				ent:TakeDamage(math.random(wep.MeleeDamageMin, wep.MeleeDamageMax) * 2, ply, ply)
				
				if cl == "func_breakable_surf" then
					ent:Input("Shatter", NULL, NULL, "")
					ply:EmitSound("physics/glass/glass_impact_bullet" .. math.random(1, 3) .. ".wav", 80, math.random(95, 105))
				end
			end
			
			ply:EmitSound("physics/body/body_medium_impact_hard" .. math.random(1, 6) .. ".wav", 80, 100)
			ply:EmitSound("physics/metal/weapon_impact_soft" .. math.random(1, 3) .. ".wav", 80, 100)
		end
		
	end)
	
	timer.Simple(0.25, function()
		if not IsValid(wep) or not ply:Alive() or ply:GetActiveWeapon():GetClass() != wep:GetClass() then
			return
		end
		
		wep:SetDTInt(3, 0)
	end)
end

concommand.Add("cstm_melee", function(ply)
	wep = ply:GetActiveWeapon()
	
	if wep.IsCSTMWeapon and wep:GetDTInt(3) == 0 then
		wep:Melee(ply, wep)
	end
end)

function SWEP:QuickGrenade()
	CT = CurTime()
	
	self:SetDTInt(3, 6)
	self.Cooking = true
	
	timer.Simple(0.6, function()
		if not IsValid(self) or not IsValid(self.Owner) or not self.Owner:Alive() then
			return
		end
		
		if self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos) > 30 then
			if IsValid(self.Owner) and IsValid(self) and self == self.Owner:GetActiveWeapon() then
				SendUserMessage("CSTM_QUICKNADE1", self.Owner)
				
				timer.Simple(0.4, function()
					if IsValid(self.Owner) and IsValid(self) and self == self.Owner:GetActiveWeapon() then
						self.CookTime = CurTime() + self.Owner.FuseTime
					end
				end)
			end
		else
			self.CookTime = nil
			self.Cooking = false
			self:EmitSound("weapons/cstm/holster" .. math.random(1, 4) .. ".wav", 65, 100)
			self:SetDTInt(3, 0)
			self:SetNextPrimaryFire(CT + 0.2)
			self:SetNextSecondaryFire(CT + 0.2)
			self.ReloadDelay = CT + 0.2
			self.HolsterTime = CT + 0.2
		end
	end)
end

function SWEP:SetFuseTime()
	self.Owner.FuseTime = self.Owner.FuseTime < 5 and self.Owner.FuseTime + 0.5 or 1
	
	umsg.Start("CSTM_FUSETIME", self.Owner)
		umsg.Float(self.Owner.FuseTime)
	umsg.End()
end