
local BASE = baseclass.Get("DModelPanel")
local PANEL = {}

function PANEL:Init()

  self:SetFOV( 45 )
  self.Weapon = nil
  self.Window = nil

end

function PANEL:SetWeapon(weapon)

  if IsValid(weapon) and weapon:IsWeapon() then
    self.Weapon = weapon
    self:SetModel(self.Weapon:GetModel())
  end

end

function PANEL:GetWeapon()

  return self.Weapon

end

function PANEL:LayoutEntity()

end

function PANEL:SetModel(modelName)

  BASE.SetModel(self, modelName)

  local mn, mx = self.Entity:GetRenderBounds()
  local size = 0
  size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
  size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
  size = math.max(size, math.abs(mn.z) + math.abs(mx.z))

  self:SetCamPos(Vector(size, size, size))
  self:SetLookAt((mn + mx) * 0.5)

end

function PANEL:DoClick(weapon)

  local menu = DermaMenu()
  menu:AddOption(Translate("inv_store"), function()
    if LocalPlayer():Team() ~= TEAM_CITIZEN then
      ClientsideNotify(Translate("notify_cannot_store_wep"))
      return false
    end
    net.Start("VBNET::Inventory::Weapons::RequestStore")
    net.WriteString(self:GetWeapon():GetClass())
    net.SendToServer()
    CreateProgressBar(Translate("inv_storing_weapon"), 2, Translate("inv_storing_weapon_status"))
    self.Window:Close()
  end)
  menu:Open()

end

VBVGUI:Register("WeaponModelPanel", PANEL, "DModelPanel")