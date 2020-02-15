local clr = Color
function HexToColorRGB(hex)

  local baseHex = {
    ["0"] = 0,
    ["1"] = 1,
    ["2"] = 2,
    ["3"] = 3,
    ["4"] = 4,
    ["5"] = 5,
    ["6"] = 6,
    ["7"] = 7,
    ["8"] = 8,
    ["9"] = 9,
    ["A"] = 10,
    ["B"] = 11,
    ["C"] = 12,
    ["D"] = 13,
    ["E"] = 14,
    ["F"] = 15
  }
  local tbl = hex:upper():ToTable()
  return clr(
    (baseHex[ tbl[1] ] * 16) + (baseHex[ tbl[2] ]), 
    (baseHex[ tbl[3] ] * 16) + (baseHex[ tbl[4] ]),
    (baseHex[ tbl[5] ] * 16) + (baseHex[ tbl[6] ])
  )
end

local fmt = string.format

function ColorRGBToHex(color)

  return fmt("%.2X%.2X%.2X", color.r, color.g,color.b)
end

function removedecimals(num)

  return fmt("%d", num)
end

local either = Either
local findInSphere = ents.FindInSphere
local pairs = pairs
local abs = math.abs
local traceLine = util.TraceLine

function CalcSuitablePositions(ent, reverse)

  local traceData = { }
  local centerVec = ent:OBBCenter()
  local maxVec = ent:OBBMaxs()
  local minVec = ent:OBBMins()
  traceData.endpos = ent:LocalToWorld(centerVec)
  traceData.filter = findInSphere(traceData.endpos, 20)
  for key, value in pairs(traceData.filter) do
    if (value == ent) then
        traceData.filter[key] = nil
    end
  end
  local height = 0
  local width = 0
  local sizeVec = minVec - maxVec
  sizeVec.x = abs(sizeVec.x)
  sizeVec.y = abs(sizeVec.y)
  sizeVec.z = abs(sizeVec.z)
  if sizeVec.z < sizeVec.x and sizeVec.z < sizeVec.y then
    height = sizeVec.z
    width = sizeVec.y
    traceData.start = either(rev, traceData.endpos - ent:GetUp() * height, traceData.endpos + ent:GetUp() * height)
  elseif sizeVec.x < sizeVec.y then
    height = sizeVec.x
    width = sizeVec.y
    traceData.start = either(rev, traceData.endpos - ent:GetForward() * height, traceData.endpos + ent:GetForward() * height)
  elseif sizeVec.y < sizeVec.x then
    height = sizeVec.y
    width = sizeVec.x
    traceData.start = either(rev, traceData.endpos - ent:GetRight() * height, traceData.endpos + ent:GetRight() * height)
  end
  local traceResult = traceLine(traceData)
  local dirAng = traceResult.HitNormal:Angle()
  if (traceResult.HitWorld and not reverse) then return CalcSuitablePositions(ent, true) end
  dirAng:RotateAroundAxis(dirAng:Forward(), 90)
  dirAng:RotateAroundAxis(dirAng:Right(), 90)
  local position = traceResult.HitPos - ((traceData.endpos - traceResult.HitPos):Length() * 2 + 2) * traceResult.HitNormal
  local dirAngBack = traceResult.HitNormal:Angle()
  local backVec = traceResult.HitPos + traceResult.HitNormal * 2
  dirAngBack:RotateAroundAxis(dirAngBack:Forward(), 90)
  dirAngBack:RotateAroundAxis(dirAngBack:Right(), -90)
  return {
    PositionBack = backVec,
    AnglesBack = dirAngBack,
    Position = position,
    HitWorld = traceResult.HitWorld,
    Angles = dirAng,
    Width = abs(width)
  }
end

function LerpColor(t, from, to)
  return clr(
    Lerp(t, from.r, to.r),
    Lerp(t, from.g, to.g),
    Lerp(t, from.b, to.b)
  )
end