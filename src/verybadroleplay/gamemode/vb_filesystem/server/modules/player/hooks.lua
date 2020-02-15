function GM:DoPlayerDeath(ply, attacker, dmg)
  
  ply:CreateRagdoll()
  
end
-- No HL2 beep
function GM:PlayerDeathSound() return true end

local nextSpawnDelay = 5 -- Dev server delay 
function GM:PostPlayerDeath(pl)
  pl:UpdateMoney(450, "sub")
  pl:SetDTUnconscious(true)
  pl.NextSpawn = RealTime() + nextSpawnDelay

end


function GM:PlayerDeathThink(pl)

  if pl.NextSpawn and RealTime() > pl.NextSpawn then
    pl:Spawn()
    pl.CannotBeRevived = nil
    pl:SetDTUnconscious(false)
    pl:UpdateMoney(450, "sub")
  end

end