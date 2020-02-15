function GM:PhysgunPickup(ply, ent)
  local authorized = {
    ["vbrp_item"] = true,
  }
  if ent:GetNWBool("VB::NW::Bool::Flag::MapEntity") then return false end
  
  if ent:GetClass() == "prop_vehicle_jeep" and ply:IsModerator() then
    return true
  end
  
  if ent:IsPlayer() and ply:IsModerator() and ent:Alive() and ply:GetDTRank() > ent:GetDTRank() then
    ent:SetMoveType(MOVETYPE_NONE)
    return true
  end
  
  local owner = nil

  if not ent:IsPlayer() and ent.GetDTOwner then
    owner = GetPlayerBySteamID(ent:GetDTOwner())
  end

  if ent:GetClass() == "vbrp_item" and ent:GetEntOwner() ~= ply:GetCompleteName() and owner:IsFriendWith(ply:SteamID()) then return true end

  if authorized[ent:GetClass()] and ent:GetEntOwner() == ply:GetCompleteName() then return true end
  
  if not ent.GetDTOwner then return false end

  return false
end

function GM:PhysgunDrop(ply, ent)
  if ent:IsPlayer() then
    ent:SetMoveType(MOVETYPE_WALK)
  end
end

function GM:GravGunPunt(ply, ent)

  return false

end