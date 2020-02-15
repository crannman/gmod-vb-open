include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Draw()
  --self:DrawModel()
end

CreateClientConVar("vbrp_draw_trunk", "0", false, false)

function ENT:DrawTranslucent()
	if GetConVar("vbrp_draw_trunk"):GetInt() == 1 then
		self:DrawModel()
	end
	local alpha = self:DistanceToAlpha(0.4)
	if alpha > 0 and not LocalPlayer():InVehicle() then
		local icon = Either(self:GetDTLocked(), "lock", "lock_open")
		local mat = Material("verybadroleplay/icons/actions/" .. icon .. ".png", "noclamp")
		local pos = self:GetPos() - self:GetRight() * 10 + self:GetUp() * 2
		local angle = self:GetAngles()
		angle:RotateAroundAxis(angle:Up(), 180)
		angle:RotateAroundAxis(angle:Forward(), 90)
		cam.Start3D2D(pos + Vector(0, 0, 10) , angle, 0.1)
		
		surface.SetMaterial(mat)
		surface.SetDrawColor(255, 255, 255, alpha)
		surface.DrawTexturedRect(0, 0, 32, 32)
		
		cam.End3D2D()
	end
end