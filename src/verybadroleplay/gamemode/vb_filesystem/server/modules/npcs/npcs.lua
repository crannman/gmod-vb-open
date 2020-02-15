util.AddNetworkString("VBNET_StartNextBotFunc")
util.AddNetworkString("VBNET_SendNPCDialog")

local VBNPCs_Tables = {
  [1] = {
    Name = "Thomas Klein",
    Desc = "Police",
    Model = "models/player/humans/modern/male/police/male_09.mdl",
    Spawnpoint = {
      Vector = Vector(-7710, -9472, 528),
      Angle = Angle(0, 0, 0)
    },
    SequenceToPlay = "walk_all"
  },
  [2] = {
    Name = "Francois Maqueraux",
    Desc = "RealEstateNEXTBOT__DEV0",
    Model = "models/Humans/Group01/male_08.mdl",
    Spawnpoint = {
      Vector = Vector(-10738.419922, -8980.822266, 136.031250),
      Angle = Angle(0, 0, 0)
    }
  },
  [3] = {
    Name = "Frank Polikoviski",
    Desc = "Flea Market",
    Model = "models/Humans/Group01/male_07.mdl",
    Spawnpoint = {
      Vector = Vector(-5129.830078, -7569.095215, 136.031250),
      Angle = Angle(0, -90, 0)
    }
  },
  [4] = {
    Name = "Pierre Aglou",
    Desc = "RealEstateNEXTBOT__DEV1",
    Model = "models/Humans/Group01/male_06.mdl",
    Spawnpoint = {
      Vector = Vector(-4802, -4498, 264),
      Angle = Angle(0, -90, 0)
    }
  },
  [5] = {
    Name = "Martin Blake",
    Desc = "RealEstateNEXTBOT__DEV2",
    Model = "models/Humans/Group01/male_02.mdl",
    Spawnpoint = {
      Vector = Vector(617, 4477, 136),
      Angle = Angle(0, 90, 0)
    }
  },
  [6] = {
    Name = "Olivia Bach",
    Desc = "RealEstateNEXTBOT__DEV3",
    Model = "models/mossman.mdl",
    Spawnpoint = {
      Vector = Vector(-7214, -9243, 136),
      Angle = Angle(-3, 90, 0)
    }
  },
  [7] = {
    Name = "Stephen Steve",
    Desc = "Pompiers",
    Model = "models/Humans/Group01/male_03.mdl",
    Spawnpoint = {
      Vector = Vector(-3620, -7157, 262),
      Angle = Angle(0, 90, 0)
    }
  },
  [8] = {
    Name = "Jane Doe",
    Desc = "Apparence",
    Model = "models/alyx.mdl",
    Spawnpoint = {
      Vector = Vector(-5014, -6443, 136),
      Angle = Angle(0, 90, 0)
    }
  },
  [9] = {
    Name = "Calvin Benson",
    Desc = "Garage",
    Model = "models/Humans/Group01/male_04.mdl",
    Spawnpoint = {
      Vector = Vector(-4825, -10717, 135),
      Angle = Angle(0, 90, 0)
    }
  },
  [10] = {
    Name = "Hermann Mayer",
    Desc = "Concessionnaire",
    Model = "models/Humans/Group01/male_05.mdl",
    Spawnpoint = {
      Vector = Vector(5568, -4378, 128),
      Angle = Angle(0, -113, 0)
    }
  },
  [11] = {
    Name = "Robert",
    Desc = " ",
    Model = "models/Humans/Group01/male_05.mdl",
    Spawnpoint = {
      Vector = Vector(-12719, 14665, 246),
      Angle = Angle(3, -54, 0)
    },
    SequenceToPlay = "sit_ground"
  },
  [12] = {
    Name = "Archibald Dublanc",
    Desc = "Garage",
    Model = "models/Humans/Group01/male_05.mdl",
    Spawnpoint = {
      Vector = Vector(4560, -4696, 128),
      Angle = Angle(0, -180, 0)
    },
  },
  [13] = {
    Name = "Edd Marks",
    Desc = "Personnalisation de véhicule",
    Model = "models/Humans/Group01/male_07.mdl",
    Spawnpoint = {
      Vector = Vector(4560, -4591, 128),
      Angle = Angle(0, -180, 0)
    }
  },
  [14] = {
    Name = "Stephan Crawford",
    Desc = "Médecin",
    Model = "models/Humans/Group01/male_09.mdl",
    Spawnpoint = {
      Vector = Vector(-9642, 9181, 136),
      Angle = Angle(0, 90, 0)
    }
  },
  [15] = {
    Name = "Jonathan Blake",
    Desc = "Garage de police",
    Model = "models/player/humans/modern/male/police/male_07.mdl",
    RestrictTo = "Police",
    RestrictMessage = "Qu'est-ce que vous faites ici ?",
    Spawnpoint = {
      Vector = Vector(-7090, -9055, -120),
      Angle = Angle(0, -180, 0)
    },
    SequenceToPlay = "walk_all"
  },
  [16] = {
    Name = "Connie Lambert",
    Desc = "Ambulances",
    Model = "models/Humans/Group01/female_01.mdl",
    RestrictTo = "Medic",
    RestrictMessage = "Bonjour",
    Spawnpoint = {
      Vector = Vector(-9860, 9418, 136),
      Angle = Angle(0, 0, 0)
    }
  },
  [17] = {
    Name = "Mehdi Keet",
    Desc = "Soins",
    Model = "models/Humans/Group01/male_01.mdl",
    Spawnpoint = {
      Vector = Vector(-9388, 9438, 136),
      Angle = Angle(0, -50, 0)
    }
  },
  [18] = {
    Name = "Gérard Géladal",
    Desc = "Épicerie",
    Model = "models/Humans/Group01/male_07.mdl",
    Spawnpoint = {
      Vector = Vector(-7461, -6603, 136),
      Angle = Angle(0, 90, 0)
    }
  },
}
-- @desc Créer les Next Bots sur le serveur;
-- @realm Server;
function CreateNextBots()
  for _, v in pairs(VBNPCs_Tables) do
    local npc = ents.Create("vbrp_npc")
    npc:Spawn()
    npc:SetModel(v["Model"])
    npc:SetDTName(v["Name"])
    npc:SetDTDesc(v["Desc"])
    npc:SetPos(v["Spawnpoint"]["Vector"] - Vector(0, 0, 35))
    npc:SetAngles(v["Spawnpoint"]["Angle"])
    if v["SequenceToPlay"] ~= nil then
      function npc:RunBehaviour()
          self:StartActivity(ACT_IDLE)
          self:SetSequence(v["SequenceToPlay"])
          coroutine.yield()
      end
    else
      function npc:BehaveAct() end
      function npc:RunBehaviour() end
      function npc:BehaveStart() self:StartActivity(ACT_IDLE) end
    end

    VBRP.log("Registered a new NPC: " .. v["Name"], "VB-Framework::NextBots")
  end
end

-- @desc Respawn les Next Bots sur le serveur;
-- @realm Server;
function RespawnNextBots()
  for _, v in pairs(ents.FindByClass("vbrp_npc")) do
    v:Remove()
  end

  CreateNextBots()
end

function GetNPCTableFromName(name)
  for k, v in ipairs(VBNPCs_Tables) do
    if v.Name == name then return v end
  end
end

hook.Add("InitPostEntity", "VBHOOK_CreateNextBots", CreateNextBots)