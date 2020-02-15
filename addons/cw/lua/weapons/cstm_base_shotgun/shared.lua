if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 75
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
end

SWEP.Author			= "LEETNOOB"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "PRIMARY ATTACK key to fire\nSECONDARY ATTACK key to toggle ironsights\nUSE key + SECONDARY ATTACK key - attach suppressor\nUSE key + RELOAD key - switch between semi-auto/auto firemodes (SMGs/ARs)\nCONTEXT MENU KEY - open attachment selection menu\nWHILE IN MENU - press numbers in brackets on the keyboard to select attachments"

// Note: This is how it should have worked. The base weapon would set the category
// then all of the children would have inherited that.
// But a lot of SWEPS have based themselves on this base (probably not on purpose)
// So the category name is now defined in all of the child SWEPS.
//SWEP.Category			= "Counter-Strike"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.Primary.Sound			= Sound( "Weapon_AK47.Single" )
SWEP.Primary.Recoil			= 1.5
SWEP.Primary.Damage			= 40
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.Delay			= 0.15

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.Base					= "cstm_base_pistol"

local CT, vm, sequence, AvailableReload, wep, DTInt3, ent, AimVec, EyeAng, Offset, RecMod, bullet, vel, tr, ef
local destr, tsim, tcret, app, clamp, sin, cos, rand, rand2 = timer.Destroy, timer.Simple, timer.Create, math.Approach, math.Clamp, math.sin, math.cos, math.random, math.Rand

function SWEP:Deploy()
	CT = CurTime()
	
	if not self.Owner.FuseTime then
		self.Owner.FuseTime = 3
	end

	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CT + 1)
	self:SetNextSecondaryFire(CT + 1)
	self.ReloadDelay = CT + 1
	self.MeleeDelay = CT + 1
	
	if SERVER then
		if self.BodyGroup then
			self.Owner:GetViewModel():SetBodygroup((self.MainBG and self.MainBG or 1), self.BodyGroup)
		end
		
		SendUserMessage("DOVMSTUFF", self.Owner)
	end
	
	self:SetDTInt(3, 0)
	self.HolsterStatus = 0
	
	return true
end
	
function SWEP:Reload()
	CT = CurTime()
	
	if CT < self.ReloadDelay then
		return
	end
	
	if self:GetDTInt(3) == 19 then
		return
	end
	
	if self.ReloadTime then
		self.ReloadTime = nil
		self:FinishCustomReload(self.ShouldBolt)
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		if SERVER then
			self:CycleFiremodes()
		end
		
		self.ReloadDelay = CT + 0.25
		return
	end
	
	if self.Safe then
		return
	end
	
	if self.Owner:WaterLevel() >= 3 then
		return
	end
	
	if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		if self:Clip1() < self.Primary.ClipSize then
			if CT > self.ReloadDelay then
				self.StopAnim = 0
				self.ReloadDelay = CT + 1
				self:StartCustomReload()
				self:SetDTInt(3, 0)
				
				if SERVER then
					if self.Owner:GetFOV() != 0 then
						self.Owner:SetFOV(0, 0.3)
					end
				end
			end
		end
	end
end

function SWEP:StartCustomReload()
	vm = self.Owner:GetViewModel()
	self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
	vm:SetPlaybackRate(self.ReloadSpeed)
	
	if self:Clip1() == 0 then
		self.ShouldBolt = true
	end
	
	CT = CurTime()
	
	AvailableReload = clamp(self.Owner:GetAmmoCount(self.Primary.Ammo), 0, 1)
	self.ReloadTime = CT + vm:SequenceDuration() / self.ReloadSpeed
	self:SetNextPrimaryFire(CT + 1)
end

function SWEP:FinishCustomReload(bolt)
	vm = self.Owner:GetViewModel()
	CT = CurTime()

	self.ReloadTime = nil
	
	if bolt == false or self.NoBoltAnim == true then
		self.ShouldBolt = false
		
		if IsFirstTimePredicted() then
			self:SendWeaponAnim(ACT_VM_IDLE)
			vm:SetPlaybackRate((self.IdleAnimSpeed and self.IdleAnimSpeed or 1))
		end
		
		self:SetNextPrimaryFire(CT + 0.3)
		self:SetNextSecondaryFire(CT + 0.3)
		self.MeleeDelay = CT + 0.3
		self.ReloadDelay = CT + 0.3
	else
		self:BoltWeaponry()
	end
