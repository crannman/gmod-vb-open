function SWEP:NWAlpha(alpha)
	umsg.Start("NWAlpha")
		umsg.Entity(self)
		umsg.Short(alpha)
	umsg.End()
end
	
local can, att, wep, CT, dtint3, t, num
	
function RequestPimp(ply)
	wep = ply:GetActiveWeapon()
	
	if not wep.IsCSTMWeapon then
		return
	end
		
	if wep.ReloadTime then
		return
	end
		
	CT = CurTime()
	
	if CT < wep.ReloadDelay then
		return
	end
		
	if IsValid(wep) then
		dtint3 = wep:GetDTInt(3)
		
		if dtint3 == 0 then
			wep:SetDTInt(3, 19)
		elseif dtint3 == 19 then
			wep:SetDTInt(3, 0)
		end
		
		wep.ReloadDelay = CT + 0.1
		wep:SetNextPrimaryFire(CT + 0.2)
		wep:SetNextSecondaryFire(CT + 0.2)
	end
end
	
concommand.Add("cstm_requestpimp", RequestPimp)
	
function PimpMyGun(ply, com, args)
	att = args[1]
	
	if not att then
		return
	end
		
	att = tonumber(att)
	wep = ply:GetActiveWeapon()
		
	if not IsValid(wep) then
		return
	end
		
	CT = CurTime()
		
	if CT < wep.ReloadDelay then
		return
	end
		
	wep:NWATT2(att, CWAttachments[CWAttachmentsMeta[att]].scope)
end
	
concommand.Add("cstm_pimpmygun", PimpMyGun)
	
function UnPimpMyGun(ply, com, args)
	att = args[1]
	
	if not att then
		return
	end
	
	att = tonumber(att)
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then
		return
	end
	
	CT = CurTime()
	
	if CT < wep.ReloadDelay then
		return
	end
	
	wep:Deselect(att, CWAttachments[CWAttachmentsMeta[att]].scope)
end

concommand.Add("cstm_unpimpmygun", UnPimpMyGun)

function ChangeInternalPart(ply, com, args)
	att = args[1]
	
	if not att then
		return
	end
	
	att = tonumber(att)
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then
		return
	end
	
	CT = CurTime()
	
	if CT < wep.ReloadDelay then
		return
	end
	
	wep:ChangeInternalPart(att)
end

concommand.Add("cstm_addswag", ChangeInternalPart)

function RemoveInternalPart(ply, com, args)
	att = args[1]
	
	if not att then
		return
	end
	
	att = tonumber(att)
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then
		return
	end
	
	CT = CurTime()
	
	if CT < wep.ReloadDelay then
		return
	end
	
	wep:RemoveInternalPart(att)
end

concommand.Add("cstm_removeswag", RemoveInternalPart)

function SWEP:IsLastAtt(num, b)
	for k, v in pairs(self.Attachments) do
		for k2, v2 in pairs(v) do
			if CWAttachments[v2] then
				if CWAttachments[v2].num == number then
					if b then
						return v
					end
					
					return true
				end
			end
		end
	end
end

function SWEP:SendWeaponStats()
	umsg.Start("CSTM_WEPSTATS", self.Owner)
		umsg.Float(self.DefRecoil)
		umsg.Float(self.Primary.Damage)
		umsg.Float((self.ClumpSpread and self.ClumpSpread or 0))
		umsg.Float(self.HipCone)
		umsg.Float(self.IronsightsCone)
		umsg.Float(self.Primary.Delay)
		umsg.Float(self.ConeInaccuracyAff1)
	umsg.End()
end

function SWEP:ChangeInternalPart(number)
	if not IsValid(self) then
		return
	end
	
	if self:GetDTInt(3) != 19 then
		return
	end
	
	for k, v in pairs(CWInternalParts) do
		if v.num == number then
			if not table.HasValue(self.Owner.InternalParts, k) then
				return
			end
		end
	end
	
	CT = CurTime()
	
	if CT < self.ReloadDelay then
		return
	end
	
	t = CWInternalPartsMeta[number]
	
	if t then
		for k, v in pairs(self.InternalParts) do
			for k2, v2 in pairs(v) do
				if type(v2) != "function" and t == v2.key then
					if v.lastdeattfunc then
						v.lastdeattfunc(self)
					end
					
					v.lastdeattfunc = CWInternalParts[t].svdeattfunc
					break
				end
			end
		end
		
		t = CWInternalParts[t]
			
		if t.svattfunc then
			t.svattfunc(self)
		end
		
		self.ReloadDelay = CT + 0.15
		
		self:CalculateWeaponStats()
		self:SendWeaponStats()
		
		umsg.Start("INTERNALPART", self.Owner)
			umsg.Short(number)
		umsg.End()
	end
end

function SWEP:RemoveInternalPart(number)
	if not IsValid(self) then
		return
	end
	
	if self:GetDTInt(3) != 19 then
		return
	end
	
	for k, v in pairs(CWInternalParts) do
		if v.num == number then
			if not table.HasValue(self.Owner.InternalParts, k) then
				return
			end
		end
	end
	
	CT = CurTime()
	
	if CT < self.ReloadDelay then
		return
	end
	
	t = CWInternalPartsMeta[number]
	
	if t then
		t = CWInternalParts[t]
			if t.svdeattfunc then
			t.svdeattfunc(self)
		end
		
		self.ReloadDelay = CT + 0.15
		
		self:CalculateWeaponStats()
		self:SendWeaponStats()
		
		umsg.Start("INTERNALPARTREM", self.Owner)
			umsg.Short(number)
		umsg.End()
	end
end

