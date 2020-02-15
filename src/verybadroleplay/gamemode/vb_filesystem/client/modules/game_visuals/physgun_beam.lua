function GM:DrawPhysgunBeam(ply, physgun, enabled, target, bone, hitPos)

  if ply:IsModerator() then return false end
  return true
end