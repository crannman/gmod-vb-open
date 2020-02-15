include("shared.lua")
local rif = Material("verybadroleplay/icons/weapons/rifle2.png")
function ENT:Draw()
    self:DrawModel()
    local alpha = self:DistanceToAlpha()
    if alpha > 0  then
        local ang = Angle(0, 180, 0)
        local pos = self:GetPos() + ang:Up()
        ang:RotateAroundAxis( ang:Forward(), 90 )
        ang:RotateAroundAxis( ang:Right(), 90 )
        local maxs = self:OBBMaxs()
        local mins = self:OBBMins()
        local height = maxs.Z - mins.Z

        cam.Start3D2D(pos + Vector(5, 0, height / 2 + 20), Angle( 0, ang.y, 90 ), 0.09)
            surface.SetFont("VBFONT_3D2DTEXT")
            local w, h = surface.GetTextSize("Armurerie")
            surface.SetDrawColor(0, 0, 0, alpha)
            surface.DrawRect(-(w + 70) / 2, -h - 20 , w + 70, 310)
            surface.SetDrawColor(0, 153, 255, alpha)
            surface.SetMaterial(rif)
            surface.DrawTexturedRect(-128, -h * 2.45, 256, 256)
            draw.DrawText("Armurerie", "VBFONT_3D2DTEXT", 0, 0, Color( 0, 153, 255, alpha ), TEXT_ALIGN_CENTER )
            draw.DrawText("M4A1\nAI AWP\nFranchi SPAS-12\nG36C", "VBFONT_3D2DTEXT_SM", -w / 2, h + 5, Color( 255, 255, 255, alpha ), TEXT_ALIGN_LEFT )
        cam.End3D2D()
    end

end
