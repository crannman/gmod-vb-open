HeavyWeaponsList = {
  ["cstm_sniper_sg552"]       = true,
  ["cstm_sniper_sg550"]       = true,
  ["cstm_sniper_awp"]         = true,
  ["cstm_sniper_scout"]       = true,
  ["cstm_sniper_g3"]          = true,
  ["cstm_sniper_aug"]         = true,
  ["cstm_snip_m98"]           = true,
  ["cstm_smg_ump45"]          = true,
  ["cstm_smg_p90"]            = true,
  ["cstm_smg_mp5"]            = true,
  ["cstm_shotgun_xm1014"]     = true,
  ["cstm_shotgun_m3"]         = true,
  ["cstm_shotgun2_m3"]        = true,
  ["cstm_rif_m249"]           = true,
  ["cstm_rif_galil"]          = true,
  ["cstm_rif_famas"]          = true,
  ["cstm_rif_ak47"]           = true,
  ["cstm_rif_sr3m"]           = true,
  ["cstm_rif_l85a2"]          = true,
  ["cstm_rif_m4a1"]           = true,
  ["cstm_rif_m14ebr"]         = true,
  ["cstm_rif_g36c"]           = true,
  ["cstm_sniper_m98b"]        = true,
  ["cstm_shotgun_spas12"]     = true,
}
HeavyWeaponsIdentifiers = {
  ["WEP_SG552"]       = true,
  ["WEP_SG550"]       = true,
  ["WEP_AWP"]         = true,
  ["WEP_SCOUT"]       = true,
  ["WEP_G3"]          = true,
  ["WEP_AUG"]         = true,
  ["WEP_M98"]         = true,
  ["WEP_UMP45"]       = true,
  ["WEP_P90"]         = true,
  ["WEP_MP5"]         = true,
  ["WEP_XM1014"]      = true,
  ["WEP_M3"]          = true,
  ["WEP_m3_ALT"]      = true,
  ["WEP_M249"]        = true,
  ["WEP_GALIL"]       = true,
  ["WEP_FAMAS"]       = true,
  ["WEP_AK47"]        = true,
  ["WEP_SR3M"]        = true,
  ["WEP_L85A2"]       = true,
  ["WEP_M4A1"]        = true,
  ["WEP_M14EBR"]      = true,
  ["WEP_G36C"]        = true,
  ["WEP_M98B"]        = true,
  ["WEP_SPAS12"]      = true,
}
LightweightWeaponsList = {
  ["cstm_smg_tmp"]            = true,
  ["cstm_smg_mac10"]          = true,
  ["cstm_smg_mp7"]            = true,
  ["cstm_pistol_p228"]        = true,
  ["cstm_pistol_glock18"]     = true,
  ["cstm_pistol_fiveseven"]   = true,
  ["cstm_pistol_dualelites"]  = true,
  ["cstm_pistol_deagle"]      = true,
  ["cstm_pistol_mr96"]        = true,
  ["cstm_pistol_m92fs"]       = true,
  ["cstm_pistol_cz75"]        = true,
}

LightweightWeaponsIdentifiers = {
  ["WEP_TMP"]             = true,
  ["WEP_MAC10"]           = true,
  ["WEP_MP7"]             = true,
  ["WEP_P228"]            = true,
  ["WEP_GLOCK18"]         = true,
  ["WEP_57"]              = true,
  ["WEP_DUAL"]            = true,
  ["WEP_DEAGLE"]          = true,
  ["WEP_MR96"]            = true,
  ["WEP_M92FS"]           = true,
  ["WEP_CZ75"]            = true,
}

local VBRP_Player = FindMetaTable("Player")

-- @desc Vérifie si le joueur possèdes des armes sans distinction du poids ou du type;
-- @realm Shared;
-- @return boolean HasWeapons;
function VBRP_Player:HasWeapons()
  for _, v in pairs( self:GetWeapons() ) do
    local currentWeapon = v:GetClass()
    if HeavyWeaponsList[currentWeapon] or LightweightWeaponsList[currentWeapon] then
      return true
    end
  end
  return false
end

-- @desc Vérifie si le joueur possèdes une arme lourde;
-- @realm Shared;
-- @return boolean HasHeavyWeapon;
function VBRP_Player:HasHeavyWeapon()
  for _, v in pairs( self:GetWeapons() ) do
    local currentWeapon = v:GetClass()
    if HeavyWeaponsList[currentWeapon] then
      return true
    end
  end
  return false
end

