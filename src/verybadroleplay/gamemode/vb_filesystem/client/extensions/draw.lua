function draw.Arc(cx, cy, radius, thickness, startang, endang, roughness, color)
  surface.SetDrawColor(color)
  surface.DrawArc(surface.PrecacheArc(cx, cy, radius, thickness, startang, endang, roughness))
end

local blur = Material("pp/blurscreen")

function draw.Blur(x, y, w, h, layers, density, alpha)
  local X, Y = 0, 0
  local scrW, scrH = ScrW(), ScrH()
  surface.SetDrawColor(255, 255, 255, alpha)
  surface.SetMaterial(blur)

  for i = 1, 3 do
    blur:SetFloat("$blur", (i / layers) * density)
    blur:Recompute()
    render.UpdateScreenEffectTexture()
    render.SetScissorRect(x, y, x + w, y + h, true)
    surface.DrawTexturedRect(X * -1, Y * -1, scrW, scrH)
    render.SetScissorRect(0, 0, 0, 0, false)
  end
end

function draw.BlurPanel(panel, amount)
  local x, y = panel:LocalToScreen(0, 0)
  local scrW, scrH = ScrW(), ScrH()
  surface.SetDrawColor(255, 255, 255)
  surface.SetMaterial(blur)
  for i = 1, 3 do
    blur:SetFloat("$blur", (i / 3) * (amount or 6))
    blur:Recompute()
    render.UpdateScreenEffectTexture()
    surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
  end
end

-- https://gist.github.com/Phoenix1123/95863a1a903f7d50ec68a2e86e34d5c7
function draw.MultiLineText(text, font, mWidth, spacing, x, y, color, alignX, alignY, oWidth, oColor)
  local mLines = string.ToMultiLines(text, font, mWidth)
  for i, line in pairs(mLines) do
    if oWidth and oColor then
      draw.SimpleTextOutlined(line, font, x, y + (i - 1) * spacing, color, alignX, alignY, oWidth, oColor)
    else
      draw.SimpleText(line, font, x, y + (i - 1) * spacing, color, alignX, alignY)
    end
  end
  return (#mLines - 1) * spacing
end

function draw.Circle(x, y, radius, seg)
  local cir = {}
  table.insert(cir, {x = x, y = y, u = 0.5, v = 0.5})
  for i = 0, seg do
    local a = math.rad((i / seg) * -360)
    table.insert(
      cir,
      {
        x = x + math.sin(a) * radius,
        y = y + math.cos(a) * radius,
        u = math.sin(a) / 2 + 0.5,
        v = math.cos(a) / 2 + 0.5
      }
    )
  end
  local a = math.rad(0) -- This is needed for non absolute segment counts
  table.insert(
    cir,
    {
      x = x + math.sin(a) * radius,
      y = y + math.cos(a) * radius,
      u = math.sin(a) / 2 + 0.5,
      v = math.cos(a) / 2 + 0.5
    }
  )
  surface.DrawPoly(cir)
end

function draw.TextRotated(text, font, x, y, angle, color)
  font = font or "DermaDefault"

  render.PushFilterMag(TEXFILTER.ANISOTROPIC)
  render.PushFilterMin(TEXFILTER.ANISOTROPIC)

  surface.SetFont(font)
  surface.SetTextColor(color)
  surface.SetTextPos(0, 0)

  local width, height = surface.GetTextSize(text)
  local rad = -math.rad(angle)
  -- Calculate our new positions using 2D Rotation matrix
  x = x - (math.cos(rad) * width + math.sin(rad) * height) / 2
  y = y + (math.cos(rad) * width + math.sin(rad) * height) / 2
  local m = Matrix()
  m:SetAngles(Angle(0, angle, 0))
  m:SetTranslation(Vector(x, y, 0))
  cam.PushModelMatrix(m)
  surface.DrawText(text)
  cam.PopModelMatrix()
  render.PopFilterMag()
  render.PopFilterMin()
end
