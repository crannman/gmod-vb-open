local either = Either
local isvalid = IsValid
hook.Add("PlayerCanHearPlayersVoice", "VBHOOK::VoiceHandling", function(listener, talker)
  
  local listenerJob = VBJOB.GetJobInfos(listener:Team())
  local talkerJob = VBJOB.GetJobInfos(talker:Team())
  -- The two players must be in police group and alive and outside of the voice range
  if listenerJob.Police and listener:Alive() and talkerJob.Police and talker:Alive() and listener:GetPos():DistToSqr(talker:GetPos()) > 250000 then
    local listenerRadioState = either(
                                isvalid(listener:GetWeapon("vbrp_police_radio")),
                                listener:GetWeapon("vbrp_police_radio"):GetDTRadioActivated(), 
                                false)                    
    local talkerRadioState = either(
                                isvalid(talker:GetWeapon("vbrp_police_radio")),
                                talker:GetWeapon("vbrp_police_radio"):GetDTRadioActivated(),
                                false)
    -- If the talker is a passenger in a police vehicle and member of the police group, let them talk in the radio.
    if talker:InVehicle() and isvalid(talker:GetVehicle():GetParent()) then
      return listenerRadioState and talkerRadioState and talker:GetVehicle():GetParent():GetKeyValues()["VehicleScript"] == "scripts/vehicles/mas_ghibli_pol.txt"
    end
    -- Both radios are activated, the talker must have the radio in their hands.
    if talker:InVehicle() then
      return listenerRadioState and talkerRadioState and talker:GetVehicle():GetKeyValues()["VehicleScript"] == "scripts/vehicles/mas_ghibli_pol.txt"
    end
    return listenerRadioState and talkerRadioState and talker:GetActiveWeapon():GetClass() == "vbrp_police_radio"
  end
  -- Apply this rule otherwise. (~500 hammer units)
  if listener:GetPos():DistToSqr(talker:GetPos()) > 250000 then 
    return false
  end
  if not talker:Alive() then return false end
end)