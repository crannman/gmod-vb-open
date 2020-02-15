local VBRP_Vector = FindMetaTable("Vector")


-- @desc Arrondi au plus bas les composantes du vecteur;
-- @realm Shared;
-- @return vector Vector;
function VBRP_Vector:Floor()
  local x, y, z
  x = math.floor(self.x)
  y = math.floor(self.y)
  z = math.floor(self.z) + 64 --adding player height

  return Vector(x, y, z)
end

-- @desc Converti les composantes d'un vecteur arrondies en string sous la forme "x, y, z";
-- @realm Shared;
-- @return string "x, y, z";
function VBRP_Vector:VecToString()
  local x, y, z
  x = removedecimals(math.floor(self.x))
  y = removedecimals(math.floor(self.y))
  z = removedecimals(math.floor(self.z) + 64) --adding player height

  return x .. ", " .. y .. ", " .. z
end

-- @desc Retourne le vecteur le plus proche;
-- @realm Shared;
-- @args table Vector;
-- @return vector Vector;
function VBRP_Vector:GetNearestVector(vectors)

  local max = 900000
  local ret
  for _, v in pairs(vectors) do
    local Distance = self:DistToSqr(v)
    if Distance < max then
      ret = v
      max = Distance
    end
  end

  return ret

end