end

function SWEP:BoltWeaponry()
	vm = self.Owner:GetViewModel()
	CT = CurTime()

	if IsFirstTimePredicted() then
		self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
		vm:SetPlaybackRate(self.ReloadSpeed)
	end
	
	tsim((vm:SequenceDuration() - 0.2) / self.ReloadSpeed, function()
		self.ShouldBolt = false
	end)
	
	self:SetNextPrimaryFire(CT + 0.8)
	self:SetNextSecondaryFire(CT + 0.8)
	self.ReloadDelay = CT + 0.8
end

local ong, force, wl

function SWEP:Think()	
	CT = CurTime()
	ong = self.Owner:OnGround()
	
	if self.ReloadTime then
		clip = self:Clip1()
		
		if CT > self.ReloadTime then
			if clip < self.Primary.ClipSize then
				if game.SinglePlayer() then
					if self.StopAnim == 0 then
						if IsFirstTimePredicted() then
							self:SendWeaponAnim(ACT_VM_RELOAD)
							self.Owner:GetViewModel():SetPlaybackRate(self.ReloadSpeed)
						end
						
						self.StopAnim = 1
					end
				else
					if SERVER then
						if self.StopAnim == 0 then
							self:SendWeaponAnim(ACT_VM_IDLE)
							self.StopAnim = 1
						end
						
						if CT > self.ReloadTime + 0.02 then
							if self.StopAnim == 1 then
								self:SendWeaponAnim(ACT_VM_RELOAD)
								self.Owner:GetViewModel():SetPlaybackRate(self.ReloadSpeed)
								self.StopAnim = 2
							end
						end
					end
				end
			end
			
			wl = self.Owner:WaterLevel()
			
			if (clip < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0) and wl < 3 then
				if CT > self.ReloadTime + (0.3 / self.ReloadSpeed) then
					self:SetClip1(clip + 1)
					self.Owner:RemoveAmmo(1, self.Primary.Ammo)
					self.ReloadTime = CT + self.IncAmmoPerc / self.ReloadSpeed
					
					self.StopAnim = 0
					//self.ReloadDelay = CT + 1
				end
			else
				if CT > self.ReloadTime then
					self:FinishCustomReload(self.ShouldBolt)
					self.ReloadDelay = CT + 1
				end
			end
		end
	end
	
	dtint3 = self:GetDTInt(3)
	vel = self.Owner:GetVelocity():Length()
	
	if SERVER then
		if self.Cooking then
			if self.CookTime then
				if not self.Owner:KeyDown(IN_ATTACK) then
					if CT < self.CookTime then
						self:ThrowGrenade()
					end
				else
					if CT > self.CookTime then
						self.Cooking = false
						self.CookTime = nil
						util.BlastDamage(self.Owner, self.Owner, self:GetPos(), 384, 100)
						self.Owner:Kill()
						
						ef = EffectData()
						ef:SetOrigin(self.Owner:GetPos())
						ef:SetMagnitude(1)
						
						util.Effect("Explosion", ef)
					end
				end
			end
		end
		
		AimVec = self.Owner:GetAimVector()
		
		if not self.Owner.LastView then
			self.Owner.LastView = AimVec
			self.Owner.ViewAff = 0
		else
			self.Owner.ViewAff = Lerp(0.25, self.Owner.ViewAff, (AimVec - self.Owner.LastView):Length() * 0.15)
			self.Owner.LastView = AimVec
		end
		
		if self.Owner:Crouching() and ong then
			self.ConeAff1 = 0.005
			self.ConeDecAff1 = 0.0025
			self.RecoilAff2 = 0.2
		else
			self.ConeAff1 = 0
			self.ConeDecAff1 = 0
			self.RecoilAff2 = 0
		end
		
		if self.dt.Sil then
			self.RecoilAff3 = 0.15
		else
			self.RecoilAff3 = 0
		end
		
		if dtint3 == 1 then
			self.ConeDecAff2 = 0.0045
			self.RecoilAff1 = 0.3
			self.CurCone = self.IronsightsCone / GetConVarNumber("cstm_accuracymod_aim")
		elseif dtint3 == 17 then
			self.ConeDecAff2 = 0.0045
			self.RecoilAff1 = 0.5
			self.CurCone = self.IronsightsCone / GetConVarNumber("cstm_accuracymod_aim")
		else
			self.ConeDecAff2 = 0
			self.RecoilAff1 = 0
			self.CurCone = self.HipCone / GetConVarNumber("cstm_accuracymod_hip")
		end
		
		if dtint3 == 1 then
			if not self.Owner:KeyDown(IN_ATTACK2) then
				if tonumber(self.Owner:GetInfo("cstm_hold_to_aim")) > 0 then
					self:SetDTInt(3, 0)
					self.Owner:SetFOV(0, 0.3)
					self.Owner:DrawViewModel(true)
				end
			end
		end
		
		self.Primary.Cone = clamp((self.CurCone + self.ConeInaccuracy + ((vel / 10000) * (dtint3 == 1 and self.VelocitySensivity * 0.3 or self.VelocitySensivity)) - self.ConeAff1 + self.Owner.ViewAff), 0.0004, 0.12)
		self:SetDTFloat(0, clamp(self.Primary.Cone, 0.0004, 0.12 * (1 - (self.RecoilAff1 + self.RecoilAff2))  * (dtint3 == 1 and 0.25 or 1)))
		self:SetDTFloat(1, clamp(1 - self.RecoilAff1 - self.RecoilAff2 - self.RecoilAff3, 0.05, 1))
		
		if CT > self.ConeInaccDelay then
			self.ConeInaccuracy = clamp(self.ConeInaccuracy - 0.0015, 0, 0.08 * self.ConeInaccuracyAff1)
		end
	end
	
	if not self.Owner:KeyDown(IN_ATTACK) and self.dt.NumShots != 0 and self.Burst then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 2)
		self.dt.NumShots = 0
	end
	
	wepclass = self:GetClass()
	
	if self.Owner:KeyDown(IN_SPEED) and ong and dtint3 != 6 and dtint3 != 10 and dtint3 != 15 and dtint3 != 17 and dtint3 != 18 then 
		if vel > self.Owner:GetWalkSpeed() then
			if dtint3 != 2 and dtint3 != 15 and dtint3 != 18 then
				if self.SprintAndShoot then
					self:SetDTInt(3, 18)
				else
					self:SetDTInt(3, 2)
				end
				
				if SERVER then
					self.Owner:SetFOV(0, 0.3)
					self.Owner:DrawViewModel(true)
				end
			end
			
		else
			if dtint3 != 1 or dtint3 != 8 and dtint3 != 10 and dtint3 != 11 and dtint3 != 12 and dtint3 != 15 and dtint3 != 17 and dtint3 != 18 then
				self:SetDTInt(3, 0)
				
				if SERVER then
					self.Owner:SetFOV(0, 0.3)
					self.Owner:DrawViewModel(true)
				end
			end
		end
	elseif not self.Owner:KeyDown(IN_SPEED) and dtint3 != 1 and dtint3 != 0 and dtint3 != 6 and dtint3 != 8 and dtint3 != 10 and dtint3 != 11 and dtint3 != 12 and dtint3 != 15 and dtint3 != 17 and dtint3 != 19 or not ong and dtint3 != 6 and dtint3 != 0 and dtint3 != 15 and dtint3 != 17 then
		self:SetDTInt(3, 0)
		
		if SERVER then
			self.Owner:SetFOV(0, 0.2)
			self.Owner:DrawViewModel(true)
		end
	end
	
	dtint3 = self:GetDTInt(3)
	
	if dtint3 == 1 then
		tr = self.Owner:GetEyeTrace()
		
		if tr.HitPos:Distance(self.Owner:GetShootPos()) <= 30 and tr.Entity:GetClass() != "prop_ragdoll" then
			self:SetDTInt(3, 0)
			self.Owner:SetFOV(0, 0.2)
			self:SetNextPrimaryFire(CT + 0.2)
			self:SetNextSecondaryFire(CT + 0.2)
		end
	end
	
	if not self.Owner:KeyDown(IN_RELOAD) then
		if not self.HasReleasedKey then
			self.HasReleasedKey = true
		end
	end
