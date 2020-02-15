include("shared.lua")
function ENT:Draw()

    self:DrawModel()

end

function ENT:Think()
	local DynLight = DynamicLight(self:EntIndex())
	if DynLight and self:GetState() then
		DynLight.pos = self:GetPos()
		DynLight.r = 255
		DynLight.g = 255
		DynLight.b = 255
		DynLight.brightness = 2
		DynLight.decay = 1000
		DynLight.size = 256
		DynLight.dietime = CurTime() + 1
	end

end