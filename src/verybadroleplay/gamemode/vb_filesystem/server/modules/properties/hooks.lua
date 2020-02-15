VBRP_DoorsTable = { }

hook.Add("InitPostEntity", "VBHOOK::Properties::RetrieveAllDoors", function()
  for k, v in pairs(ents.GetAll()) do
    if v:IsDoor() then
      table.insert(VBRP_DoorsTable, v)
    end
  end
  hook.Run("VBHOOK::Internal::RegisterProperties")
end)