end

local rec, am

function SWEP:PrimaryAttack()
	DTInt3 = self:GetDTInt(3)
	
	if self.Owner:KeyDown(IN_WALK) then
		if self.Owner:WaterLevel() < 3 then
			if DTInt3 == 0 then
				if self.Owner:GetAmmoCount("Grenade") > 0 then
					CT = CurTime()
					
					if CT > self.ReloadDelay then
						self:SetNextPrimaryFire(CT + self.Owner.FuseTime + 1.3)
						self:SetNextSecondaryFire(CT + self.Owner.FuseTime + 1.3)
						self.ReloadDelay = CT + self.Owner.FuseTime + 1.3
						self.HolsterTime = CT + self.Owner.FuseTime + 1.3
						self:EmitSound("weapons/cstm/holster" .. math.random(1, 4) .. ".wav", 65, 100)
						
						if SERVER then
							self:QuickGrenade()
						end
						
						return
					end
				end
			end
		end
	end
	
	if self.FireMode == "safe" then
		if SERVER then
			self:SelectFiremode(self.FireModes[1])
			self.FireModes.last = 1
		end
		
		return
	end
	
	if self.ReloadTime then
		self.ReloadTime = nil
		self:FinishCustomReload(self.ShouldBolt)
		return
	end
	
	tr = self.Owner:GetEyeTrace()
	
	if tr.HitPos:Distance(self.Owner:GetShootPos()) < 30 then
		return
	end
	
	if DTInt3 == 2 or DTInt3 == 19 then
		return
	end

	CT = CurTime()
	
	if self:Clip1() == 0 or self.Owner:WaterLevel() == 3 then
		self:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, rand(99, 101))
		self:SetNextSecondaryFire(CT + 0.05)
		self:SetNextPrimaryFire(CT + 0.25)
		return
	end
	
	if (!self:CanPrimaryAttack()) then 
		return
	end
	
	if not self.dt.Sil then
		self.Owner:EmitSound(self.Primary.Sound, self.UnsilencedVolume, rand(99, 101))
	else
		self.Owner:EmitSound(self.SilencedSound, self.SilencedVolume, rand(99, 101))
	end
	
	if SERVER then
		if not game.SinglePlayer() then
			ef = EffectData()
			ef:SetOrigin(self.Owner:GetShootPos())
			ef:SetEntity(self)
			ef:SetAngles(self.Owner:GetAngles())
			util.Effect("ef_muzzle", ef)
		else
			TWeps_LowAmmo(self, self.Owner)
		end
	end
	
	if CLIENT then
		TWeps_LowAmmo(self, self.Owner)
	end
	
	rec = self:GetDTFloat(1)
	am = self:GetDTInt(2)
	
	RecMod = GetGlobalFloat("CR")
	self:TakePrimaryAmmo( 1 )
	self:SetNextSecondaryFire( CT + self.Primary.Delay )
	self:SetNextPrimaryFire( CT + self.Primary.Delay )
	
	if am == 10 then
		if SERVER then
			ent = ents.Create("round_frag")
			AimVec = self.Owner:GetAimVector()
			EyeAng = self.Owner:EyeAngles()
			Offset = nil
			
			if DTInt3 != 1 then
				Offset = EyeAng:Up() * -5 + EyeAng:Right() * 6
			else
				Offset = EyeAng:Up() * -5
			end
			
			ent:SetPos(self.Owner:GetShootPos() + AimVec * 30 + Offset)
			ent:SetAngles(self.Owner:EyeAngles())
			ent:Spawn()
			ent:SetOwner(self.Owner)
			ent:GetPhysicsObject():SetVelocity(AimVec * 10000)
			ent.Owner = self.Owner
			ent.Damage = self.Primary.NumShots * self.Primary.Damage * 0.75
		end
			
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1) -- some weapons in the pack have slow recoil animation, so I've decided to slightly speed it up
			
		if not self.dt.Sil then
			self.Owner:MuzzleFlash()
		end
			
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		
		if DTInt3 == 1 then
			self:Recoil(self.DefRecoil * 0.75 * RecMod)
		else
			self:Recoil(self.DefRecoil * RecMod)
		end
		
		self.Owner:ViewPunch(Angle(-1 * (self.DefRecoil + self.ConeInaccuracy * 4) * rec, 0, 0 ) * RecMod)
		
		return
	elseif am == 11 then
		if SERVER then
			ent = ents.Create("gren_smoke")
			AimVec = self.Owner:GetAimVector()
			EyeAng = self.Owner:EyeAngles()
			Offset = nil
			
			if DTInt3 != 1 then
				Offset = EyeAng:Up() * -5 + EyeAng:Right() * 6
			else
				Offset = EyeAng:Up() * -5
			end
			
			ent:SetPos(self.Owner:GetShootPos() + AimVec * 30 + Offset)
			ent:SetAngles(self.Owner:EyeAngles())
			ent:Spawn()
			ent:SetOwner(self.Owner)
			ent:GetPhysicsObject():SetVelocity(AimVec * 10000)
			ent.Owner = self.Owner
		end
			
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1) -- some weapons in the pack have a slow recoil animation, so I've decided to slightly speed it up
			 
		if not self.dt.Sil then
			self.Owner:MuzzleFlash()
		end
			
		self.Owner:SetAnimation(PLAYER_ATTACK1)
		
		if DTInt3 == 1 then
			self:Recoil(self.DefRecoil * 0.75 * RecMod)
		else
			self:Recoil(self.DefRecoil * RecMod)
		end
		
		self.Owner:ViewPunch(Angle(-1 * (self.DefRecoil + self.ConeInaccuracy * 4) * rec, 0, 0 ) * RecMod)
		
		return
	end
	
	self.ReloadDelay = CT + 0.5
	
	if DTInt3 != 1 then
		self:CSShootBullet( self.Primary.Damage, self.DefRecoil, self.Primary.NumShots, self:GetDTFloat(0))
	else
		self:CSShootBullet( self.Primary.Damage, self.DefRecoil * 0.75, self.Primary.NumShots, self:GetDTFloat(0))
	end
	
	if DTInt3 == 1 then
		self:Recoil(self.DefRecoil * 0.75 * rec * RecMod)
	else
		self:Recoil(self.DefRecoil * rec * RecMod)
	end
	
	self.ConeInaccuracy = clamp(self.ConeInaccuracy + (0.005 + self.DefRecoil * (0.006 - (self.ConeDecAff1 + self.ConeDecAff2))) * self.InaccAff1, 0, 0.08 * (self.ConeInaccuracyAff1))
	self.ConeInaccDelay = CT + self.Primary.Delay * 1.05
	
	self.Owner:ViewPunch(Angle(-1 * (self.DefRecoil + self.ConeInaccuracy * 4) * rec, 0, 0) * RecMod)
