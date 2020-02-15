local entity = Entity
local isvalid = IsValid
hook.Add("CalcView", "VBHOOK::DeathRagdollCam", function(pl, origin, ang, fov, znear, zfar)

  if not pl:Alive() and pl:GetDTDeathRagdollIndex() ~= -1 and isvalid(entity(pl:GetDTDeathRagdollIndex())) then
    local ent = entity(pl:GetDTDeathRagdollIndex())
    local eyes = ent:GetAttachment(ent:LookupAttachment("eyes"))
    local view = {
      origin = eyes.Pos,
      angles = eyes.Ang,
      fov = fov,
    }
    return view
  end

  -- return false
end)