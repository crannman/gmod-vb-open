local VBRP_Player = FindMetaTable("Player")
local VBRP_Entity = FindMetaTable("Entity")
local fmt = string.format

function ParseModelIdentifier(identifier)

  local tbl = string.Explode("|", identifier)
  local sex = tbl[1]
  local skin = tbl[2]
  local body = tbl[3]
  local leg = tbl[4]
  local facemap = tbl[5]
  return sex, skin, tonumber(body), tonumber(leg), tonumber(facemap)

end


function VBRP_Entity:SetModelWithIdentifier(identifier)
  self:SetSubMaterial()
  local sex, skin, body, leg, facemap = ParseModelIdentifier(identifier)
  local model = ""
  local skinTable = {}
  if sex == "M" then
    model = "player/humans/modern/male/male_" .. skin .. ".mdl"
    skinTable = PlayerModels.Male[model]["Skins"]
  else
    model = "player/humans/modern/female/female_" .. skin .. ".mdl"
    skinTable = PlayerModels.Female[model]["Skins"]
  end
  self:SetModel("models/" .. model)
  self:SetSubMaterial(4, skinTable[body])
  self:SetSubMaterial(Either(sex == "M", 9, 8), skinTable[leg])
  self:SetSkin(facemap)
end

function VBRP_Entity:SetSharedModel(identifier, modelFormat, skinIndex)

  self:SetSubMaterial()
  local sex, skin, body, leg, facemap = ParseModelIdentifier(identifier)
  self:SetModel(fmt(modelFormat, skin))
  self:SetSkin(facemap)
  for k,v in ipairs(self:GetMaterials()) do
    if v:EndsWith("sheet_01") then
      if sex == "M" then
        self:SetSubMaterial(k - 1, SharedPlayerModels.Male[self:GetModel():sub(8)]["Skins"][skinIndex])
      else
        self:SetSubMaterial(k - 1, SharedPlayerModels.Female[self:GetModel():sub(8)]["Skins"][skinIndex])
      end
      break
    end
  end
end

function VBRP_Player:SetSharedModel(modelFormat, skinIndex)
  
  self:SetSubMaterial()
  local sex, skin, body, leg, facemap = ParseModelIdentifier(self:GetPlayerModel())
  self:SetModel(fmt(modelFormat, skin))
  self:SetSkin(facemap)
  for k,v in ipairs(self:GetMaterials()) do
    if v:EndsWith("sheet_01") then
      if sex == "M" then
        self:SetSubMaterial(k - 1, SharedPlayerModels.Male[self:GetModel():sub(8)]["Skins"][skinIndex])
      else
        self:SetSubMaterial(k - 1, SharedPlayerModels.Female[self:GetModel():sub(8)]["Skins"][skinIndex])
      end
      break
    end
  end
end



function VBRP_Player:SetModelWithIdentifier(identifier)
  local sex, skin, body, leg, facemap = ParseModelIdentifier(identifier)
  
  local model = ""
  local skinTable = {}
  if sex == "M" then
    model = "player/humans/modern/male/male_" .. skin .. ".mdl"
    skinTable = PlayerModels.Male[model]["Skins"]
  else
    model = "player/humans/modern/female/female_" .. skin .. ".mdl"
    skinTable = PlayerModels.Female[model]["Skins"]
  end
  self:SetModel("models/" .. model)
  self:SetSubMaterial(4, skinTable[body])
  self:SetSubMaterial(Either(sex == "M", 9, 8), skinTable[leg])
  self:SetSkin(facemap)
end

PlayerModels = {}

PlayerModels.Male = {}
PlayerModels.Female = {}

SharedPlayerModels = {}
SharedPlayerModels.Male = {}
SharedPlayerModels.Female = {}

