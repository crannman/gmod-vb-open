hook.Add("VBHOOK::OnJobChanged", "VBHOOK::OnJobChanged::Cook", function(ply, oldTeam, newTeam)

  if oldTeam == TEAM_COOK then
    ply:FlushFoodIngredientsInventory()
  end

end)