function SWEP:NWATT2(number, scope)
	if not IsValid(self) then
		return
	end
	
	if self:GetDTInt(3) != 19 then
		return
	end
	
	for k, v in pairs(CWAttachments) do
		if v.num == number then
			if not table.HasValue(self.Owner.Attachments, k) then
				return
			end
		end
	end
	
	CT = CurTime()
	
	if CT < self.ReloadDelay then
		return
	end
	
	t = CWAttachmentsMeta[number]
	can = false
	
	if t then
		for k, v in pairs(self.Attachments) do
			if #v > 1 then
				for k2, v2 in pairs(v) do
					if t == v2 then
						if v.lastdeattfunc then
							v.lastdeattfunc(self)
						end
						
						v.lastdeattfunc = CWAttachments[t].svdeattfunc
						break
					end
				end
			end
		end
		
		t = CWAttachments[t]
		can = true
		
		if scope then 
			self.ScopeStatus = number
			self.FOVMod = t.scope.fovmod
			
			if self.NoSightBG then
				self.Owner:GetViewModel():SetBodygroup((self.MainBG and self.MainBG or 1), self.NoSightBG)
				self.BodyGroup = self.NoSightBG
			end
		end
			
		if t.svattfunc then
			t.svattfunc(self)
		end
		
		if can then
			for k, v in pairs(self.Attachments) do
				for k2, v2 in pairs(v) do
					if CWAttachments[v2] then
						if CWAttachments[v2].num == number then
							v.last = number
							break
						end
					end
				end
			end
			
			self.ReloadDelay = CT + 0.15
			self.LastAttachment = number
			
			self:CalculateWeaponStats()
			self:SendWeaponStats()
			
			umsg.Start("NWATT2")
				umsg.Entity(self)
				umsg.Short(number)
			umsg.End()
		end
	end
end

function SWEP:Deselect(num, scope)
	if not IsValid(self) then
		return
	end
	
	if self:GetDTInt(3) != 19 then
		return
	end
	
	for k, v in pairs(CWAttachments) do
		if v.num == num then
			if not table.HasValue(self.Owner.Attachments, k) then
				return
			end
		end
	end
	
	CT = CurTime()
	
	if CT < self.ReloadDelay then
		return
	end
	
	if scope then
		if self.ScopeStatus == num then
			self.ScopeStatus = 0
			
			if self.SightBG then
				self.Owner:GetViewModel():SetBodygroup((self.MainBG and self.MainBG or 1), self.SightBG)
				self.BodyGroup = self.SightBG
			end
		
			can = true
		end
	end
	
	if CWAttachmentsMeta[num] then
		can = true
		
		if CWAttachments[CWAttachmentsMeta[num]].svdeattfunc then
			CWAttachments[CWAttachmentsMeta[num]].svdeattfunc(self)
		end
	end
		if can then
		self.ReloadDelay = CT + 0.15
		
		self:CalculateWeaponStats()
		self:SendWeaponStats()
		
		umsg.Start("NWRATT")
			umsg.Entity(self)
			umsg.Short(num)
		umsg.End()
	end
end

function CSTM_SelectAmmoType(ply, com, args)
	if not ply:Alive() then
		return
	end
		
	wep = ply:GetActiveWeapon()
		
	if not IsValid(wep) then
		return
	end
	
	if not wep.IsCSTMWeapon then
		return
	end
	
	CT = CurTime()
	
	if CT < wep.ReloadDelay then
		return
	end
	
	num = tonumber(args[1])
	
	if not num then
		return
	end
	
	t = nil
	s = nil
	
	for k, v in pairs(AmmoTypes) do
		if v.num == num then
			if wep.LastAmmo != v.name then
				if table.HasValue(ply.AmmoTypes, k) then
					t = v
					s = k
					break
				end
			end
		end
	end
	
	if t then
		wep.ReloadDelay = CT + 0.15
		wep:RestoreStats()
		wep:SetDTInt(2, t.num)
		wep.LastAmmo = t.name
		wep.PenMod = t.penmod
		
		clip = wep:Clip1()
		ammo = ply:GetAmmoCount(wep.Primary.Ammo)
		
		wep:SetClip1(0)
		ply:SetAmmo(ammo + clip, wep:GetPrimaryAmmoType())
		
		if wep.AmmoDeselectFunc then
			wep.AmmoDeselectFunc(ply, wep)
		end
		
		wep.AmmoDeselectFunc = t.deselfunc
		
		if t.selfunc then
			t.selfunc(ply, wep)
		end
		
		wep:CalculateWeaponStats()
		wep:SendWeaponStats()
		
		umsg.Start("NWAMMO", ply)
			umsg.String(s)
		umsg.End()
	end
end

concommand.Add("cstm_selectammo", CSTM_SelectAmmoType)

function CSTM_DeselectAmmo(ply)
	if not ply:Alive() then
		return
	end
	
	wep = ply:GetActiveWeapon()
	
	if not IsValid(wep) then
		return
	end
	
	if not wep.IsCSTMWeapon then
		return
	end
	
	CT = CurTime()
	
	if CT < wep.ReloadDelay then
		return
	end
	
	if wep.LastAmmo != "Normal" then
		wep.ReloadDelay = CT + 0.15
		wep:SetDTInt(2, 0)
		wep:RestoreStats()
		wep.LastAmmo = "Normal"
		
		SendUserMessage("DESELECTAMMO", ply)
		
		clip = wep:Clip1()
		ammo = ply:GetAmmoCount(wep.Primary.Ammo)
				
		wep:SetClip1(0)
		ply:SetAmmo(ammo + clip, wep:GetPrimaryAmmoType())
		
		if t.deselfunc then
			t.deselfunc(ply, wep)
		end
		
		wep:CalculateWeaponStats()
		wep:SendWeaponStats()
	end
end

concommand.Add("cstm_deselectammo", CSTM_DeselectAmmo)