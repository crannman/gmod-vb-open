local VBRP_Player = FindMetaTable("Player")


function VBRP_Player:IsInCell()
  for k,v in ipairs(VBRP_Jails) do
    if self:GetPos():WithinAABox(v.Min, v.Max) then
      return true
    end
  end
  return false
end

function VBRP_Player:GiveLimitedAmmo(weapon)

  if IsValid(weapon) then
    local currentAmmo = weapon:Clip1() + self:GetAmmoCount(weapon:GetPrimaryAmmoType())
    if currentAmmo < 3 * weapon:GetMaxClip1() then
      weapon:SetClip1(weapon:GetMaxClip1())
      self:SetAmmo(2 * (weapon:GetMaxClip1()), weapon:GetPrimaryAmmoType())
      self:EmitSound("items/ammo_pickup.wav")
    end
  end
end