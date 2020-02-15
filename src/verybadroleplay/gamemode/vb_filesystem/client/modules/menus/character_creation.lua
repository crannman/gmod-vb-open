local isNameAvailable = false
function DrawCharacterCreationMenu(csEntity)

  local currentSex = "male"
  local materialIndex = 1
  local skinIndex = 1
  local facemapIndex = 0
  local bodyIndex = 1
  local legIndex = 1

  local window = vgui.Create("DFrame")
  window:SetSize(ScrW(), ScrH())
  window:SetTitle("")
  window:SetDraggable(false)
  window:SetSizable(false)
  window:ShowCloseButton(false)
  window:MakePopup()
  local startWindow = ScrW() / 2 - 200
  local windowH = ScrH() * .75
  function window:Paint()
    draw.RoundedBox(0, startWindow , windowH , 400, 155, COLOR_MENU_BACK)
  end
  local buttonMale = CreateButtonAlt(window)
  buttonMale:SetSize(185, 30)
  buttonMale:SetPos(startWindow + 10, windowH + 80)
  buttonMale:SetText(Translate("cc_sex_male"))
  function buttonMale:DoClick()
    UpdateClientsideModel("models/player/humans/modern/male/male_01.mdl", csEntity)
    currentSex = "male"
    materialIndex = 1
    facemapIndex = 0
    bodyIndex = 1
    legIndex = 1
    csEntity:SetSubMaterial(4, PlayerModels.Male["player/humans/modern/male/male_01.mdl"]["Skins"][1])
    csEntity:SetSubMaterial(9, PlayerModels.Male["player/humans/modern/male/male_01.mdl"]["Skins"][1])
  end
  local buttonFemale = CreateButtonAlt(window)
  buttonFemale:SetSize(185, 30)
  buttonFemale:SetPos(startWindow + 205, windowH + 80)
  buttonFemale:SetText(Translate("cc_sex_female"))
  function buttonFemale:DoClick()
    UpdateClientsideModel("models/player/humans/modern/female/female_01.mdl", csEntity)
    currentSex = "female"
    materialIndex = 1
    facemapIndex = 0
    bodyIndex = 1
    legIndex = 1
    csEntity:SetSubMaterial(4, PlayerModels.Female["player/humans/modern/female/female_01.mdl"]["Skins"][1])
    csEntity:SetSubMaterial(8, PlayerModels.Female["player/humans/modern/female/female_01.mdl"]["Skins"][1])
  end
  local entryFirstName = CreateTextEntry(window, "VBFONT_CHAR_CREATION_MENU")
  entryFirstName:SetSize(380, 30)
  entryFirstName:SetPos(startWindow + 10, windowH + 10)
  entryFirstName:SetPlaceholderText(Translate("cc_input_firstname"))

  local entryLastName = CreateTextEntry(window, "VBFONT_CHAR_CREATION_MENU")
  entryLastName:SetSize(380, 30)
  entryLastName:SetPos(startWindow + 10, windowH + 45)
  entryLastName:SetPlaceholderText(Translate("cc_input_lastname"))

  local buttonConfirm = CreateButtonAlt(window)
  buttonConfirm:SetSize(380, 30)
  buttonConfirm:SetPos(startWindow + 10, windowH + 115)
  buttonConfirm:SetText(Translate("cc_confirm"))
  function buttonConfirm:DoClick()
    local firstName = entryFirstName:GetText()
    local lastName = entryLastName:GetText()
    if #firstName >= 20 or #lastName >= 20 then
      MessageBoxShow(Translate("global_error"), Translate("cc_name_too_long"))
      return false
    end
    if #firstName == 0 or #lastName == 0 then
      MessageBoxShow(Translate("global_error"), Translate("cc_no_name_provided"))
      return false
    end
    
    if LocalPlayer():IsRegistered() and firstName == LocalPlayer():GetFirstName() and lastName == LocalPlayer():GetLastName() then
      isNameAvailable = true
    else
      net.Start("VBNET_RequestNameAvailability")
      net.WriteString(firstName)
      net.WriteString(lastName)
      net.SendToServer()
    end
    timer.Simple(0.5, function() 
      if isNameAvailable then
        local pmIdentifier = Either(currentSex == "male", "M", "F") .. "|" .. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. "|" .. materialIndex .. "|" .. legIndex .. "|" .. facemapIndex
        csEntity:Remove()
        if not LocalPlayer():IsRegistered() then
          net.Start("VBRP_RegisterPlayerInformations")
          net.WriteString(firstName)
          net.WriteString(lastName)
          net.WriteString(pmIdentifier)
          net.WriteString(Either(currentSex == "male", "m", "f"))
          net.WriteString(util.DateStamp())
          net.SendToServer()
        else
          net.Start("VBNET_RegisterModel")
          net.WriteString(pmIdentifier)
          net.SendToServer()
          if firstName ~= LocalPlayer():GetFirstName() or lastName ~= LocalPlayer():GetLastName() then
            net.Start("VBNET_UpdateRoleplayName")
            net.WriteString(firstName)
            net.WriteString(lastName)
            net.SendToServer()
          end
        end
        net.Start("VBNET_ResetViewEntity")
        net.SendToServer()
        self:GetParent():Close()
      else
        MessageBoxShow(Translate("global_error"), Translate("cc_name_already_exist"))
      end
    end)
  end
  local buttonChooseSkinLeft = CreateButtonAlt(window)
  buttonChooseSkinLeft:SetSize(40, 40)
  buttonChooseSkinLeft:SetPos(startWindow - 40, ScrH() / 2)
  buttonChooseSkinLeft:SetText("<")
  function buttonChooseSkinLeft:DoClick()
    if currentSex == "male" then
      local skinTable = PlayerModels.Male[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if legIndex - 1 == 0 then
        legIndex = #skinTable
      else
        legIndex = legIndex - 1
      end
      csEntity:SetSubMaterial(9, skinTable[legIndex])
    else
      local skinTable = PlayerModels.Female[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if legIndex - 1 == 0 then
        legIndex = #skinTable
      else
        legIndex = legIndex - 1
      end
      csEntity:SetSubMaterial(8, skinTable[legIndex])
    end
  end
  
  local buttonChooseSkinRight = CreateButtonAlt(window)
  buttonChooseSkinRight:SetSize(40, 40)
  buttonChooseSkinRight:SetPos(startWindow + 400, ScrH() / 2)
  buttonChooseSkinRight:SetText(">")
  function buttonChooseSkinRight:DoClick()
    if currentSex == "male" then
      local skinTable = PlayerModels.Male[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if legIndex + 1 > #skinTable then
        legIndex = 1
      else
        legIndex = legIndex + 1
      end
      csEntity:SetSubMaterial(9, skinTable[legIndex])
    else
      local skinTable = PlayerModels.Female[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if legIndex + 1 > #skinTable then
        legIndex = #skinTable
      else
        legIndex = legIndex + 1
      end
      csEntity:SetSubMaterial(8, skinTable[legIndex])
    end
  end
  
  local buttonChooseSkinUpperLeft = CreateButtonAlt(window)
  buttonChooseSkinUpperLeft:SetSize(40, 40)
  buttonChooseSkinUpperLeft:SetPos(startWindow - 40, ScrH() / 3)
  buttonChooseSkinUpperLeft:SetText("<")
  function buttonChooseSkinUpperLeft:DoClick()
    if currentSex == "male" then
      local skinTable = PlayerModels.Male[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if materialIndex - 1 == 0 then
        materialIndex = #skinTable
      else
        materialIndex = materialIndex - 1
      end
      csEntity:SetSubMaterial(4, skinTable[materialIndex])
    else
      local skinTable = PlayerModels.Female[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if materialIndex - 1 == 0 then
        materialIndex = #skinTable
      else
        materialIndex = materialIndex - 1
      end
      csEntity:SetSubMaterial(4, skinTable[materialIndex])
    end
  end
  
  local buttonChooseSkinUpperRight = CreateButtonAlt(window)
  buttonChooseSkinUpperRight:SetSize(40, 40)
  buttonChooseSkinUpperRight:SetPos(startWindow + 400, ScrH() / 3)
  buttonChooseSkinUpperRight:SetText(">")
  function buttonChooseSkinUpperRight:DoClick()
    if currentSex == "male" then
      local skinTable = PlayerModels.Male[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if materialIndex + 1 > #skinTable then
        materialIndex = 1
      else
        materialIndex = materialIndex + 1
      end
      csEntity:SetSubMaterial(4, skinTable[materialIndex])
    else
      local skinTable = PlayerModels.Female[csEntity:GetModel():TrimLeft("models/")]["Skins"]
      if materialIndex + 1 > #skinTable then
        materialIndex = 1
      else
        materialIndex = materialIndex + 1
      end
      csEntity:SetSubMaterial(4, skinTable[materialIndex])
    end
  end
  
  local buttonChooseSkinUpperLeft2 = CreateButtonAlt(window)
  buttonChooseSkinUpperLeft2:SetSize(40, 40)
  buttonChooseSkinUpperLeft2:SetPos(startWindow - 40, ScrH() / 6)
  buttonChooseSkinUpperLeft2:SetText("<")
  function buttonChooseSkinUpperLeft2:DoClick()
    if currentSex == "male" then
      if facemapIndex - 1 < 0 and skinIndex - 1 <= 0 then
        skinIndex = table.Count(PlayerModels.Male)
        local newModel = "models/player/humans/modern/male/male_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        UpdateClientsideModel(newModel, csEntity)
        facemapIndex = csEntity:SkinCount()
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex - 1 >= 0 then
        facemapIndex = facemapIndex - 1
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex - 1 < 0 and skinIndex - 1 > 0 then
        skinIndex = skinIndex - 1
        local newModel = "models/player/humans/modern/male/male_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        UpdateClientsideModel(newModel, csEntity)
        facemapIndex = csEntity:SkinCount()
        csEntity:SetSkin(facemapIndex)
      end
    else
      if facemapIndex - 1 < 0 and skinIndex - 1 <= 0 then
        skinIndex = table.Count(PlayerModels.Female)
        local newModel = "models/player/humans/modern/female/female_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        UpdateClientsideModel(newModel, csEntity)
        facemapIndex = csEntity:SkinCount()
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex - 1 >= 0 then
        facemapIndex = facemapIndex - 1
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex - 1 < 0 and skinIndex - 1 > 0 then
        skinIndex = skinIndex - 1
        local newModel = "models/player/humans/modern/female/female_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        UpdateClientsideModel(newModel, csEntity)
        facemapIndex = csEntity:SkinCount()
        csEntity:SetSkin(facemapIndex)
      end
    end
  end

  local buttonChooseSkinUpperRight2 = CreateButtonAlt(window)
  buttonChooseSkinUpperRight2:SetSize(40, 40)
  buttonChooseSkinUpperRight2:SetPos(startWindow + 400, ScrH() / 6)
  buttonChooseSkinUpperRight2:SetText(">")
  function buttonChooseSkinUpperRight2:DoClick()
    if currentSex == "male" then
      if facemapIndex + 1 > csEntity:SkinCount() and skinIndex + 1 > table.Count(PlayerModels.Male) then
        skinIndex = 1
        facemapIndex = 0
        local newModel = "models/player/humans/modern/male/male_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        local skinTable = PlayerModels.Male[newModel:TrimLeft("models/")]["Skins"]
        UpdateClientsideModel(newModel, csEntity)
        csEntity:SetSubMaterial(4, skinTable[materialIndex])
        csEntity:SetSubMaterial(9, skinTable[legIndex])
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex + 1 > csEntity:SkinCount() and skinIndex < table.Count(PlayerModels.Male) then
        skinIndex = skinIndex + 1 
        facemapIndex = 0
        local newModel = "models/player/humans/modern/male/male_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        local skinTable = PlayerModels.Male[newModel:TrimLeft("models/")]["Skins"]
        UpdateClientsideModel(newModel, csEntity)
        csEntity:SetSubMaterial(4, skinTable[materialIndex])
        csEntity:SetSubMaterial(9, skinTable[legIndex])
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex + 1 <= csEntity:SkinCount() then
        facemapIndex = facemapIndex + 1
        csEntity:SetSkin(facemapIndex)
      end
    else
      if facemapIndex + 1 > csEntity:SkinCount() and skinIndex + 1 > table.Count(PlayerModels.Female) then
        skinIndex = 1
        facemapIndex = 0
        local newModel = "models/player/humans/modern/female/female_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        local skinTable = PlayerModels.Female[newModel:TrimLeft("models/")]["Skins"]
        UpdateClientsideModel(newModel, csEntity)
        csEntity:SetSubMaterial(4, skinTable[materialIndex])
        csEntity:SetSubMaterial(9, skinTable[legIndex])
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex + 1 > csEntity:SkinCount() and skinIndex < table.Count(PlayerModels.Female) then
        skinIndex = skinIndex + 1 
        facemapIndex = 0
        local newModel = "models/player/humans/modern/female/female_".. Either(skinIndex < 10, "0" .. skinIndex, skinIndex) .. ".mdl"
        local skinTable = PlayerModels.Female[newModel:TrimLeft("models/")]["Skins"]
        UpdateClientsideModel(newModel, csEntity)
        csEntity:SetSubMaterial(4, skinTable[materialIndex])
        csEntity:SetSubMaterial(9, skinTable[legIndex])
        csEntity:SetSkin(facemapIndex)
      elseif facemapIndex + 1 <= csEntity:SkinCount() then
        facemapIndex = facemapIndex + 1
        csEntity:SetSkin(facemapIndex)
      end
    end
  end
end

net.Receive("VBNET_SendNameAvailability", function(len, ply)
  isNameAvailable = net.ReadBool()
end)