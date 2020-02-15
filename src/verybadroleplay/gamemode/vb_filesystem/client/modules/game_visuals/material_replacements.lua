local matReplacementDictionary = {
  ["ajacks/ajacks_road2.vtf"]                  = "verybadroleplay/map/road/road01.vtf",
  ["ajacks/ajacks_road4.vtf"]                  = "verybadroleplay/map/road/road02.vtf",
  ["ajacks/ajacks_road5.vtf"]                  = "verybadroleplay/map/road/road03.vtf",
  ["ajacks/ajacks_road7.vtf"]                  = "verybadroleplay/map/road/road04.vtf",
  ["ajacks/ajacks_road8.vtf"]                  = "verybadroleplay/map/road/road05.vtf",
  ["ajacks/ajacks_10.vtf"]                     = "verybadroleplay/map/road/road06.vtf",
  ["sgtsicktextures/gunroad_01.vtf"]           = "verybadroleplay/map/road/road07.vtf",
  ["sgtsicktextures/gunroad_02.vtf"]           = "verybadroleplay/map/road/road08.vtf",
  ["sgtsicktextures/gunroad_03.vtf"]           = "verybadroleplay/map/road/road09.vtf",
  ["sgtsicktextures/gunroad_04.vtf"]           = "verybadroleplay/map/road/road10.vtf",
  ["sgtsicktextures/sicknessroad_01.vtf"]      = "verybadroleplay/map/road/road11.vtf",
  ["sgtsicktextures/sicknessroad_02.vtf"]      = "verybadroleplay/map/road/road12.vtf",
--  ["sgtsicktextures/bankoamerica2.vtf"]        = "verybadroleplay/map/billboard/billboard01.vtf",
  ["sgtsicktextures/billboard_03.vtf"]         = "verybadroleplay/map/billboard/billboard02.vtf",
  ["bridge/se1_advert_03.vtf"]                 = "verybadroleplay/map/billboard/billboard03.vtf",
  ["models/sickness/busstopmain_01.vtf"]       = "verybadroleplay/map/misc/bus_stop.vtf",
  ["models/sickness/bksign_01.vtf"]            = "verybadroleplay/map/misc/burger_king.vtf",
}

-- gameevent.Listen("player_spawn")
-- hook.Add("player_spawn", "VBHOOK::ReplaceMaterialsOnConnect", function()
--   if not LocalPlayer().TextureLoaded then
--     for matToReplace, newMat in pairs(matReplacementDictionary) do
--       local mat = Material(matToReplace)
--       mat:SetTexture("$basetexture", newMat)
--     end
--     LocalPlayer().TextureLoaded = true
--   end
-- end)


function UnloadCustomTextures()

    for matToReplace, _ in pairs(matReplacementDictionary) do
      local mat = Material(matToReplace)
      mat:SetTexture("$basetexture", matToReplace)
      if matToReplace == "ajacks/ajacks_10.vtf" then
        mat:SetTexture("$basetexture", "ajacks/ajacks_road10.vtf")
      end
    end
end

function LoadCustomTextures()

    for matToReplace, newMat in pairs(matReplacementDictionary) do
      local mat = Material(matToReplace)
      mat:SetTexture("$basetexture", newMat)
    end
end

concommand.Add("vbrp_load_custom_textures", function(ply, cmd, args, argStr)

  if args[1] == "1" then
    LoadCustomTextures()
  elseif args[1] == "0" then
    UnloadCustomTextures()
  end

end)