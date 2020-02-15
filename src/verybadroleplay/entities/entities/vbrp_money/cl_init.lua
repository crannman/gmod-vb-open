include("shared.lua")
function ENT:Draw()

    self:DrawModel()

    local alpha = self:DistanceToAlpha(0.5)
    local Money = FormatMoney(self:GetDTAmount())

    if alpha > 0  then
        local ang = Angle(0, RealTime() * 80, 0)
        local pos = self:GetPos() + ang:Up()
        ang:RotateAroundAxis( ang:Forward(), 90 )
        ang:RotateAroundAxis( ang:Right(), 90 )
        local maxs = self:OBBMaxs()
        local mins = self:OBBMins()
        local height = maxs.Z - mins.Z

        cam.Start3D2D(pos + Vector(0, 0, height + 5), Angle( 0, ang.y, 90 ), 0.05)
            draw.DrawText("Argent", "VBFONT_3D2DTEXT_SM", 0, 0, Color( 0, 255, 0, alpha ), 1 )
            draw.DrawText(Money, "VBFONT_3D2DTEXT_SM", 0, 37, Color( 255, 255, 255, alpha ), 1 )
        cam.End3D2D()

        ang:RotateAroundAxis( ang:Right(), 180 )

        cam.Start3D2D(pos + Vector(0, 0, height + 5), Angle( 0, ang.y, 90 ), 0.05)
            draw.DrawText("Argent", "VBFONT_3D2DTEXT_SM", 0, 0, Color( 0, 255, 0, alpha ), 1 )
            draw.DrawText(Money, "VBFONT_3D2DTEXT_SM", 0, 37, Color( 255, 255, 255, alpha ), 1 )
        cam.End3D2D()
    end

end
