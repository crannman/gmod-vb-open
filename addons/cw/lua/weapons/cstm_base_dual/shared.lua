if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	SWEP.NoDocter = true
	
	SWEP.BulletLength = 9
	SWEP.CaseLength = 19
	SWEP.RequiresRail = false
	SWEP.NoLaser = true
end

if ( CLIENT ) then
	SWEP.PrintName			= "Dual M9 Elites"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "s"
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_pistol_dualelites", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.NoProperIronsights = true
end

SWEP.Base				= "cstm_base_pistol"
///SWEP.Category			= "Condition SWEPs (TEST)"

SWEP.Spawnable			= false
SWEP.AdminSpawnable		= false

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_pist_elite.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("weapons/elite/elite-1.wav")
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.11
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoAuto = true
SWEP.ACOGStatus = 0
SWEP.NoScopes = true
SWEP.NoBoltAnim = true
SWEP.ChamberAmount = 2

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.28 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.8
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone 		= 0.032
SWEP.HipCone 				= 0.038
SWEP.ConeInaccuracyAff1 = 0.5

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.AnimCyc = 1

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(-0.24, -1.803, 2.319)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(5.125, -3.089, 2.361)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(0.843, -0.956, 0.537)
SWEP.MeleeAng = Vector(0, 8.1, 0)

SWEP.NoFlipOriginsPos = Vector(0, 0, 0)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

local CT, RecMod, vm, act, muz, muz2, wep, par, ply, bullet, dt3, tr, rec
local clamp, rand = math.Clamp, math.random

function SWEP:PrimaryAttack()
	if self.ReloadTime then
		return
	end
	
	if self.Owner:KeyDown(IN_WALK) then
		if self:GetDTInt(3) == 0 then
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
	
	if self.FireMode == "safe" then
		if SERVER then
			self:SelectFiremode(self.FireModes[1])
			self.FireModes.last = 1
		end
		
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		self.Owner:ConCommand("cstm_melee")
		return
	end
	
	if self.FireMode == "2burst" then
		if self.dt.NumShots == 2 then
			return
		end
	end
	
	if self.FireMode == "3burst" then
		if self.dt.NumShots == 3 then
			return
		end
	end
	
	tr = self.Owner:GetEyeTrace()
	
	if tr.HitPos:Distance(self.Owner:GetShootPos()) < 30 then
		return
	end
	
	if self.ShouldBolt == true or self.IsReloading == true then
		return
	end
	
	dt3 = self:GetDTInt(3)
	
	if dt3 == 2 or dt3 == 19 then
		return
	end
	
	CT = CurTime()
	clip = self:Clip1()
	
	if (clip == 0 or self.Owner:WaterLevel() == 3) and not self.Grenade then
		self:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, rand(99, 101))
		self:SetNextSecondaryFire( CT + 0.05 )
		self:SetNextPrimaryFire( CT + 0.25 )
		return
	end
	
	self:SetNextSecondaryFire( CT + self.Primary.Delay )
	self:SetNextPrimaryFire( CT + self.Primary.Delay )
	
	if ( !self:CanPrimaryAttack() ) then return end
	
	self:TakePrimaryAmmo( 1 )
	
	if SERVER then
		if not self.dt.Sil then
			self.Owner:EmitSound(self.Primary.Sound, self.UnsilencedVolume, rand(99, 101))
		else
			self.Owner:EmitSound(self.SilencedSound, self.SilencedVolume, rand(99, 101))
		end
		
		if clip <= 10 then
			self.Owner:EmitSound("weapons/ClipEmpty_Rifle.wav", 60 - (clip * 4), 100)
		end
		
		if game.SinglePlayer() then
			SendUserMessage("RECOIL", self.Owner)
		end
	end
	
	self.ReloadDelay = CT + 0.5
	self.Owner.AttachDelay = CT + 0.5
	self.MeleeDelay = CT + 0.3
	
	RecMod = GetGlobalFloat("CR")
	rec = self:GetDTFloat(1)
	
	if dt3 != 1 then
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetDTFloat(0))
		self:Recoil(self.Primary.Recoil * rec * RecMod)
	else
		self:CSShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetDTFloat(0))
		self:Recoil(self.Primary.Recoil * 0.75 * rec * RecMod)
	end
	
	if CLIENT then
		if dt3 == 1 then
			self.RecoilAmt = 2.5
			self:MuzzleFlosh()
		end
	end
	
	if self.FireMode:find("burst") then
		self.dt.NumShots = self.dt.NumShots + 1
	end
	
	self.Owner:ViewPunch( Angle(-1 * (self.Primary.Recoil + self.ConeInaccuracy * 4) * rec, 0, 0 ) * RecMod )
	
	self.ConeInaccuracy = clamp(self.ConeInaccuracy + (0.005 + self.DefRecoil * (0.006 - (self.ConeDecAff1 + self.ConeDecAff2))) * self.InaccAff1, 0, 0.12 * (self.ConeInaccuracyAff1))
	self.ConeInaccDelay = CT + self.Primary.Delay * 1.05
	
	if ( self.Owner:IsNPC() ) then return end
