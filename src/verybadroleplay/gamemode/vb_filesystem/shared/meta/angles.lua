local VBRP_Angles = FindMetaTable("Angle")

-- @desc Converti les axes (pitch, yaw, roll) d'un angle arrondies en string sous la forme "p, y, r";
-- @realm Shared;
-- @return string "p, y, r";
function VBRP_Angles:AngToString()
  local p, y, r
  p = removedecimals(math.floor(self.p))
  y = removedecimals(math.floor(self.y))
  r = removedecimals(math.floor(self.r))

  return p .. ", " .. y .. ", " .. r
end
