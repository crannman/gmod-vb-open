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

local CT, vm, sequence, AvailableReload, wep, DTInt3, ent, AimVec, EyeAng, Offset, RecMod, bullet, vel, tr, rec, am
local destr, tsim, tcret, app, clamp, sin, cos, rand, rand2 = timer.Destroy, timer.Simple, timer.Create, math.Approach, math.Clamp, math.sin, math.cos, math.random, math.Rand

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
	
	if tr.HitPos:Distance(self.Owner:GetShootPos()) < 30 and tr.Entity:GetClass() != "prop_ragdoll" then
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
			Dir2 = Dir + VectorRand() * self.ClumpSpread
			
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