end

if CLIENT then
	function SWEP:FireAnimationEvent(pos, ang, ev)
		if ev == 5001 then
			if not self.Owner:ShouldDrawLocalPlayer() then
				self:MuzzleFlosh()
				
				return ev == 5001
			end
		end
	end
	
	function SWEP:MuzzleFlosh() -- lololol
		vm = self.Owner:GetViewModel()
		act = self:GetSequenceActivityName(self:GetSequence())
		
		muz, muz2 = nil, nil
		
		if act == "ACT_VM_PRIMARYATTACK" then
			muz = vm:GetAttachment("2")
			muz2 = vm:LookupAttachment("2")
		else
			muz = vm:GetAttachment("1")
			muz2 = vm:LookupAttachment("1")
		end
				
		if not self.Em then
			self.Em = ParticleEmitter(muz.Pos)
		end
				
		if GetConVarNumber("cstm_ef_smoke") > 0 then
			ParticleEffect(self.SmokeEffect or "cstm_child_smoke_small", muz.Pos, self.Owner:EyeAngles(), muz)
		end
				
		if self.Silenced == true or self.Silenced == 1 then
			return
		end
		
		if (self.VElements and self.VElements["silencer"] != nil and self.Owner:GetActiveWeapon().VElements["silencer"].color.a != 255) or self.VElements and self.VElements["silencer"] == nil then -- I check if it's not nil and then if it's nil to ensure that weapons that don't have a silencer don't bug
				
			if GetConVarNumber("cstm_ef_heat") > 0 then
				par = self.Em:Add("sprites/heatwave", muz.Pos)
				par:SetStartSize(4)
				par:SetEndSize(1)
				par:SetDieTime(0.3)
			end
				
			if GetConVarNumber("cstm_ef_extramuzzle") > 0 then
				ParticleEffectAttach(self.Muzzle or "cstm_muzzle_pistol", PATTACH_POINT_FOLLOW, vm, muz2)
			end
					
			if GetConVarNumber("cstm_ef_sparks") > 0 then
				ParticleEffectAttach(self.SparkEffect or "cstm_child_sparks_small", PATTACH_POINT_FOLLOW, vm, muz2)
			end
	
		end
	end
	
	function SWEP:BoneReposFunc(ply, numbon, numphysbon)
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) then
			if wep.WElements and wep.WElements.BaseClass then
				wep.WElements.BaseClass = nil
			end
			
			if wep.ReposMyBones and wep.BonesToRepos then
				for k, v in pairs(wep.BonesToRepos) do
					local bone = ply:LookupBone(k)
					local matrix = ply:GetBoneMatrix(bone)
					
					if matrix then
						matrix:Rotate(v.ang)
						ply:SetBoneMatrix(bone, matrix)
					end
				end
			end
		end
	end
end

