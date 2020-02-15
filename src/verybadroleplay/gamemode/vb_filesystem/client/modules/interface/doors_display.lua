local findInSphere = ents.FindInSphere
local setFont = surface.SetFont
local getTextSize = surface.GetTextSize
local clr = Color
local hsvToClr = HSVToColor
local curTime = CurTime
local abs = math.abs
local min  = math.min
local pairs = pairs
local vector = Vector
local start3d2d = cam.Start3D2D
local end3d2d = cam.End3D2D
local drawText = draw.DrawText

hook.Add("PostDrawTranslucentRenderables", "ShowDoorDisplay", function()
  local client = LocalPlayer()
  for _, v in pairs(findInSphere(client:GetPos(), 350)) do
    if v:IsDoor() then
      local alpha = v:DistanceToAlpha(1.5)
      local entity = CalcSuitablePositions(v)
      setFont("VBFONT_DoorTitle")
      local textDoor = ""
      local col = clr(255, 255, 255, alpha)
      if (v:GetDoorName() ~= "") then
        if (v:IsBuyable() and (v:GetEntOwner() == "world" or v:GetEntOwner() == "")) then
          col = clr(0, 127, 255, alpha)
        end
        if (v:GetEntOwner() == LocalPlayer():GetCompleteName()) then
          col = clr(0, 255, 0, alpha)
        end
        if (v:GetEntOwner() ~= "world" and v:GetEntOwner() ~= "" and v:GetEntOwner() ~= client:GetCompleteName() and v:IsBuyable()) then
          col = clr(255, 0, 0, alpha)
        end
        textDoor = v:GetDoorName()
      else
        col = hsvToClr(curTime() % 6 * 60, 1, 1)
        col.a = alpha
        textDoor = "[Development mode]\nNon attributed door"
      end
      local textScale = abs((entity.Width * .75) / getTextSize(textDoor))
      local scale = min(textScale, .05)
      if not entity.HitWorld and alpha > 0 then
        start3d2d(entity.Position + vector(0, 0, 15), entity.Angles, scale)
        drawText(textDoor, "VBFONT_DoorTitle", 0, 0, col, TEXT_ALIGN_CENTER)
        end3d2d()
        start3d2d(entity.PositionBack + vector(0, 0, 15), entity.AnglesBack, scale)
        drawText(textDoor, "VBFONT_DoorTitle", 0, 0, col, TEXT_ALIGN_CENTER)
        end3d2d()
      end
    end
  end
end)