net.Receive("VBNET::Cars::PlayerLeavedVehicleWithinParking", function() 

  local content = {
    Text = "Voulez-vous ranger votre véhicule ?",
    Title = "Ranger son véhicule",
    Buttons = {
      [1] = {
        Label = "Oui",
        Callback = function()
          net.Start("VBNET::Cars::StoreVehicle")
          net.SendToServer()
        end
      },
      [2] = {
        Label = "Non",
        Callback = nil
      }
    }
  }
  CustomMessageBoxShow(content)
  
end)