-- @desc Obtient l'arme lourde possédée par le joueur (s'il en possède une);
-- @realm Shared;
-- @return weapon HeavyWeapon;
function VBRP_Player:HeavyWeapon()
  for _, v in pairs( self:GetWeapons() ) do
    local currentWeapon = v:GetClass()
    if HeavyWeaponsList[currentWeapon] then
      return v
    end
  end
  return nil
end

-- @desc Obtient l'arme légère possédée par le joueur (s'il en possède une);
-- @realm Shared;
-- @return weapon LightWeapon;
function VBRP_Player:LightWeapon()
  for _, v in pairs( self:GetWeapons() ) do
    local currentWeapon = v:GetClass()
    if LightweightWeaponsList[currentWeapon] then
      return v
    end
  end
  return nil
end

-- @desc Vérifie si le joueur possède une arme légère;
-- @realm Shared;
-- @return boolean HasLightWeapon;
function VBRP_Player:HasLightWeapon()
  for _, v in pairs( self:GetWeapons() ) do
    local currentWeapon = v:GetClass()
    if LightweightWeaponsList[currentWeapon] then
      return true
    end
  end
  return false
end

-- @desc Vérifie si l'arme est une arme de Very Bad RP;
-- @args weapon Weapon
-- @realm Shared;
-- @return boolean IsVBWeapon;
function IsVBWeapon(Weapon)
  local weaponClass = Weapon:GetClass()
  if LightweightWeaponsList[weaponClass] or HeavyWeaponsList[weaponClass] then
    return true
  end
  return false
end

-- @desc Vérifie si l'arme est une arme légère de Very Bad RP;
-- @args weapon Weapon
-- @realm Shared;
-- @return boolean IsVBLightWeapon;
function IsVBLightWeapon(Weapon)
  local weaponClass = Weapon:GetClass()
  if LightweightWeaponsList[weaponClass] then
    return true
  end
  return false
end

function IsVBLightWeaponFromClass(weaponClass)
  if LightweightWeaponsList[weaponClass] then
    return true
  end
  return false
end

function IsVBLightWeaponFromIdentifier(weaponIdentifier)
  if LightweightWeaponsIdentifiers[weaponIdentifier] then
    return true
  end
  return false
end

-- @desc Vérifie si l'arme est une arme lourde de Very Bad RP;
-- @args weapon Weapon
-- @realm Shared;
-- @return boolean IsVBLightWeapon;
function IsVBHeavyWeapon(Weapon)
  local weaponClass = Weapon:GetClass()
  if HeavyWeaponsList[weaponClass] then
    return true
  end
  return false
end

function IsVBHeavyWeaponFromClass(weaponClass)
  if HeavyWeaponsList[weaponClass] then
    return true
  end
  return false
end

function IsVBHeavyWeaponFromIdentifier(weaponIdentifier)
  if HeavyWeaponsIdentifiers[weaponIdentifier] then
    return true
  end
  return false
end

-- @desc Génère un temps de chargement lors d'un switch;
-- @args weapon Weapon,[int custom_time]
-- @realm Client;
function LoadingTimeOnSwitch(weapon, customTime)
  if CLIENT then
    if IsVBLightWeapon(weapon) then
      customTime = customTime or 0.6
      CreateProgressBar("Vous êtes en train de prendre votre arme.", customTime, "En train de prendre une arme")
    end
    if IsVBHeavyWeapon(weapon) then
      customTime = customTime or 1.6
      CreateProgressBar("Vous êtes en train de prendre votre arme.", customTime, "En train de prendre une arme")
    end
    if not IsVBWeapon(weapon) then
      customTime = customTime or 2
      CreateProgressBar("Vous êtes en train de ranger votre arme.", customTime, "En train de mettre son arme dans le dos")
    end
  end
end

-- @desc Hook s'activant lors d'un switch d'arme;
-- @realm Shared;
-- @return boolean PreventSwitch
function GM:PlayerSwitchWeapon(ply, oldWeapon, newWeapon)
  if IsFirstTimePredicted() and IsValid(oldWeapon) and IsValid(newWeapon) and not ply:IsModerator() then
    oldWeapon = oldWeapon or "weapon_physcannon"
    newWeapon = newWeapon or "vbrp_keys"

    if not IsVBWeapon(oldWeapon) and IsVBWeapon(newWeapon) then
      LoadingTimeOnSwitch(newWeapon)
    end

    if IsVBWeapon(oldWeapon) and not IsVBWeapon(newWeapon) then
      LoadingTimeOnSwitch(newWeapon)
    end

    if IsVBWeapon(oldWeapon) and IsVBWeapon(newWeapon) then
      LoadingTimeOnSwitch(newWeapon, 2)
    end

    if not IsVBWeapon(oldWeapon) and not IsVBWeapon(newWeapon) then return false end
  end
end