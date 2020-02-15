function VBJOB.SetJob(ply, jobId)

  hook.Run("VBHOOK::OnJobChanged", ply, ply:Team(), jobId)
  
  local job = VBJOB.GetJobInfos(jobId)
  
  ply:SetTeam(jobId)

  for k,v in ipairs(ents.FindByClass("prop_vehicle_jeep")) do
    if v:GetNWString("VB::NW::Car::Owner") == ply:SteamID() then
      v:Remove()
    end
  end

  ply:StripWeapons()
  ply:MakeLoadout()

  if job.Armor then
    ply:SetArmor(job.Armor)
  end
  job:ApplyModel(ply)
end