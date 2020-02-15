function UpdateClientsideModel(newModel, cse)
  if cse then
    cse:SetModel(newModel)
    timer.Simple(0, function() return end)
    cse:ResetSequenceInfo()
    cse:ResetSequence("pose_standing_02")
  end
end
function StartCharacterCreation()
  net.Start("VBNET_SetViewEntity")
  net.SendToServer()
  local cse = ClientsideModel("models/player/humans/modern/male/male_01.mdl", RENDER_GROUP_OPAQUE_ENTITY)
  cse:SetPos(Vector(-3663, -4623, 904 - 64))
  cse:SetAngles(Angle(-1, 178, 0))
  cse:SetRenderAngles(Angle(-1, 178, 0))
  cse:SetRenderOrigin(Vector(-3663, -4623, 904 - 64))
  cse:SetupBones()
  cse:Spawn()
  cse:ResetSequenceInfo()
  cse:ResetSequence("pose_standing_02")
  cse:SetSubMaterial(4, PlayerModels.Male["player/humans/modern/male/male_01.mdl"]["Skins"][1])
  DrawCharacterCreationMenu(cse)

end
