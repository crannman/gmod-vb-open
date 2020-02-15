function EFFECT:Init(ef)
	if IsValid(ef:GetEntity()) then
		self:SetPos(ef:GetOrigin())
		self.Emitter = ParticleEmitter(ef:GetOrigin())
		local ent = ef:GetEntity()
		local ply = ent:GetOwner()
		
		local model = ent.WElements["weapon"]
		
		local att
		
		if model then
			att = model.modelEnt:GetAttachment("1")
		else
			att = ent:GetAttachment("1")
		end
			
		if att then
			ParticleEffect(ent.SmokeEffect or "cstm_child_smoke_small", att.Pos, ply:EyeAngles(), att)
						
			if not ent.dt.Sil then
				ParticleEffect(ent.Muzzle or "cstm_child_muzzle_small", att.Pos, ply:EyeAngles(), att)
				ParticleEffect(ent.SparkEffect or "cstm_child_sparks_small", att.Pos, ply:EyeAngles(), att)
				
				local dlight = DynamicLight(self:EntIndex())
				dlight.Pos = att.Pos
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