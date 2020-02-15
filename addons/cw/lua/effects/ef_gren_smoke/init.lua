function EFFECT:Init(ef)
	self:SetPos(ef:GetOrigin())
	self.Emitter = ParticleEmitter(ef:GetOrigin())
	
	for i = 1, 15 do
		local part = self.Emitter:Add("particle/smokesprites_000" .. math.random(1, 9), ef:GetOrigin() + VectorRand() * 128)
		part:SetStartSize(256)
		part:SetEndSize(384)
		part:SetStartAlpha(255)
		part:SetEndAlpha(0)
		part:SetDieTime(15)
		part:SetRoll(math.random(0, 360))
		part:SetRollDelta(0.01)
		part:SetColor(200, 200, 200)
		part:SetLighting(false)
		part:SetVelocity(VectorRand() * 10)
	end
	
	self.DieTime = CurTime() + 15
end

function EFFECT:Think()
	if CurTime() > self.DieTime then
		self.Emitter:Finish()
		return false
	else
		return true
	end
end

function EFFECT:Render()
end