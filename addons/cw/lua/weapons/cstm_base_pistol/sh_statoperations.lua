function SWEP:CalculateEffectiveRange()
	self.EffectiveRange = self.CaseLength * 10 - self.BulletLength * 5 -- setup realistic base effective range
	self.EffectiveRange = self.EffectiveRange / 2 -- halven it, because the maps aren't big enough and we want to balance shit out
	self.EffectiveRange = self.EffectiveRange * 39.37 -- convert meters to units
	self.DamageDecay = self.BulletLength / self.CaseLength * self.DamageDecayMod -- setup the damage decay over distance in percentage
	self.PenStr = (self.BulletLength * 0.5 + self.CaseLength * 0.35) * (self.PenAdd and self.PenAdd or 1)
end

function SWEP:CalculateDamageDecay()
	self.DamageDecay = self.BulletLength / self.CaseLength * self.DamageDecayMod -- setup the damage decay over distance in percentage
end

local t

function SWEP:CalculateWeaponStats()
	t = self.Primary.Damage_Orig
	
	for k, v in pairs(self.DamageMods) do
		t = t * v
	end
	
	self.Primary.Damage = t
	t = self.Primary.Recoil

	for k, v in pairs(self.RecoilMods) do
		t = t * v
	end
	
	self.DefRecoil = t
	t = self.HipCone_Orig
	
	for k, v in pairs(self.HipConeMods) do
		t = t * v
	end
	
	self.HipCone = t
	t = self.IronsightsCone_Orig
	
	for k, v in pairs(self.AimConeMods) do
		t = t * v
	end
	
	self.IronsightsCone = t
	t = self.Primary.Delay_Orig
	
	for k, v in pairs(self.FirerateMods) do
		t = t * v
	end
	
	self.Primary.Delay = t
	t = {count = table.Count(self.OtherMods), cur = 0, mods = {}}
	
	for i = 1, t.count do -- run an individual loop for every value that we're going to modify
		for k, v in pairs(self.OtherMods) do
			if v.mod then
				if not t.last then
					t.last = v.mod
					t.stop = true
					t.value = self[t.last .. "_Orig"]
				else
					if v.mod != t.last then
						if not t.stop then
							t.last = v.mod
							t.stop = true -- make sure we're not going to modify a different value after we've chosen what we need
							t.value = self[t.last .. "_Orig"]
						end
					end
				end

				if t.last == v.mod and not t.mods[k] then
					t.value = t.value * v.value
					t.mods[k] = true
				end
			end
		end
		
		self[t.last] = t.value
		t.stop = false
	end
end
