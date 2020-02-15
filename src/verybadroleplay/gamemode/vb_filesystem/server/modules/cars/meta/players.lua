local VBRP_Player = FindMetaTable("Player")

function VBRP_Player:IsInParking()
  local isWithin = false
  for k,v in ipairs(VehStoreLocations) do
    if self:GetPos():WithinAABox(v.Min, v.Max) then
      isWithin = true
      break;
    end
  end
  return isWithin
end