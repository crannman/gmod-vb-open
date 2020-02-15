AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.Identifier = "MARKET_WEEDPOT"
ENT.HasLoam = false
ENT.HasSeed = false
ENT.Timer = nil
ENT.Step = 0
ENT.IntervalBetweenSteps = 0.1

function ENT:StartTouch(other)

  local trace = other:GetTouchTrace()
  if not trace.hitEntity == self.Entity then return end

  if other:GetClass() == "vbrp_weed_pot_dirt" and not self.HasLoam then
    other:Remove()
    self.HasLoam = true
    self:SetModel("models/nater/weedplant_pot_dirt.mdl")
  end

  if other:GetClass() == "vbrp_weed_seed" and not self.HasSeed and self.HasLoam then
    other:Remove()
    self.HasSeed = true
    self.Step = 1
    self:SetModel("models/nater/weedplant_pot_growing" .. self.Step .. ".mdl")
    self.Timer = CurTime() + self.IntervalBetweenSteps
  end

end

function ENT:Think()
  if self.Step >= 1 and self.Step < 7 then
    if CurTime() > self.Timer then
      self.Step = self.Step + 1
      self:SetModel("models/nater/weedplant_pot_growing" .. self.Step .. ".mdl")
      self.Timer = CurTime() + self.IntervalBetweenSteps
    end
  end

end

local function getWeightedRandom(tab)

  local sum = 0

	for _, chance in pairs(tab) do
		sum = sum + chance
	end

	local select = math.random() * sum

	for key, chance in pairs(tab) do
		select = select - chance
		if select < 0 then return key end
	end

end

function ENT:Use(activator, caller)
  if caller:IsArrested() then return false end
  local luck = {
    [1] = 0.5,
    [2] = 1.5,
    [3] = 3,
    [4] = 4,
    [5] = 5,
    [6] = 4,
    [7] = 3,
    [8] = 2,
    [9] = 1.5,
    [10] = 1.5,
  }
  local luckWeed = {
    [0] = 1.5,
    [1] = 4,
    [2] = 1.5,
    [3] = 0.5
  }
  local drawingLots = {}

  -- Une chance sur 5 de ne pas récupérer le loam

  if self.Step == 0 and self.HasLoam then
    local loamBack = 4
    local m = math.random(1, 5)
    if m < loamBack then
      local e = ents.Create("vbrp_weed_pot_dirt")
      e:SetPos(self:GetPos() + Vector(0, -25, 25))
      e:SetTrigger(true)
      e:SetDTOwner("world")
      e:SetMoveType(MOVETYPE_NONE)
      e:Spawn()
    end
    self.HasLoam = false
    self:SetModel("models/nater/weedplant_pot.mdl")
    return
  end

  if self.Step == 1 then
    local seedBack = 1
    local m = math.random(1, 2)
    if m == seedBack then
      local e = ents.Create("vbrp_weed_seed")
      e:SetPos(self:GetPos() + Vector(0, -25, 25))
      e:SetTrigger(true)
      e:SetDTOwner("world")
      e:SetMoveType(MOVETYPE_NONE)
      e:Spawn()
    end
    self.HasSeed = false
    self.Timer = nil
    self.Step = 0
    self:SetModel("models/nater/weedplant_pot_dirt.mdl")
    return
  end

  if self.Step >= 2 then

    for i = 1, self.Step do
      drawingLots[i] = getWeightedRandom(luck)
    end
    local maxInteger = math.max(unpack(drawingLots)) 
    local minInteger = math.min(unpack(drawingLots))
    local numWeedToSpawn = 0
    local random = math.random(1, 10)
    if (random > self.Step) then
      numWeedToSpawn = minInteger
    else
      numWeedToSpawn = maxInteger
    end

    if self.Step <= 4 and numWeedToSpawn > 4 then 
      numWeedToSpawn = 4
    end

    if self.Step == 7 and numWeedToSpawn < 4 then
      numWeedToSpawn = 4
    end

    local numSeedToSpawn = getWeightedRandom(luckWeed)

    for i = 1, numSeedToSpawn do
      local e = ents.Create("vbrp_weed_seed")
      e:SetPos(self:GetPos() + Vector(0, i * 1.2, 15))
      e:SetTrigger(true)
      e:SetDTOwner("world")
      local phys = self:GetPhysicsObject()
      if IsValid(phys) then
        phys:Sleep()
      end
      e:Spawn()
    end

    for i = 1, numWeedToSpawn do
      local e = ents.Create("vbrp_weed")
      e:SetPos(self:GetPos() + Vector(0, i * 1.2, 15))
      e:SetTrigger(true)
      e:SetDTOwner("world")
      local phys = self:GetPhysicsObject()
      if IsValid(phys) then
        phys:Sleep()
      end
      e:Spawn()
    end
    self.HasSeed = false
    self.Timer = nil
    self.Step = 0
    self:SetModel("models/nater/weedplant_pot_dirt.mdl")
    return
  end

  if self.Step == 0 and not self.HasLoam and not self.HasSeed then
    self:Remove()
    caller:UpdateInventory(self.Identifier, "add", 1)
  end

end

