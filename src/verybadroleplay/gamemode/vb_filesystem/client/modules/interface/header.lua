local pl = LocalPlayer
local entity = Entity
local ipairs = ipairs
local either = Either
local findInSphere = ents.FindInSphere
local clr = Color
local hsv2clr = HSVToColor
local curTime = CurTime
local s3d2d = cam.Start3D2D
local e3d2d = cam.End3D2D
local drawText = draw.DrawText
hook.Add("PostDrawTranslucentRenderables", "VBHOOK::HeaderDisplay", function()

  for k, v in ipairs(findInSphere(pl():GetPos(), 350)) do
    if v:IsPlayer() and v ~= pl() and v:GetMoveType() ~= MOVETYPE_NOCLIP and (v:GetObserverMode() == OBS_MODE_NONE or v:GetObserverMode() == OBS_MODE_IN_EYE)  then

      local alpha = v:DistanceToAlpha(1.5)
      local name = either(v:GetCompleteName() ~= "", v:GetCompleteName(), "")
      local status = either(v:GetStatus() ~= "", v:GetStatus(), "")
      local org = either(v:GetNWString("VB::NW::Organization::Name") ~= "VB-Default-Organization", v:GetNWString("VB::NW::Organization::Name"), "")
      local orgClr = clr(255, 255, 255, alpha)
      local namClr = clr(255, 255, 255, alpha)

      if v:IsBot() then
        name = "VB Bot"
        org = "Ain't nobody got time for that!"
        namClr = hsv2clr(curTime() % 6 * 60, 1, 1)
        orgClr = hsv2clr(curTime() % 6 * 60, 1, 1)
      else
        orgClr = HexToColorRGB(v:GetNWString("VB::NW::Organization::Color"))
      end
      local headPos, headAng = v:GetBonePosition(v:LookupBone("ValveBiped.Bip01_Head1"))
      if not v:Alive() and v:GetDTDeathRagdollIndex() ~= -1 and IsValid(entity(v:GetDTDeathRagdollIndex())) then
        headPos, headAng = entity(v:GetDTDeathRagdollIndex()):GetBonePosition(entity(v:GetDTDeathRagdollIndex()):LookupBone("ValveBiped.Bip01_Head1"))
      end
      local pos = headPos + Vector(0, 0, 16)
      local ang = EyeAngles()
      ang:RotateAroundAxis(ang:Right(), 90)
      ang:RotateAroundAxis(ang:Up(), -90)
      
      s3d2d(pos, ang, .05)
      if status ~= "" and status ~= nil then
        drawText(status, "VBFONT_NamesDisplay", 0, -75, clr(0, 125, 255, alpha), TEXT_ALIGN_CENTER)
      end
      drawText(name, "VBFONT_NamesDisplay", 0, 0, clr(namClr.r, namClr.g, namClr.b, alpha), TEXT_ALIGN_CENTER)
      drawText(org, "VBFONT_NamesDisplaySMALL", 0, 75, clr(orgClr.r, orgClr.g, orgClr.b, alpha), TEXT_ALIGN_CENTER)
      e3d2d()
    end
  end

end)