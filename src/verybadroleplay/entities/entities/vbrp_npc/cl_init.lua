include("shared.lua")

function ENT:Draw()
  self:DrawModel()
  local alpha = self:DistanceToAlpha()
  local text = "Base NextBOT"
  local desc = "NextBOT placeholder description"
  local col = Color(255, 255, 0, alpha)
  local col2 = Color(255, 255, 0, alpha)
  if self:GetEntityName() ~= "" then
    text = self:GetEntityName()
    col = Color(255, 255, 255, alpha)
  end
  if self:GetEntityDesc() ~= "" then
    desc = self:GetEntityDesc()
    col2 = Color(1, 218, 88, alpha)
  end
  local HeadPos, _ = self:GetBonePosition(self:LookupBone("ValveBiped.Bip01_Head1"))
  local Pos = HeadPos + Vector(0, 0, 15)
  local Ang = EyeAngles()
  Ang:RotateAroundAxis(Ang:Right(), 90)
  Ang:RotateAroundAxis(Ang:Up(), -90)
  if alpha > 0 then
    cam.Start3D2D(Pos, Ang, .05)
    draw.DrawText(text, "VBFONT_NamesDisplay", 0, 0, col, TEXT_ALIGN_CENTER)
    draw.DrawText(desc, "VBFONT_NamesDisplaySMALL", 0, 75, col2, TEXT_ALIGN_CENTER)
    cam.End3D2D()
  end
end
net.Receive("VBNET_StartNextBotFunc", function(len, ply)
  local _Entity = net.ReadEntity()
  local Settings = FetchNPCDialog(_Entity:GetEntityName())
  CreateNPCDialog(_Entity:GetEntityName(), Settings)
end)