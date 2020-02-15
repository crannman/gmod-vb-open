
function VBJOB.Setup()
  local citizen = {}
  citizen.PrettyName = "job_citizen_pname"
  citizen.BaseSalary = 60
  citizen.Armor = 0
  citizen.Loadout = { "weapon_physcannon" }
  citizen.ApplyModel = function(self, ply)
    ply:SetModelWithIdentifier(ply:GetPlayerModel())
  end
  citizen.PublicServices = false
  VBJOB.RegisterJob(TEAM_CITIZEN, citizen)
  ---------------------------------------------------------------------
  -- ############################################################### --
  ---------------------------------------------------------------------
  local cop = { }
  cop.PrettyName = "job_cop_pname"
  cop.BaseSalary = 60
  cop.Armor = 30
  cop.Loadout = { "weapon_physcannon", "cstm_pistol_glock18", "vbrp_police_handcuffs", "vbrp_police_radio", "vbrp_stunstick", "vbrp_weapon_search" }
  cop.Ammo = {
    ["cstm_pistol_glock18"] = 50
  }
  cop.Models = {
    Male = { "models/player/humans/modern/male/police/male_0%d.mdl" },
    Female = { "models/player/humans/modern/female/shared/female_0%d.mdl" }
  }
  cop.ApplyModel = function(self, ply)
    ply:SetSubMaterial()
    local sex, skin, body, leg, facemap = ParseModelIdentifier(ply:GetDTModel())
    if sex == "M" then
      ply:SetModel(string.format(self.Models.Male[1], skin))
      ply:SetSkin(facemap)
    else
      ply:SetSharedModel(self.Models.Female[1], 2)
    end
  end
  cop.PublicServices = true
  cop.Police = true
  VBJOB.RegisterJob(TEAM_COP, cop, TEAM_CITIZEN)
  ---------------------------------------------------------------------
  -- ############################################################### --
  ---------------------------------------------------------------------
  local policeChief = { }
  policeChief.PrettyName = "job_pchief_pname"
  policeChief.BaseSalary = 120
  policeChief.Armor = 100
  policeChief.Loadout = { "weapon_physcannon", "cstm_pistol_glock18", "cstm_rif_m4a1", "vbrp_police_handcuffs", "vbrp_police_radio", "vbrp_stunstick", "vbrp_weapon_search" }
  policeChief.Ammo = {
    ["cstm_pistol_glock18"] = 50
  }
  policeChief.PublicServices = true
  policeChief.AccessToArmory = true
  VBJOB.RegisterJob(TEAM_POLICECHIEF, policeChief, TEAM_COP)
  ---------------------------------------------------------------------
  -- ############################################################### --
  ---------------------------------------------------------------------
  local swat = { }
  swat.PrettyName = "job_swat_pname"
  swat.BaseSalary = 100
  swat.Ammo = {
    ["cstm_pistol_glock18"] = 50
  }
  swat.Models = "models/player/urban.mdl"
  swat.ApplyModel = function(self, ply)
    ply:SetSubMaterial()
    ply:SetModel(self.Models)
  end
  swat.PublicServices = true
  VBJOB.RegisterJob(TEAM_SWAT, swat, TEAM_POLICECHIEF)
  ---------------------------------------------------------------------
  -- ############################################################### --
  ---------------------------------------------------------------------
  local medic = {}
  medic.PrettyName = "job_medic_pname"
  medic.BaseSalary = 60
  medic.Loadout = { "weapon_physcannon", "vbrp_medkit", "vbrp_defibrillator" }
  medic.Models = {
    Male = { "models/player/humans/modern/male/shared/male_0%d.mdl" },
    Female = { "models/player/humans/modern/female/shared/female_0%d.mdl" }
  }
  medic.ApplyModel = function(self, ply)
    -- Make sure to reset submaterial in order to avoid weird bugs..
    local sex = ply:GetSex()
    local format = Either(sex == "M", self.Models.Male[1], self.Models.Female[1])
    ply:SetSharedModel(format, 1)
  end
  medic.PublicServices = true
  medic.EmergencyServices = true
  VBJOB.RegisterJob(TEAM_MEDIC, medic, TEAM_CITIZEN)
    ---------------------------------------------------------------------
  -- ############################################################### --
  ---------------------------------------------------------------------
  local cook = {}
  cook.PrettyName = "job_cook_pname"
  cook.BaseSalary = 70
  VBJOB.RegisterJob(TEAM_COOK, cook, TEAM_CITIZEN)
end