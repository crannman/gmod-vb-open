function GM:HUDDrawTargetID()
end

local restrictedHudElements = {
  ["CHudAmmo"] = true,
  ["CHudBattery"] = true,
  ["CHudHealth"] = true,
  ["CHudSecondaryAmmo"] = true,
  ["CHudZoom"] = true,
  ["CHudDamageIndicator"] = true,
  ["CHudWeaponSelection"] = true
}

--["CHudChat"] = true,
hook.Add("HUDShouldDraw", "RemoveHUDElements", function(name)
  if (restrictedHudElements[name]) then return false end
end)



-- Function localization (faster)
local material = Material
local fmt = string.format
local drawText = draw.DrawText
local getTextureId = surface.GetTextureID
local drawTextOutlined = draw.SimpleTextOutlined
local texturedQuad = draw.TexturedQuad
local drawTexturedRect = surface.DrawTexturedRect
local drawOutlinedRect = surface.DrawOutlinedRect
local setMaterial = surface.SetMaterial
local setDrawColor = surface.SetDrawColor
local drawRect = surface.DrawRect
local getTextSize = surface.GetTextSize
local noTexture = draw.NoTexture
local setFont = surface.SetFont
local blur = draw.Blur
local sW, sH = ScrW(), ScrH()
local clr = Color
local lerpClr = LerpColor
local rft = RealFrameTime
local clamp = math.Clamp
local lerp = Lerp
local localPlayer = LocalPlayer
local floor = math.floor
local teamGetClr = team.GetColor
local strlwr = string.lower
local isvalid = IsValid
local translate = Translate
local either = Either
local struct = {
  texture   = getTextureId("gui/gradient_down"),
  color     = COLOR_RGBA_FULL_BLACK,
  x         = 0,
  y         = 30,
  w         = sW,
  h         = 5
}

local icPerson = material("icon16/user.png")
local icFood = material("icon16/cake.png")
local icMoney = material("icon16/money.png")
local icHeart = material("icon16/heart.png")
local icArmor = material("icon16/shield.png")
local icPistol = material("verybadroleplay/icons/weapons/pistol.png")
local icRifle = material("verybadroleplay/icons/weapons/rifle.png")
local gradient = material("gui/gradient_up")

