GM.Name = "Very Bad Roleplay";
GM.Author = "Azzen";
_VBVERSIONNUMBER = "0.7.5"
_VBVERSIONSTATE = "Alpha"
--*-- Namespaces --*--
VBRP = VBRP or {}
VBJOB = { }
VBJOB.__index = VBJOB
VBJOB.JobTable = { }
function VBRP.log(str, custom_msg)
  if custom_msg ~= nil then
    MsgC(Color(64, 224, 208), "[" .. custom_msg .. "] " .. str .. "\n")
  else
    MsgC(Color(64, 224, 208), "[VB-Framework] " .. str .. "\n")
  end
end