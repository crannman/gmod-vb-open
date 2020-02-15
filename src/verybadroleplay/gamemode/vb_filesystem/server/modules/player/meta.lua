local VBRP_Player = FindMetaTable("Player")

function VBRP_Player:MakeLoadout()
  
  local job = self:GetJob()
  for _, v in pairs(job.Loadout) do self:Give(v)  end
  
  self:Give("vbrp_keys")
  self:Give("weapon_fists")
  
  if self:IsVIP() then
    self:Give("weapon_physgun")
  end
  
  if self:IsSuperAdmin() then
    self:Give("vbrp_vector_helper")
    self:Give("vbrp_doorsutil")
    self:Give("vbrp_posutil")
  end
  
  if self:IsModerator() then
    self:Give("vbrp_entity_info_finder")
  end
  
  self:SetWeaponColor(HexToColorRGB(self:GetNWString("VB::NW::Organization::Color")):ToVector())
end

function VBRP_Player:HealOverTime(amountToHeal, timeInSecond)

  local healthToGive = math.ceil(amountToHeal / timeInSecond)
  if timer.Exists("VBTIMER::HoT::" .. self:SteamID64()) then timer.Remove("VBTIMER::HoT::" .. self:SteamID64()) end
  timer.Create("VBTIMER::HoT::" .. self:SteamID64(), 1, timeInSecond, function()
    if self:Health() + healthToGive >= 100 then 
      self:SetHealth(100)
      timer.Remove("VBTIMER::HoT::" .. self:SteamID64())
      return false
    end
    self:SetHealth(self:Health() + healthToGive)
  end)

end

function VBRP_Player:SetEnergy(amount)
  self:SetDTEnergy(math.Clamp(amount, 0, 100))
end