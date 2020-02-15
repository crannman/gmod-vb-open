local vehSpawnPoints = {
    ["Garage"] = {
      { Vector(-5090, -10125, 71), Angle(0,90, 0) },
      { Vector(-4917, -10125, 71), Angle(0,90, 0) },
      { Vector(-4744, -10125, 71), Angle(0,90, 0) },
      { Vector(-4571, -10125, 71), Angle(0,90, 0) },
      { Vector(-4398, -10125, 71), Angle(0,90, 0) },
      { Vector(-4225, -10125, 71), Angle(0,90, 0) },
      { Vector(-4052, -10125, 71), Angle(0,90, 0) },
      { Vector(-3879, -10125, 71), Angle(0,90, 0) },
    },
    ["CarDealer"] = {
        { Vector(4376, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(4541, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(4706, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(4871, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(5046, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(5211, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(5376, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(5541, -5864, 56), Angle(0, 69.5, 0) },
        { Vector(5706, -5864, 56), Angle(0, 69.5, 0) },
    }
}
local vehStoreLocations = {
    [1] = {
        Vector(-5392, -9982, 70),
        Vector(-3646, -10724, 200)
    }
}

local jails = {
  { Door = 2526, Max = Vector(-7584, -9975, -304), Min = Vector(-7695, -9856, -435) },
  { Door = 2553, Max = Vector(-7376, -9856, -304), Min = Vector(-7265, -9975, -435) },
  { Door = 2530, Max = Vector(-7584, -10103, -304), Min = Vector(-7695, -9984, -435) },
  { Door = 2551, Max = Vector(-7376, -9984, -304), Min = Vector(-7265, -10103, -435) },
  { Door = 2533, Max = Vector(-7584, -10231, -304), Min = Vector(-7695, -10112, -435) },
  { Door = 2549, Max = Vector(-7376, -10112, -304), Min = Vector(-7265, -10231, -435) },
  { Door = 2536, Max = Vector(-7584, -10359, -304), Min = Vector(-7695, -10240, -435) },
  { Door = 2547, Max = Vector(-7376, -10240, -304), Min = Vector(-7265, -10359, -435) },
}

hook.Add("PostDrawTranslucentRenderables", "ViewAABoxes", function() 

  if GetConVar("vbrp_draw_aaboxes"):GetInt() == 1 then
    for k, v in ipairs(jails) do
      local center = (v.Max + v.Min) / 2
      local max = WorldToLocal(v.Max, Angle(0, 0, 0), center, Angle(0, 0, 0))
      local min = WorldToLocal(v.Min, Angle(0, 0, 0), center, Angle(0, 0, 0))
      cam.Start3D()
      render.DrawWireframeBox(center, Angle(0, 0, 0), min, max, Color(k * 30, 255, k * 30, 255))
      cam.End3D()      
    end
  end
end)
CreateClientConVar("vbrp_draw_aaboxes", "0", false, false)

hook.Add("PostDrawTranslucentRenderables", "Draw3dboxes", function()

  if GetConVar("vbrp_draw_boxes"):GetInt() == 1 then
    for k, v in ipairs(vehSpawnPoints["CarDealer"]) do
      cam.Start3D()
      --render.SetColorMaterial()
      render.DrawWireframeBox(v[1], v[2], Vector(-128,-64, 0), Vector(128, 64, 128), Color(255, 255, 0, 255))
      cam.End3D()
    end
    for k, v in ipairs(vehSpawnPoints["Garage"]) do
      cam.Start3D()
      --render.SetColorMaterial()
      render.DrawWireframeBox(v[1], v[2], Vector(-128,-64, 0), Vector(128, 64, 128), Color(255, 0, 255, 255))
      cam.End3D()
    end

    for _, ent in pairs(ents.GetAll()) do
      if ent:GetClass() == "prop_vehicle_jeep" or ent:GetClass() == "prop_vehicle_airboat" then 
        if ent:GetHitBoxGroupCount() == nil then continue end
        for group=0, ent:GetHitBoxGroupCount() - 1 do
          for hitbox=0, ent:GetHitBoxCount(group) - 1 do
            local pos, ang =  ent:GetBonePosition(ent:GetHitBoxBone(hitbox, group))
            local mins, maxs = ent:GetHitBoxBounds(hitbox, group)
            render.DrawWireframeBox( pos, ang, mins, maxs, Color(51, 204, 255, 255), true )
          end
        end
        render.DrawWireframeBox( ent:GetPos(), Angle(0,0,0), ent:OBBMins(), ent:OBBMaxs(), Color(255, 204, 51, 255), true )
      end
    end

  end

end)

CreateClientConVar("vbrp_draw_boxes", "0", false, false)


hook.Add("PostDrawTranslucentRenderables", "Draw3dHitboxes", function() 
  if GetConVar("vbrp_draw_hitboxes"):GetInt() == 1 then
    for _, ent in pairs(ents.GetAll()) do
      if ent == LocalPlayer() or ent:IsWeapon() then continue end
      if ent:GetHitBoxGroupCount() == nil then continue end
      for group=0, ent:GetHitBoxGroupCount() - 1 do
        for hitbox=0, ent:GetHitBoxCount(group) - 1 do
          local pos, ang =  ent:GetBonePosition(ent:GetHitBoxBone(hitbox, group))
          local mins, maxs = ent:GetHitBoxBounds(hitbox, group)
          render.DrawWireframeBox( pos, ang, mins, maxs, Color(51, 204, 255, 255), true )
        end
      end
      render.DrawWireframeBox( ent:GetPos(), Angle(0,0,0), ent:OBBMins(), ent:OBBMaxs(), Color(255, 204, 51, 255), true )
    end
  end
end)

CreateClientConVar("vbrp_draw_hitboxes", "0", false, false)