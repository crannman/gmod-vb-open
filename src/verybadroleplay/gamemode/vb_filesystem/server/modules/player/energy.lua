local delayToZero = 1800
hook.Add("PlayerSpawn", "VBHOOK::DecreaseEnergyOverTime", function(pl, transition)
  local amountBetweenSteps = 100 / delayToZero
  pl.ShouldDecreaseHealth = false
  if timer.Exists("VBTIMER::DecreaseEnergyOverTime::" .. pl:SteamID64()) then 
    timer.Remove("VBTIMER::DecreaseEnergyOverTime::" .. pl:SteamID64())
  end

  timer.Create("VBTIMER::DecreaseEnergyOverTime::" .. pl:SteamID64(), 1, 0, function()
    if not IsValid(pl) or not pl:Alive() then timer.Remove("VBTIMER::DecreaseEnergyOverTime::" .. pl:SteamID64()) return false end
    if pl:GetEnergy() - amountBetweenSteps <= 0 then
      pl.ShouldDecreaseHealth = true
      pl:SetEnergy(0)
    else
      if pl.ShouldDecreaseHealth then pl.ShouldDecreaseHealth = false end
      pl:SetEnergy(pl:GetEnergy() - amountBetweenSteps)
    end
  end)

  if timer.Exists("VBTIMER::DecreaseHealthDueToEnergy::" .. pl:SteamID64()) then 
    timer.Remove("VBTIMER::DecreaseHealthDueToEnergy::" .. pl:SteamID64())
  end

  timer.Create("VBTIMER::DecreaseHealthDueToEnergy::" .. pl:SteamID64(), 35, 0, function()
    if not IsValid(pl) or not pl:Alive() then return false end
    if pl.ShouldDecreaseHealth then
      if pl:Health() <= 15 then return false end
      if pl:Health() - 5 <= 15 then
        pl:SetHealth(15)
      else
        pl:SetHealth(pl:Health() - 5)
      end
    end
  end)
end)