local notStorable = {
  ["scripts/vehicles/mas_ghibli_pol.txt"] = true
}
hook.Add("PlayerLeaveVehicle", "VBHOOK::CanThePlayerStoreTheirVehicle", function(pl, veh)

  if pl:SteamID() == veh:GetNWString("VB::NW::Car::Owner") and pl:IsInParking() and not notStorable[pl:GetVehicle():GetKeyValues()["VehicleScript"]] then
    net.Start("VBNET::Cars::PlayerLeavedVehicleWithinParking")
    net.Send(pl)
  end

end)

hook.Add("PlayerEnteredVehicle", "VBHOOK::SwitchWeaponOnVehicleEntrance", function(pl, veh)

  local keys = pl:GetWeapon("vbrp_keys")
  if IsValid(keys) then
    pl:SetActiveWeapon(keys)
  end

end)