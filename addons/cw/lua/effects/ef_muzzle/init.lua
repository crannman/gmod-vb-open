function EFFECT:Init(ef)
	if IsValid(ef:GetEntity()) then
		self:SetPos(ef:GetOrigin())
		self.Emitter = ParticleEmitter(ef:GetOrigin())
		local ent = ef:GetEntity()
		local ply = ent:GetOwner()
		local att = ent:GetAttachment("1")
		
		if att then
			local finalpos = att.Pos
			
			ParticleEffect(ent.SmokeEffect or "cstm_child_smoke_small", finalpos, ply:EyeAngles(), att)
						
			if not ent.dt.Sil then
				ParticleEffect(ent.SparkEffect or "cstm_child_sparks_pistol", finalpos, ply:EyeAngles(), att)
				ParticleEffect(ent.Muzzle or "cstm_child_muzzle_small", finalpos, ply:EyeAngles(), att)
				
				local dlight = DynamicLight(self:EntIndex())
				dlight.Pos = finalpos
				dlight.r = 255
				dlight.g = 170
				dlight.b = 0
				dlight.Brightness = 1
				dlight.Size = 32
				dlight.Decay = 128
				dlight.DieTime = CurTime() + 0.1
			end
		end
	end
	
	self.DieTime = CurTime() + 0.01
end

function EFFECT:Think()
	if not IsValid(self.Emitter) then
		return false
	end
	
	if CurTime() > self.DieTime then
		self.Emitter:Finish()
		return false
	else
		return true
	end
end

function EFFECT:Render()
end