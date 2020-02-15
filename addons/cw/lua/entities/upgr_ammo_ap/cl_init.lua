include("shared.lua")

function ENT:Initialize()
end

function ENT:Draw()
	self:DrawModel()

	local name = self:GetDTName()
	local alpha = self:DistanceToAlpha(1)
	if alpha > 0  then
	local ang = Angle(0, RealTime() * 80, 0)
	local pos = self:GetPos() + ang:Up()
	ang:RotateAroundAxis( ang:Forward(), 90 )
	ang:RotateAroundAxis( ang:Right(), 90 )
	local maxs = self:OBBMaxs()
	local mins = self:OBBMins()
	local height = maxs.Z - mins.Z

	cam.Start3D2D(pos + Vector(0, 0, height + 12), Angle( 0, ang.y, 90 ), 0.05)
			draw.DrawText("Munitions", "VBFONT_3D2DTEXT", 0, 0, Color(255, 255, 255, alpha ), 1 )
			draw.DrawText(name, "VBFONT_3D2DTEXT", 0, 60, Color(212, 42, 90, alpha ), 1 )
	cam.End3D2D()

	ang:RotateAroundAxis( ang:Right(), 180 )

	cam.Start3D2D(pos + Vector(0, 0, height + 12), Angle( 0, ang.y, 90 ), 0.05)
			draw.DrawText("Munitions", "VBFONT_3D2DTEXT", 0, 0, Color(255, 255, 255, alpha ), 1 )
			draw.DrawText(name, "VBFONT_3D2DTEXT", 0, 60, Color(212, 42, 90, alpha ), 1 )
	cam.End3D2D()
	end

end

function ENT:Think()
end 