local damagemod1, damagemod2, Dir, ent, dot, sp
local trace_normal = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442)
local trace_walls = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)
local NoPenetration = {[MAT_SLOSH] = true}
local NoRicochet = {[MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true}
local PenMod = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul, td = {}, {}

function SWEP:CSShootBullet( dmg, recoil, numbul, cone )
	numbul 	= numbul 	or 1
	cone 	= cone 		or 0.01
	
	if self.IsSilenced then
		damagemod1 = 0.1
	else
		damagemod1 = 0
	end
	
	if self:GetDTInt(2) == 1 then
		damagemod2 = 0.3
	else
		damagemod2 = 0
	end
	
	/*if game.SinglePlayer() and GetConVarNumber("cstm_physbul_sp") >= 1 then
		if SERVER then
			for i = 1, self.Primary.NumShots do
				self.Owner:FireBulletsEx(1, self.Owner:GetShootPos(), (self.Owner:EyeAngles() + self.Owner:GetPunchAngle()):Forward(), self.Primary.Damage * (1 - (damagemod1 + damagemod2)), self:GetDTFloat(0), 10, self.PenStr * self.PenMod)
			end
		end
	else*/
		sp = self.Owner:GetShootPos()
		
		for i = 1, self.Primary.NumShots do
			Dir = (self.Owner:EyeAngles() + self.Owner:GetPunchAngle() + Angle(math.Rand(-cone, cone), math.Rand(-cone, cone), 0) * 25):Forward()
			
			bul.Num = 1
			bul.Src = sp
			bul.Dir = Dir
			bul.Spread 	= Vector(0, 0, 0)
			bul.Tracer	= 4
			bul.Force	= dmg
			bul.Damage = math.Round(dmg * (1 - (damagemod1 + damagemod2)))
			self.Owner:FireBullets(bul)
			
			-- td.start = sp
			-- td.endpos = td.start + Dir * 16384
			-- td.filter = self.Owner
			-- td.mask = trace_normal
			
			-- tr = util.TraceLine(td)
			
			-- if not NoPenetration[tr.MatType] then
			-- 	dot = -Dir:DotProduct(tr.HitNormal)
			-- 	ent = tr.Entity
				
			-- 	if dot > 0.26 and not ent:IsNPC() and not ent:IsPlayer() then
			-- 		td.start = tr.HitPos
			-- 		td.endpos = td.start + Dir * self.PenStr * (PenMod[tr.MatType] and PenMod[tr.MatType] or 1) * self.PenMod
			-- 		td.filter = self.Owner
			-- 		td.mask = trace_walls
					
			-- 		tr = util.TraceLine(td)
					
			-- 		bul.Num = 1
			-- 		bul.Src = tr.HitPos
			-- 		bul.Dir = Dir
			-- 		bul.Spread 	= Vec0
			-- 		bul.Tracer	= 4
			-- 		bul.Force	= dmg * 0.5
			-- 		bul.Damage = bul.Damage * 0.5
			-- 		bul.Callback = nil
			-- 		self.Owner:FireBullets(bul)
			-- 	else
			-- 		if not NoRicochet[tr.MatType] then
			-- 			Dir = Dir + (tr.HitNormal * dot) * 3
			-- 			Dir = Dir + VectorRand() * 0.06
			-- 			bul.Num = 1
			-- 			bul.Src = tr.HitPos
			-- 			bul.Dir = Dir
			-- 			bul.Spread 	= Vec0
			-- 			bul.Tracer	= 0
			-- 			bul.Force	= dmg * 0.75
			-- 			bul.Damage = bul.Damage * 0.75
			-- 			bul.Callback = nil
						
			-- 			self.Owner:FireBullets(bul)
			-- 		end
			-- 	end
			-- end
		end
		
		td.mask = trace_normal
	//end
	
	local eff
	
	if self.AnimCyc == 1 then
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.AnimCyc = 2
		eff = "ef_muzzle_right"
	elseif self.AnimCyc == 2 then
		self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
		self.AnimCyc = 1
		eff = "ef_muzzle_left"
	end
	
	if not game.SinglePlayer() then
		local ef = EffectData()
		ef:SetOrigin(self.Owner:GetShootPos())
		ef:SetEntity(self.Weapon)
		ef:SetAngles(self.Owner:GetAngles())
		util.Effect(eff, ef)
	end
	
	self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1) -- some weapons in the pack have slow recoil animation, so I've decided to slightly speed it up
	
	if ( self.Owner:IsNPC() ) then return end
	
	// CUSTOM RECOIL !
end

