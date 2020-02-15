function SWEP:RestoreStats()
	ps = self.PrevStats
		
	if ps then
		if ps.damdec then
			self.DamageDecayMod = ps.damdec
			self:CalculateDamageDecay()
		end
			
		if ps.velsens then
			self.VelocitySensivity = ps.velsens
		end

		if ps.shot then
			self.Primary.NumShots = ps.shot
			
			umsg.Start("NBUL", self.Owner)
				umsg.Short(ps.shot)
			umsg.End()
		end
		
		if ps.clumpspread then
			self.ClumpSpread = ps.clumpspread
		end
		
		self.PrevStats = nil
	end
end