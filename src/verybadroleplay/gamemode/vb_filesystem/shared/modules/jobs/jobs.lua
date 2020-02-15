function VBJOB.RegisterJob(teamIdentifier, jobTable, inheritedJob)

  if inheritedJob then
    VBJOB.JobTable[teamIdentifier] = table.Copy(VBJOB.JobTable[inheritedJob])
    for k, v in pairs(jobTable) do
      VBJOB.JobTable[teamIdentifier][k] = v
    end
  else
    VBJOB.JobTable[teamIdentifier] = jobTable
  end
end

function VBJOB.GetJob(ply)

  return VBJOB.JobTable[ply:Team()]
end

function VBJOB.GetCount(team)
  local sum = 0
  for k, v in ipairs(player.GetHumans()) do
    if v:Team() == team then
      sum = sum + 1
    end
  end
  return sum
end

function VBJOB.GetJobInfos(job)
  if VBJOB.JobTable[job] then
    return VBJOB.JobTable[job]
  end
  return VBJOB.JobTable[TEAM_CITIZEN]
end