local visualHealth = 0
local visualArmor = 0
local visualEnergy = 0
function HUDDrawing()
  if GetConVar("vbrp_enable_hud"):GetInt() == 0 then
    return false
  end
  local pl = localPlayer()
  local name = pl:GetCompleteName()
  local money = FormatMoney(pl:GetMoney("Money"))
  local health = pl:Health()
  local armor = pl:Armor()
  local energy = pl:GetEnergy()
  local healthCol = lerpClr(health / 100, COLOR_RED, clr(136, 227, 116))
  visualHealth = lerp(10 * rft(), visualHealth, health)
  visualArmor = lerp(10 * rft(), visualArmor, armor)
  visualEnergy = lerp(10 * rft(), visualEnergy, energy)
  health = clamp(health, 0, 100)
  armor = clamp(armor, 0, 100)
  energy = clamp(energy, 0, 100)
  if not pl:IsRegistered() then return false end
  local job = "Initializing.."
  local jobColor = teamGetClr(pl:Team())
  if pl:GetJob() then
    job = translate(pl:GetJob().PrettyName)
  end
  surface.SetFont("VBFONT_HUDNORMAL")
  if blur then
    blur(0, 0, sW, 30, 150, 255)
  else
    blur = draw.Blur
  end
  setMaterial(icPerson)
  setDrawColor(COLOR_RGBA_FULL_WHITE)
  drawTexturedRect(5, 15 - 8, 16, 16)
  local w, h = getTextSize(name .. " - ")
  local w2 = getTextSize(name .. " - " .. job)
  local w3 = getTextSize(money)

  texturedQuad(struct)
  -- Name and job
  drawTextOutlined(name .. " - ", "VBFONT_HUDNORMAL", 26, 15 - h / 2, COLOR_RGBA_FULL_WHITE, _, _, 1, COLOR_RGBA_FULL_BLACK)
  drawTextOutlined(job, "VBFONT_HUDNORMAL", 26 + w, 15 - h/2, jobColor,  _, _, 1, COLOR_RGBA_FULL_BLACK)
  -- Money
  setMaterial(icMoney)
  setDrawColor(COLOR_RGBA_FULL_WHITE)
  drawTexturedRect(w2 + 36, 15 - 8, 16, 16)
  drawTextOutlined(money, "VBFONT_HUDNORMAL", w2 + 56, 15 - h/2, clr(33, 194, 60, 255),  _, _, 1, COLOR_RGBA_FULL_BLACK)
  -- Health
  setMaterial(icHeart)
  setDrawColor(COLOR_RGBA_FULL_WHITE)
  drawTexturedRect(w2 + w3 + 66, 15 - 8, 16, 16)
  setDrawColor(healthCol)
  setMaterial(gradient)
  drawRect(w2 + w3 + 87, 15 - 10 / 2, visualHealth, 10)
  setDrawColor(255, 255, 255, 100)
  drawTexturedRect(w2 + w3 + 87, 15 - 10 / 2, visualHealth, 10)
  setDrawColor(0, 0, 0, 255)
  drawOutlinedRect((w2 + w3 + 87) - 1, (15 - 10 / 2) - 1, 100 + 1, 10 + 1)
  -- Energy
  setMaterial(icFood)
  setDrawColor(COLOR_RGBA_FULL_WHITE)
  drawTexturedRect(w2 + w3 + 66 + 126, 15 - 8, 16, 16)
  setDrawColor(COLOR_ORANGE.r, COLOR_ORANGE.g, COLOR_ORANGE.b, 255)
  setMaterial(gradient)
  drawRect(w2 + w3 + 87 + 131, 15 - 10 / 2, visualEnergy, 10)
  setDrawColor(0, 0, 0, 60)
  drawTexturedRect(w2 + w3 + 87 + 131, 15 - 10 / 2, visualEnergy, 10)
  setDrawColor(0, 0, 0, 255)
  drawOutlinedRect((w2 + w3 + 87 + 131) - 1, (15 - 10 / 2) - 1, 100 + 1, 10 + 1)
  if armor > 0 then
    setMaterial(icArmor)
    setDrawColor(COLOR_RGBA_FULL_WHITE)
    drawTexturedRect(w2 + w3 + 66 + 126 + 136, 15 - 8, 16, 16)
    setDrawColor(66, 135, 245,  255)
    setMaterial(gradient)
    drawRect(w2 + w3 + 87 + 131 + 136, 15 - 10 / 2, visualEnergy, 10)
    setDrawColor(255, 255, 255, 20)
    drawTexturedRect(w2 + w3 + 87 + 131 + 136, 15 - 10 / 2, visualEnergy, 10)
    setDrawColor(0, 0, 0, 255)
    drawOutlinedRect((w2 + w3 + 87 + 131 + 136) - 1, (15 - 10 / 2) - 1, 100 + 1, 10 + 1)
  end
  

  if pl:InVehicle() then
    local veh = pl:GetVehicle()
    if isvalid(veh) and veh:GetClass() == "prop_vehicle_jeep" then
      local speed = floor(veh:VC_getSpeedKmH())
      noTexture()
      draw.Arc(150, sH - 150, 100, 25, -45, 225, 3, COLOR_RGBA_SEMI_BLACK)
      if speed >= 1 then
          draw.Arc(150, sH - 150, 100, 25, 222, 225, 3, lerpClr(clamp(speed, 0, 265) / 100, COLOR_VEH_MAX_SPEED, COLOR_VEH_MIN_SPEED))
      end
      draw.Arc(150, sH - 150, 100, 25, 225 - clamp(lerp(0.01 * rft(), speed, 265)*1.4, 0, 265) , 225, 3, lerpClr(clamp(speed, 0, 265) / 100, COLOR_VEH_MAX_SPEED, COLOR_VEH_MIN_SPEED))
      drawText(speed .. "\nkm/h", "VBFONT_SPEEDOMETER", 150, sH - 200, lerpClr(speed / 100, COLOR_WHITE, COLOR_RED), TEXT_ALIGN_CENTER)
    end
  end

  local weapon = pl:GetActiveWeapon()
  if isvalid(weapon) and IsVBWeapon(weapon) and not pl:InVehicle() then
    local text = weapon:Clip1() .. " / " .. pl:GetAmmoCount(weapon:GetPrimaryAmmoType())
    local wAmmo = getTextSize(text)
    if IsVBLightWeapon(weapon) then
      drawTextOutlined(text, "VBFONT_HUDNORMAL", sW - wAmmo - 5, 15 - h/2, COLOR_RGBA_FULL_WHITE, _, _, 1, COLOR_RGBA_FULL_BLACK)
      setMaterial(icPistol)
      setDrawColor(COLOR_RGBA_FULL_WHITE)
      drawTexturedRect(sW - wAmmo - 5 - 48, -10, 48, 48)
    end
    if IsVBHeavyWeapon(weapon) then
      drawTextOutlined(text, "VBFONT_HUDNORMAL", sW - wAmmo - 5, 15 - h/2, COLOR_RGBA_FULL_WHITE, _, _, 1, COLOR_RGBA_FULL_BLACK)
      setMaterial(icRifle)
      setDrawColor(COLOR_RGBA_FULL_WHITE)
      drawTexturedRect(sW - wAmmo - 10 - 64, -17, 64, 64)
    end
  end

  local job = VBJOB.GetJobInfos(pl:Team())
  local radioWep = pl:GetWeapon("vbrp_police_radio")
  if job.Police and isvalid(radioWep) then
      drawTextOutlined("Radio: ", "VBFONT_HUDNORMAL", 5, sH - h - 5, COLOR_RGBA_FULL_WHITE, _, _, 1, COLOR_RGBA_FULL_BLACK)
      local activated = radioWep:GetDTRadioActivated()
      local clr = either(activated, COLOR_GREEN, COLOR_RED)
      local text = either(activated, "ON", "OFF")
      setFont("VBFONT_HUDNORMAL")
      local w, _ = getTextSize("Radio: ")
      drawTextOutlined(text, "VBFONT_HUDNORMAL", 5 + w, sH - h - 5, clr, _, _, 1, COLOR_RGBA_FULL_BLACK)

  end

  if pl:Team() == TEAM_COOK then
  local perc = clamp(pl:GetDTFoodWeight() / 15, 0, 1)
  setDrawColor(COLOR_BLACK)
  drawOutlinedRect(5, sH - 25, 400, 20)

  setDrawColor(LerpColor(398 * perc / 398, COLOR_GREEN, COLOR_RED))
  drawRect(6, sH - 24, 398 * perc, 18)

  setDrawColor(Color(0, 0, 0, 100))
  setMaterial(gradient)
  drawTexturedRect(6, sH - 24, 398 * perc, 18)

  drawTextOutlined(fmt("Poids (%.2f / 15.00 kg)", pl:GetDTFoodWeight()), "VBFONT_HUDNORMAL", 7, sH - h - 26, COLOR_RGBA_FULL_WHITE, _, _, 1, COLOR_RGBA_FULL_BLACK)

  end

end

hook.Add("HUDPaint", "VBHOOK_HUD", HUDDrawing)

CreateClientConVar("vbrp_enable_hud", "1", false, false, "Enable HUD")

function GM:DrawDeathNotice(x, y)
  return false
end
