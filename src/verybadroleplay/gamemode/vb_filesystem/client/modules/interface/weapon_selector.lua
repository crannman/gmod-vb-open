WeaponSelector = WeaponSelector or {}
WeaponSelector.__index = WeaponSelector
WeaponSelector.Delay = 1.5
WeaponSelector.LastCall = 0
WeaponSelector.Weapons = {}
WeaponSelector.WeaponsCount = 0
WeaponSelector.LastSlot = 1
local isvalid = IsValid
local sfont = surface.SetFont
local ssize = surface.GetTextSize
local srect = surface.DrawRect
local strect = surface.DrawTexturedRect
local sorect = surface.DrawOutlinedRect
local smat = surface.SetMaterial
local mat = Material
local sclr = surface.SetDrawColor
local dtex = draw.SimpleTextOutlined
local clamp = math.Clamp
local ct = CurTime
local scrh = ScrH()
local scrw = ScrW()

function WeaponSelector:ShouldDraw()

  if self.LastCall and self.LastCall + self.Delay > CurTime() then 
    return true 
  end
  return false
end

function WeaponSelector:Initialize()

  self:Update()
  timer.Create("VBTIMER::WeaponSelector::Refresh", .5, 0, function()
    self:Update()
  end)
end

function WeaponSelector:PreDraw()

  if self:ShouldDraw() then
    self.LastCall = CurTime()
  else
    self.LastCall = CurTime()
    self:Initialize()
  end
end

local gradient = mat("vgui/gradient-r")


function WeaponSelector:Draw()

  local currentWeapon = 0
  local totalHeight = self.WeaponsCount * 35 + 45
  local boxH = 35
  local delta = boxH - 35
  for k, v in ipairs(self.Weapons) do
    if isvalid(v) then
      currentWeapon = currentWeapon + 1
      if currentWeapon == self.LastSlot then
        boxH = 45 * clamp( 1 - (self.LastCall + 0.2 - ct()), 0, 1)
        delta = 45 * clamp( 1 - (self.LastCall + 0.2 - ct()), 0, 1) - 30
        local boxW1 = 210
        local boxW2 = 20
        sfont("VBFONT_WEPSELECTOR")
        local w, h = ssize(v:GetPrintName())
        local shift = boxH - h
        sclr(COLOR_RGBA_WEPSELECT_SELECTED_BORDER)
        sorect(19, (scrh - totalHeight) / 2 + (k * 35) - 1, boxW1 + 12, boxH + 2)
        sclr(COLOR_RGBA_WEPSELECT_MAIN)
        srect(20, (scrh - totalHeight) / 2 + (k * 35), boxW1, boxH)
        sclr(COLOR_RGBA_WEPSELECT_SELECTED)
        srect(220, (scrh - totalHeight) / 2 + (k * 35), 20, boxH)
        sclr(COLOR_RGBA_SEMI_BLACK)
        smat(gradient)
        strect(220, (scrh - totalHeight) / 2 + (k * 35), 20, boxH)
        dtex(v:GetPrintName(), "VBFONT_WEPSELECTOR", (200 - w) / 2 + 20, (scrh - totalHeight + shift) / 2 + (k * 35), COLOR_WHITE, _, _, 1, COLOR_BLACK)
      else
        sfont("VBFONT_WEPSELECTOR")
        local w, h = ssize(v:GetPrintName())
        sclr(COLOR_RGBA_WEPSELECT_MAIN)
        srect(5, (scrh - totalHeight) / 2 + (k * 35 + delta) , 200, 30)
        sclr(COLOR_RGBA_WEPSELECT_SECONDARY)
        srect(205, (scrh - totalHeight) / 2 + (k * 35 + delta) , 20, 30)
        sclr(COLOR_RGBA_SEMI_BLACK)
        smat(gradient)
        strect(205, (scrh - totalHeight) / 2 + (k * 35 + delta), 20, 30)
        dtex(v:GetPrintName(), "VBFONT_WEPSELECTOR", (200 - w) / 2, (scrh - totalHeight + h) / 2 + (k * 35) + delta, COLOR_WHITE, _, _, 1, COLOR_BLACK)
      end
    end
  end

end


function WeaponSelector:Update()

  self.Weapons = {}
  for k, v in ipairs(LocalPlayer():GetWeapons()) do
    self.Weapons[k] = v
  end
  self.WeaponsCount = #self.Weapons
end

-- Make sure we're between 1 and self.WeaponsCount thus we can use LastSlot as an index in MakeSelection
function WeaponSelector:NextWeapon()
  if self.WeaponsCount > 0 then
    surface.PlaySound("garrysmod/ui_hover.wav")
  end

  if self.WeaponsCount <= 1 then
    self.LastSlot = 1
  end

  if self.WeaponsCount == self.LastSlot  then
    self.LastSlot = 1
  else 
    self.LastSlot = self.LastSlot + 1
  end
end

function WeaponSelector:PrevWeapon()
  if self.WeaponsCount > 0 then
    surface.PlaySound("garrysmod/ui_hover.wav")
  end

  if self.WeaponsCount <= 1 then
    self.LastSlot = 1
  end

  if self.LastSlot == 1 then
    self.LastSlot = self.WeaponsCount
  else
    self.LastSlot = self.LastSlot - 1
  end
end

function WeaponSelector:SelectSlot(slot)
  self.LastCall = CurTime()
  self:PreDraw()
  self.LastSlot = slot
end

function WeaponSelector:MakeSelection()
  if self.Weapons[self.LastSlot] and IsValid(self.Weapons[self.LastSlot]) then
    RunConsoleCommand("use", self.Weapons[self.LastSlot]:GetClass())
    surface.PlaySound("garrysmod/ui_click.wav")
    timer.Destroy("VBTIMER::WeaponSelector::Refresh")
    self.LastCall = 0
  end
end

hook.Add("PlayerBindPress", "VBHOOK::WeaponSelectionBindRecord", function(ply, bind, pressed)
  if bind == "invnext" and pressed and not input.IsMouseDown(MOUSE_LEFT) and not ply:InVehicle() then
    WeaponSelector:PreDraw()
    WeaponSelector:NextWeapon()
    return true
  elseif bind == "invprev" and pressed and not input.IsMouseDown(MOUSE_LEFT) and not ply:InVehicle() then
    WeaponSelector:PreDraw()
    WeaponSelector:PrevWeapon()
    return true
  elseif bind == "+attack" then
    if WeaponSelector:ShouldDraw() then
      WeaponSelector:PreDraw()
      WeaponSelector:MakeSelection()
       return true
    end
  elseif bind:sub(1, 4) == "slot" and pressed then
    local selectedSlot = tonumber(bind:sub(#bind, -1)) or 1
    WeaponSelector:SelectSlot(selectedSlot)
    return true
  end

end)

hook.Add("HUDPaint", "VBHOOK::DrawWeaponSelector", function()
  if WeaponSelector:ShouldDraw() then
    WeaponSelector:Draw()
  end
end)