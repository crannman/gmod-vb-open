include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH

local chefHat = Material("verybadroleplay/icons/jobs/chef_hat.png")

function ENT:Draw()
  self:DrawModel()
end

function ENT:DrawTranslucent()
  local alpha = self:DistanceToAlpha()
  if alpha > 0  then
    
    local ang = Angle(0, RealTime() * 70, 0)
    local pos = self:GetPos() + ang:Up()
    ang:RotateAroundAxis( ang:Forward(), 90 )
    ang:RotateAroundAxis( ang:Right(), 90 )
    local mins, maxs = self:GetModelBounds()
    local height = maxs.Z - mins.Z
    local title = "Poêle à frire"
    local text = "Placez vos ingrédients ici pour préparer une recette"
    local scale = 0.03
    -- start 3d2d context
    cam.Start3D2D(pos + Vector(0, 0, height + 5), Angle(0, ang.y, 90), scale)
      
      surface.SetFont("VBFONT_3D2DTEXT")
      local w, h = surface.GetTextSize(title)
      
      surface.SetFont("VBFONT_3D2DTEXT_SM")
      local w2, h2 = surface.GetTextSize(text)

      surface.SetDrawColor(0, 0, 0, alpha)
      surface.DrawRect(-225, -h - 10, 450, 250)
      
      surface.SetDrawColor(255, 144, 0, alpha)
      surface.SetMaterial(chefHat)
      surface.DrawTexturedRect(-32, -48, 64, 64)
      draw.DrawText(title, "VBFONT_3D2DTEXT", 0, 15, Color(255, 144, 0, alpha), TEXT_ALIGN_CENTER )
      draw.MultiLineText(text, "VBFONT_3D2DTEXT_SM", 440, 35, 0, h + 5, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, _, _, _)
    
    cam.End3D2D()

    ang:RotateAroundAxis( ang:Right(), 180 )

    -- start 3d2d context
    cam.Start3D2D(pos + Vector(0, 0, height + 5), Angle(0, ang.y, 90), scale)
      
      surface.SetFont("VBFONT_3D2DTEXT")
      local w, h = surface.GetTextSize(title)
      
      surface.SetFont("VBFONT_3D2DTEXT_SM")
      local w2, h2 = surface.GetTextSize(text)
      
      surface.SetDrawColor(255, 144, 0, alpha)
      surface.SetMaterial(chefHat)
      surface.DrawTexturedRect(-32, -48, 64, 64)
      draw.DrawText(title, "VBFONT_3D2DTEXT", 0, 15, Color(255, 144, 0, alpha), TEXT_ALIGN_CENTER )
      draw.MultiLineText(text, "VBFONT_3D2DTEXT_SM", 440, 35, 0, h + 5, Color(255, 255, 255, alpha), TEXT_ALIGN_CENTER, _, _, _)

    cam.End3D2D()

  end
end