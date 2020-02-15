include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:DrawTranslucent()
  -- self:DrawModel()
	if self:GetParent() and IsValid(self:GetParent()) then
		local ang = self:GetParent():GetAngles()
		local pos = self:GetPos()
		ang:RotateAroundAxis(ang:Forward(), 90)
		local w, h = surface.GetTextSize(self:GetDTLicense())

		cam.Start3D2D(pos, ang, 0.08)
		surface.SetFont("VBFONT_LICENSE_PLATE")
		draw.WordBox(0, -(surface.GetTextSize(self:GetDTLicense()) / 2 + 3), -8, self:GetDTLicense(), "VBFONT_LICENSE_PLATE", COLOR_GREYBLUE, Color(214, 214, 214))
		cam.End3D2D()
	 end

end