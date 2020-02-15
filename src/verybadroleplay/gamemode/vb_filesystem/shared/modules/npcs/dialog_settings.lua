local GlobalDialogSettings = {
  ["Thomas Klein"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog", --can be only one time
        Text = function()
          return Either(LocalPlayer():GetJob().Police, Translate("jo_police_dialog_alt"), Translate("jo_police_dialog"))
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Either(
            LocalPlayer():GetJob().Police,
            Translate("jo_police_answer_yes_alt"),
            Translate("jo_police_answer_yes")
          )
        end,
        Action = function(self)
          net.Start("VBNET_ChangeJob")
          net.WriteInt(Either(LocalPlayer():GetJob().Police, 1, 2), 8)
          net.SendToServer()
          self:GetParent():Remove()
        end
      },
      [99] = {
        Type = "NPC_Answer",
        Text = function()
          return Either(
            LocalPlayer():GetJob().Police,
            Translate("jo_police_answer_no_alt"),
            Translate("jo_police_answer_no")
          )
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Stephan Crawford"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog", --can be only one time
        Text = function()
          return Either(
            LocalPlayer():Team() == TEAM_MEDIC,
            Translate("jo_medic_dialog_alt"),
            Translate("jo_medic_dialog")
          )
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Either(
            LocalPlayer():Team() == TEAM_MEDIC,
            Translate("jo_medic_answer_yes_alt"),
            Translate("jo_medic_answer_yes")
          )
        end,
        Action = function(self)
          net.Start("VBNET_ChangeJob")
          net.WriteInt(Either(LocalPlayer():Team() == TEAM_MEDIC, 1, 3), 8)
          net.SendToServer()
          self:GetParent():Remove()
        end
      },
      [99] = {
        Type = "NPC_Answer",
        Text = function()
          return Either(
            LocalPlayer():Team() == TEAM_MEDIC,
            Translate("jo_medic_answer_no_alt"),
            Translate("jo_medic_answer_no")
          )
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Francois Maqueraux"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("re_dialog1")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer1_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          net.Start("VBNET_PlayerTalkedToRealEstateAgent")
          net.WriteEntity(RetrieveNPCFromName("Francois Maqueraux"))
          net.SendToServer()
        end
      },
      [99] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer1_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Frank Polikoviski"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("fl_npc_dialog")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("fl_npc_answer_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          net.Start("VBNET_PlayerTalkedToFleaVendor")
          net.WriteEntity(RetrieveNPCFromName("Frank Polikoviski"))
          net.SendToServer()
        end
      },
      [99] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("fl_npc_answer_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Pierre Aglou"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("re_dialog2")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer2_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          net.Start("VBNET_PlayerTalkedToRealEstateAgent")
          net.WriteEntity(RetrieveNPCFromName("Pierre Aglou"))
          net.SendToServer()
        end
      },
      [99] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer2_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Martin Blake"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("re_dialog3")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer3_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          net.Start("VBNET_PlayerTalkedToRealEstateAgent")
          net.WriteEntity(RetrieveNPCFromName("Martin Blake"))
          net.SendToServer()
        end
      },
      [99] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer3_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Olivia Bach"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("re_dialog4")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer4_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          net.Start("VBNET_PlayerTalkedToRealEstateAgent")
          net.WriteEntity(RetrieveNPCFromName("Olivia Bach"))
          net.SendToServer()
        end
      },
      [99] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("re_answer4_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Stephen Steve"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("ecfd_job_offer")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("ecfd_answer_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          print("Work in progress")
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("ecfd_answer_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
          print("Work in progress")
        end
      }
    }
  },
  ["Jane Doe"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("cc_clothes_request")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cc_answer_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          StartCharacterCreation()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cc_answer_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Calvin Benson"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("cd_car_request")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_answer_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          StartGarageMenu()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_answer_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Hermann Mayer"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("cd_want_buy_veh")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_viewoffer_yes")
        end,
        Action = function(self)
          StartCarDealerMenu()
          self:GetParent():Remove()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_viewoffer_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Robert"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("dd_selling_request")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("dd_selling_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("dd_selling_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Archibald Dublanc"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("cd_car_request")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_answer_yes")
        end,
        Action = function(self)
          self:GetParent():Remove()
          StartGarageMenu()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_answer_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Edd Marks"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("cd_veh_want_custom")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_answer_yes")
        end,
        Action = function(self)
          StartCarCustomizationMenu()
          self:GetParent():Remove()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("cd_answer_no")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Jonathan Blake"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return "gar_police_dialog"
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return "gar_police_want_veh"
        end,
        Action = function(self)
          net.Start("VBNET::Jobs::Police::SpawnVehicle")
          net.SendToServer()
          self:GetParent():Remove()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return "gar_police_cancel"
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Connie Lambert"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return "spital_dlg_want_veh"
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return "spital_dlg_want_veh_confirm"
        end,
        Action = function(self)
          net.Start("VBNET::Jobs::Medic::SpawnAmbulance")
          net.SendToServer()
          self:GetParent():Remove()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return "spital_dlg_want_veh_deny"
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Mehdi Keet"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return "spital_want_heal"
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return "spital_want_heal_confirm"
        end,
        Action = function(self)
          net.Start("VBNET::Jobs::Medic::HealWhileNoMedic")
          net.SendToServer()
          self:GetParent():Remove()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return "spital_want_heal_deny"
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  },
  ["Gérard Géladal"] = {
    DialogSettings = {
      [1] = {
        Type = "NPC_Dialog",
        Text = function()
          return Translate("grocery_hello")
        end,
        Action = nil
      },
      [2] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("grocery_buy_ingredients")
        end,
        Action = function(self)
          net.Start("VBNET::Jobs::Cook::Ingredients::OpenCookShop")
          net.SendToServer()
          self:GetParent():Remove()
        end
      },
      [3] = {
        Type = "NPC_Answer",
        Text = function()
          return Either(
            LocalPlayer():Team() == TEAM_COOK,
            Translate("grocery_stop_being_cook"),
            Translate("grocery_become_cook")
          )
        end,
        Action = function(self)
          net.Start("VBNET_ChangeJob")
          net.WriteInt(Either(LocalPlayer():Team() == TEAM_COOK, TEAM_CITIZEN, TEAM_COOK), 8)
          net.SendToServer()
          self:GetParent():Remove()
        end
      },
      [4] = {
        Type = "NPC_Answer",
        Text = function()
          return Translate("grocery_quit")
        end,
        Action = function(self)
          self:GetParent():Remove()
        end
      }
    }
  }
}

-- @desc Récupère les paramètres d'un dialogue en fonction d'un nom de NPC;
-- @args string bot_name;
-- @realm Shared;
-- @return table DialogSettings
function FetchNPCDialog(bot_name)
  return GlobalDialogSettings[bot_name]["DialogSettings"]
end

--[[-------------------------------------------------------------------------
Network reception
---------------------------------------------------------------------------]]
net.Receive(
  "VBNET_FLEA_ConfirmPlayerIsNearToNPC",
  function()
    StartFleaMarketMenu()
  end
)