PlayerModels.Male["player/humans/modern/male/male_01.mdl"] = {
  Body = {
    "male_01_body_01.smd",
    "male_01_body_03.smd"
  },
  Legs = {
    "male_01_leg_01.smd",
    "male_01_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_02.mdl"] = {
  Body = {
    "male_02_body_01.smd",
    "male_02_body_03.smd"
  },
  Legs = {
    "male_02_leg_01.smd",
    "male_02_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_03.mdl"] = {
  Body = {
    "male_03_body_01.smd",
    "male_03_body_03.smd"
  },
  Legs = {
    "male_03_leg_01.smd",
    "male_03_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_04.mdl"] = {
  Body = {
    "male_04_body_01.smd",
    "male_04_body_03.smd"
  },
  Legs = {
    "male_04_leg_01.smd",
    "male_04_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_05.mdl"] = {
  Body = {
    "male_05_body_01.smd",
    "male_05_body_03.smd"
  },
  Legs = {
    "male_05_leg_01.smd",
    "male_05_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_06.mdl"] = {
  Body = {
    "male_06_body_01.smd",
    "male_06_body_03.smd"
  },
  Legs = {
    "male_06_leg_01.smd",
    "male_06_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_07.mdl"] = {
  Body = {
    "male_07_body_01.smd",
    "male_07_body_03.smd"
  },
  Legs = {
    "male_07_leg_01.smd",
    "male_07_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_08.mdl"] = {
  Body = {
    "male_08_body_01.smd",
    "male_08_body_03.smd"
  },
  Legs = {
    "male_08_leg_01.smd",
    "male_08_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

PlayerModels.Male["player/humans/modern/male/male_09.mdl"] = {
  Body = {
    "male_09_body_01.smd",
    "male_09_body_03.smd"
  },
  Legs = {
    "male_09_leg_01.smd",
    "male_09_leg_02.smd"
  },
  Skins = {
    "models/humans/modern/male/sheet_01.vtf",
    -- "models/humans/modern/male/sheet_02.vtf", FIREFIGHTER
    "models/humans/modern/male/sheet_03.vtf",
    "models/humans/modern/male/sheet_04.vtf",
    "models/humans/modern/male/sheet_05.vtf",
    "models/humans/modern/male/sheet_08.vtf",
    "models/humans/modern/male/sheet_09.vtf",
    "models/humans/modern/male/sheet_10.vtf",
    "models/humans/modern/male/sheet_11.vtf",
    "models/humans/modern/male/sheet_12.vtf",
    "models/humans/modern/male/sheet_13.vtf",
    "models/humans/modern/male/sheet_14.vtf",
    "models/humans/modern/male/sheet_16.vtf",
    "models/humans/modern/male/sheet_17.vtf",
    "models/humans/modern/male/sheet_18.vtf",
    "models/humans/modern/male/sheet_19.vtf",
    "models/humans/modern/male/sheet_20.vtf",
    "models/humans/modern/male/sheet_21.vtf",
    "models/humans/modern/male/sheet_22.vtf",
    "models/humans/modern/male/sheet_23.vtf",
    "models/humans/modern/male/sheet_24.vtf",
    "models/humans/modern/male/sheet_25.vtf",
    "models/humans/modern/male/sheet_26.vtf",
    "models/humans/modern/male/sheet_27.vtf",
    "models/humans/modern/male/sheet_28.vtf",
    "models/humans/modern/male/sheet_29.vtf",
    "models/humans/modern/male/sheet_30.vtf",
    "models/humans/modern/male/sheet_31.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_01.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_02.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_03.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_04.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_05.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_06.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_07.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_08.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}

SharedPlayerModels.Male["player/humans/modern/male/shared/male_09.mdl"] = {
  Skins = {
    "models/humans/modern/male/medic_sheet.vtf",
    "models/humans/modern/male/police_sheet.vtf",
    "models/humans/modern/male/sheet_02.vtf",
  }
}


PlayerModels.Female["player/humans/modern/female/female_01.mdl"] = {
  Body = {
    "female_01_body_01.smd",
    "female_01_body_04.smd"
  },
  Legs = {
    "female_01_leg_01.smd",
    "female_01_leg_02.smd",
  },
  Skins = {
    "models/humans/modern/female/sheet_01.vtf",
    "models/humans/modern/female/sheet_02.vtf",
    "models/humans/modern/female/sheet_03.vtf",
    "models/humans/modern/female/sheet_04.vtf",
    "models/humans/modern/female/sheet_05.vtf",
    "models/humans/modern/female/sheet_06.vtf",
    "models/humans/modern/female/sheet_08.vtf",
    "models/humans/modern/female/sheet_09.vtf",
    "models/humans/modern/female/sheet_10.vtf",
    "models/humans/modern/female/sheet_11.vtf",
    "models/humans/modern/female/sheet_12.vtf",
    "models/humans/modern/female/sheet_13.vtf",
    "models/humans/modern/female/sheet_14.vtf",
    "models/humans/modern/female/sheet_15.vtf",

  }
}

PlayerModels.Female["player/humans/modern/female/female_02.mdl"] = {
  Body = {
    "female_02_body_01.smd",
    "female_02_body_04.smd"
  },
  Legs = {
    "female_02_leg_01.smd",
    "female_02_leg_02.smd",
  },
  Skins = {
    "models/humans/modern/female/sheet_01.vtf",
    "models/humans/modern/female/sheet_02.vtf",
    "models/humans/modern/female/sheet_03.vtf",
    "models/humans/modern/female/sheet_04.vtf",
    "models/humans/modern/female/sheet_05.vtf",
    "models/humans/modern/female/sheet_06.vtf",
    "models/humans/modern/female/sheet_08.vtf",
    "models/humans/modern/female/sheet_09.vtf",
    "models/humans/modern/female/sheet_10.vtf",
    "models/humans/modern/female/sheet_11.vtf",
    "models/humans/modern/female/sheet_12.vtf",
    "models/humans/modern/female/sheet_13.vtf",
    "models/humans/modern/female/sheet_14.vtf",
    "models/humans/modern/female/sheet_15.vtf",

  }
}

PlayerModels.Female["player/humans/modern/female/female_03.mdl"] = {
  Body = {
    "female_03_body_01.smd",
    "female_03_body_04.smd"
  },
  Legs = {
    "female_03_leg_01.smd",
    "female_03_leg_02.smd",
  },
  Skins = {
    "models/humans/modern/female/sheet_01.vtf",
    "models/humans/modern/female/sheet_02.vtf",
    "models/humans/modern/female/sheet_03.vtf",
    "models/humans/modern/female/sheet_04.vtf",
    "models/humans/modern/female/sheet_05.vtf",
    "models/humans/modern/female/sheet_06.vtf",
    "models/humans/modern/female/sheet_08.vtf",
    "models/humans/modern/female/sheet_09.vtf",
    "models/humans/modern/female/sheet_10.vtf",
    "models/humans/modern/female/sheet_11.vtf",
    "models/humans/modern/female/sheet_12.vtf",
    "models/humans/modern/female/sheet_13.vtf",
    "models/humans/modern/female/sheet_14.vtf",
    "models/humans/modern/female/sheet_15.vtf",

  }
}

PlayerModels.Female["player/humans/modern/female/female_04.mdl"] = {
  Body = {
    "female_04_body_01.smd",
    "female_04_body_04.smd"
  },
  Legs = {
    "female_04_leg_01.smd",
    "female_04_leg_02.smd",
  },
  Skins = {
    "models/humans/modern/female/sheet_01.vtf",
    "models/humans/modern/female/sheet_02.vtf",
    "models/humans/modern/female/sheet_03.vtf",
    "models/humans/modern/female/sheet_04.vtf",
    "models/humans/modern/female/sheet_05.vtf",
    "models/humans/modern/female/sheet_06.vtf",
    "models/humans/modern/female/sheet_08.vtf",
    "models/humans/modern/female/sheet_09.vtf",
    "models/humans/modern/female/sheet_10.vtf",
    "models/humans/modern/female/sheet_11.vtf",
    "models/humans/modern/female/sheet_12.vtf",
    "models/humans/modern/female/sheet_13.vtf",
    "models/humans/modern/female/sheet_14.vtf",
    "models/humans/modern/female/sheet_15.vtf",

  }
}

PlayerModels.Female["player/humans/modern/female/female_05.mdl"] = {
  Body = {
    "female_05_body_01.smd",
    "female_05_body_04.smd"
  },
  Legs = {
    "female_05_leg_01.smd",
    "female_05_leg_02.smd",
  },
  Skins = {
    "models/humans/modern/female/sheet_01.vtf",
    "models/humans/modern/female/sheet_02.vtf",
    "models/humans/modern/female/sheet_03.vtf",
    "models/humans/modern/female/sheet_04.vtf",
    "models/humans/modern/female/sheet_05.vtf",
    "models/humans/modern/female/sheet_06.vtf",
    "models/humans/modern/female/sheet_08.vtf",
    "models/humans/modern/female/sheet_09.vtf",
    "models/humans/modern/female/sheet_10.vtf",
    "models/humans/modern/female/sheet_11.vtf",
    "models/humans/modern/female/sheet_12.vtf",
    "models/humans/modern/female/sheet_13.vtf",
    "models/humans/modern/female/sheet_14.vtf",
    "models/humans/modern/female/sheet_15.vtf",

  }
}

PlayerModels.Female["player/humans/modern/female/female_06.mdl"] = {
  Body = {
    "female_06_body_01.smd",
    "female_06_body_04.smd"
  },
  Legs = {
    "female_06_leg_01.smd",
    "female_06_leg_02.smd",
  },
  Skins = {
    "models/humans/modern/female/sheet_01.vtf",
    "models/humans/modern/female/sheet_02.vtf",
    "models/humans/modern/female/sheet_03.vtf",
    "models/humans/modern/female/sheet_04.vtf",
    "models/humans/modern/female/sheet_05.vtf",
    "models/humans/modern/female/sheet_06.vtf",
    "models/humans/modern/female/sheet_08.vtf",
    "models/humans/modern/female/sheet_09.vtf",
    "models/humans/modern/female/sheet_10.vtf",
    "models/humans/modern/female/sheet_11.vtf",
    "models/humans/modern/female/sheet_12.vtf",
    "models/humans/modern/female/sheet_13.vtf",
    "models/humans/modern/female/sheet_14.vtf",
    "models/humans/modern/female/sheet_15.vtf",

  }
}

SharedPlayerModels.Female["player/humans/modern/female/shared/female_01.mdl"] = {
  Skins = {
    "models/humans/modern/female/medic_sheet.vtf",
    "models/humans/modern/female/police_sheet.vtf",    
  }
}
SharedPlayerModels.Female["player/humans/modern/female/shared/female_02.mdl"] = {
  Skins = {
    "models/humans/modern/female/medic_sheet.vtf",
    "models/humans/modern/female/police_sheet.vtf",    
  }
}
SharedPlayerModels.Female["player/humans/modern/female/shared/female_03.mdl"] = {
  Skins = {
    "models/humans/modern/female/medic_sheet.vtf",
    "models/humans/modern/female/police_sheet.vtf",    
  }
}
SharedPlayerModels.Female["player/humans/modern/female/shared/female_04.mdl"] = {
  Skins = {
    "models/humans/modern/female/medic_sheet.vtf",
    "models/humans/modern/female/police_sheet.vtf",    
  }
}
SharedPlayerModels.Female["player/humans/modern/female/shared/female_05.mdl"] = {
  Skins = {
    "models/humans/modern/female/medic_sheet.vtf",
    "models/humans/modern/female/police_sheet.vtf",    
  }
}
SharedPlayerModels.Female["player/humans/modern/female/shared/female_06.mdl"] = {
  Skins = {
    "models/humans/modern/female/medic_sheet.vtf",
    "models/humans/modern/female/police_sheet.vtf",    
  }
}