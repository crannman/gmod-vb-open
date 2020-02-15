--[[
  Origin: V_o
  Maxs: Vector(128, 64, 128)
  Min: Vector(-128,-64, 0)
  local v1 = LocalToWorld(Vector(-128,-64, 0), Angle(0,90, 0), Vector(-5090, -10125, 71), Angle(0,90, 0))
  local v2 = LocalToWorld(Vector(128, 64, 128), a_o, Vector(-5090, -10125, 71), a_o)
  ents.FindInBox(, Vector(-5090, -10125, 71))
]]

function GetWorldBoxCornerVectors(origin, min, max, ang)
  local vMin = LocalToWorld(min, ang, origin, ang)
  local vMax = LocalToWorld(max, ang, origin, ang)
  return vMin, vMax
end

VehSpawnPoints = {
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
VehStoreLocations = {
  { Min = Vector(-5411.613770, -10732.968750, 71.251137), Max = Vector(-3636.226318, -9965.031250, 262.959869) }
}
VehCustomizingLocation = {
  Min = Vector(3962.031250, -4752.637695, 64.047592), Max = Vector(4593.968750, -3361.103271, 319.915588)
}