end

local Dir, ent, dot, Dir2
local trace_normal = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442)
local trace_walls = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)
local NoPenetration = {[MAT_SLOSH] = true}
local NoRicochet = {[MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true}
local PenMod = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul, td = {}, {}

function SWEP:CSShootBullet( dmg, recoil, numbul, cone )
	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01
		
	if self.dt.Sil then
		dmg = dmg * 0.9
	end
	
	if self:GetDTInt(2) == 1 then
		dmg = dmg * 0.7
	end
	
	/*if game.SinglePlayer() and GetConVarNumber("cstm_physbul_sp") >= 1 then
		if SERVER then
			for i = 1, self.Primary.NumShots do
				self.Owner:FireBulletsEx(1, self.Owner:GetShootPos(), (self.Owner:EyeAngles() + self.Owner:GetPunchAngle()):Forward(), self.Primary.Damage * (1 - (damagemod1 + damagemod2)), self:GetDTFloat(0), 10, self.PenStr * self.PenMod)
			end
		end
	else*/
		sp = self.Owner:GetShootPos()
		Dir = (self.Owner:EyeAngles() + self.Owner:GetPunchAngle() + Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0) * 25):Forward()
		
		for i = 1, self.Primary.NumShots do
			Dir2 = Dir
			
			if self.ClumpSpread and self.ClumpSpread > 0 then
				Dir2 = Dir + VectorRand() * self.ClumpSpread
			end
			
			bul.Num = 1
			bul.Src = sp
			bul.Dir = Dir2
			bul.Spread 	= Vector(0, 0, 0)
			bul.Tracer	= 4
			bul.Force	= dmg
			bul.Damage = math.Round(dmg)
			bul.Callback = function(attacker, trace, dmginfo)
				if SERVER and self:GetDTInt(2) == 1 then
					ent = trace.Entity
					
					if IsValid(ent) then
						if ent:GetPos():Distance(self.Owner:GetPos()) <= self.EffectiveRange / 2 then
							ent:Ignite(6)
							ParticleEffect("cstm_incendiary_hit", trace.HitPos, trace.HitNormal:Angle(), nil)
						end
					else
						if trace.HitPos:Distance(self.Owner:GetPos()) <= self.EffectiveRange / 2 then
							ParticleEffect("cstm_incendiary_hit", trace.HitPos, trace.HitNormal:Angle(), nil)
						end
					end
				end
			end
			
			self.Owner:FireBullets(bul)
			
			bul.Callback = nil
			
			-- td.start = sp
			-- td.endpos = td.start + Dir2 * 16384
			-- td.filter = self.Owner
			-- td.mask = trace_normal
			
			-- tr = util.TraceLine(td)
			
			-- if not NoPenetration[tr.MatType] then
			-- 	dot = -Dir2:DotProduct(tr.HitNormal)
			-- 	ent = tr.Entity
				
			-- 	if dot > 0.26 and not ent:IsNPC() and not ent:IsPlayer() then
			-- 		td.start = tr.HitPos
			-- 		td.endpos = td.start + Dir2 * self.PenStr * (PenMod[tr.MatType] and PenMod[tr.MatType] or 1) * self.PenMod
			-- 		td.filter = self.Owner
			-- 		td.mask = trace_walls
					
			-- 		tr = util.TraceLine(td)
					
			-- 		td.start = tr.HitPos
			-- 		td.endpos = td.start + Dir * 0.1
			-- 		td.filter = self.Owner
			-- 		td.mask = trace_normal
					
			-- 		tr = util.TraceLine(td) -- run ANOTHER trace to check whether we've penetrated a surface or not
					
			-- 		if not tr.Hit then
			-- 			bul.Num = 1
			-- 			bul.Src = tr.HitPos
			-- 			bul.Dir = Dir2
			-- 			bul.Spread 	= Vec0
			-- 			bul.Tracer	= 4
			-- 			bul.Force	= dmg * 0.5
			-- 			bul.Damage = bul.Damage * 0.5
			-- 			self.Owner:FireBullets(bul)
			-- 		end
			-- 	else
			-- 		if not NoRicochet[tr.MatType] then
			-- 			Dir2 = Dir2 + (tr.HitNormal * dot) * 3
			-- 			Dir2 = Dir2 + VectorRand() * 0.06
			-- 			bul.Num = 1
			-- 			bul.Src = tr.HitPos
			-- 			bul.Dir = Dir2
			-- 			bul.Spread 	= Vec0
			-- 			bul.Tracer	= 0
			-- 			bul.Force	= dmg * 0.75
			-- 			bul.Damage = bul.Damage * 0.75
						
			-- 			self.Owner:FireBullets(bul)
			-- 		end
			-- 	end
			-- end
		end
		
		td.mask = trace_normal
	//end
	
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK) 		// View model animation
	
	self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1) -- some weapons in the pack have slow recoil animation, so I've decided to slightly speed it up
	
	if not self.dt.Sil then
		self.Owner:MuzzleFlash()								// Crappy muzzle light
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)				// 3rd Person Animation
	
	if ( self.Owner:IsNPC() ) then return end
	
	// CUSTOM RECOIL !
end