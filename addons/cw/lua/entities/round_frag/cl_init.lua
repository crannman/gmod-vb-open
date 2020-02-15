include("shared.lua")

function ENT:Initialize()
	self.ParticleTime = 0
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if CurTime() > self.ParticleTime then
		local forward = self:GetForward()
		ParticleEffect("cstm_frag_fly", self:GetPos(), self:GetAngles(), nil)
		self.ParticleTime = CurTime() + 0.015
	end
		
	local dlight = DynamicLight(self:EntIndex())
		
	if dlight then
		dlight.Pos = self:GetPos()
		dlight.r = 255
		dlight.g = 255
		dlight.b = 100
		dlight.Brightness = 2
		dlight.Size = 128
		dlight.Decay = 128 * 3
		dlight.DieTime = CurTime() + 0.1
	end
end 