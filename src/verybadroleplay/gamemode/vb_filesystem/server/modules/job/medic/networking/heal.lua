local addNetworkString = util.AddNetworkString
local recv = net.Receive
addNetworkString("VBNET::Jobs::Medic::HealWhileNoMedic")

recv("VBNET::Jobs::Medic::HealWhileNoMedic", function(len, pl)

  local count = VBJOB.GetCount(TEAM_MEDIC)
  if pl:Team() ~= TEAM_MEDIC and count > 0 then
    NotifyPlayer("Il y a des médecins, allez les voir, ils seront très heureux de pouvoir vous aider", pl)
  end

  if pl:Team() == TEAM_MEDIC then
    NotifyPlayer("Haha très bonne blague", pl)
  end

  if count == 0 and pl:Health() == 100 then
    NotifyPlayer("Des soins seraient inutiles pour vous, vous êtes déjà en bonne santé !", pl)
  elseif count == 0 then
    pl:SetHealth(100)
    pl:UpdateMoney(100, "sub")
    NotifyPlayer("Vous avez payé 100 VB$ pour les soins", pl)
  end

end)