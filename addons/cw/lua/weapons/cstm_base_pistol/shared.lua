if (SERVER) then
	AddCSLuaFile("shared.lua")
	AddCSLuaFile("sh_statoperations.lua")
	AddCSLuaFile("cl_umsgs.lua")
	include("sv_customization.lua")
	include("sv_statoperations.lua")
	include("sv_misc.lua")
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
	SWEP.ScopeStatus = 0
	SWEP.NoGL = true
	SWEP.SecondaryAtt = 0
	SWEP.GrenadeType = "gren_explosive"
	SWEP.BlastRadius = 512
	SWEP.BlastDamage = 90
	SWEP.Grenade = false
	SWEP.CanAimWithRail = false
	SWEP.EoTechWithRail = false
	SWEP.NoBipod = true
	SWEP.MeleeDelay = 0
	SWEP.IsCSTMWeapon = true
	SWEP.RequiresRail = true
	SWEP.MaxAmmoMod = 1
	SWEP.GiveAmmoMod = 1
end

include("sh_statoperations.lua")

SWEP.LastAmmo = "Normal"
SWEP.BurstMod = 1
SWEP.BurstAccMod = 1
SWEP.BurstRecoilMod = 1
SWEP.PenMod = 1
SWEP.DamageDecayMod = 1

if ( CLIENT ) then
	include("cl_umsgs.lua")
	SWEP.ActToCyc = {}
	SWEP.ActToCyc["ACT_VM_DRAW"] = 0.45
	SWEP.ActToCyc["ACT_VM_DRAW_SILENCED"] = 0.45
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.9
	SWEP.ActToCyc["ACT_VM_RELOAD_SILENCED"] = 0.9
	SWEP.ActToCyc["ACT_VM_ATTACH_SILENCER"] = 0.8
	SWEP.ActToCyc["ACT_VM_DETACH_SILENCER"] = 0.8

	SWEP.IsCSTMWeapon = true
	SWEP.BoneMod = {}
	SWEP.AmmoCycle = {}
	
	SWEP.BlendPos = Vector(0, 0, 0)
	SWEP.BlendAng = Vector(0, 0, 0)
	SWEP.Activity = ""
	SWEP.WasZero = false
	SWEP.SwayScale = 0
	SWEP.BobScale = 0
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.DrawWeaponInfoBox  = true
	SWEP.HasInstalledScope  = false
	SWEP.PitchMod = 1
	SWEP.RollMod = 1
	SWEP.EoTechWithRail = false
	SWEP.RecoilAmt = 0
	SWEP.RecoilTime = 0
	SWEP.CurFOV = 1.5
	SWEP.TargetFOV = 1.5
	SWEP.OverallMouseSensMod = 1
	SWEP.GrenadeName = "40MM HE"
	SWEP.LaserTune = {
		PosRight = 0,
		PosForward = 0,
		PosUp = 0,
		AngUp = -90,
		AngRight = 0,
		AngForward = 0 }
	
	function SWEP:IsActiveCModel(m)
		m = self.VElements[m]
		
		if not m or m.color.a != 255 then
			return false
		end
		
		return true
	end
end

SWEP.Author			= "LEETNOOB"
SWEP.Contact		= ""
SWEP.Purpose		= ""

// Note: This is how it should have worked. The base weapon would set the category
// then all of the children would have inherited that.
// But a lot of SWEPS have based themselves on this base (probably not on purpose)
// So the category name is now defined in all of the child SWEPS.
//SWEP.Category			= "Counter-Strike"

SWEP.FireModeNames = {["semi"] = {n = "Semi-automatic", bul = 1, auto = false},
["auto"] = {n = "Full-auto", bul = 5, auto = true},
["2burst"] = {n = "2-round burst", bul = 2, auto = true},
["3burst"] = {n = "3-round burst", bul = 3, auto = true},
["bolt"] = {n = "Bolt-action", bul = 1, auto = false},
["pump"] = {n = "Pump-action", bul = 1, auto = false},
["double"] = {n = "Double-action", bul = 1, auto = false},
["break"] = {n = "Break-action", bul = 1, auto = false},
["safe"] = {n = "Safe", bul = 0, auto = false, safe = true}}

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
SWEP.Base = "cmodel_cstm_base"
SWEP.Category = "Customizable weaponry"

SWEP.FlipOriginsPos = Vector(3.305, -1.968, 0.735)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

SWEP.NoFlipOriginsPos = Vector(-2.25, 0, -0.695)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(6.692, -4.173, -7.165)
SWEP.MeleeAng = Vector(25.629, -50.985, 26.18)

SWEP.MeleePosNoFlip = Vector(3.769, -9.672, -7.049)
SWEP.MeleeAngNoFlip = Vector(28.688, 70, 0)

SWEP.AngleDelta = Angle(0, 0, 0)
SWEP.OldDelta = Angle(0, 0, 0)

SWEP.ConeInaccuracy = 0
SWEP.ConeInaccuracyDec = 0
SWEP.SilencedSound = Sound("weapons/usp/usp1.wav")
SWEP.SilencedVolume = 70
SWEP.UnsilencedVolume = 150
SWEP.ConeInaccuracyAff1 = 1
SWEP.RecoilAff1 = 0
SWEP.RecoilAff2 = 0
SWEP.RecoilAff3 = 0
SWEP.InaccAff1 = 1
SWEP.ConeInaccDelay = 0
SWEP.ConeDecAff1 = 0
SWEP.ConeDecAff2 = 0
SWEP.MeleeDamageMin = 20
SWEP.MeleeDamageMax = 25

SWEP.HolsterStatus = 0
SWEP.HolsterTime = 0
SWEP.NumShots = 0

local vm, n, t

function SWEP:MakeBoneMods()
	vm = self.Owner:GetViewModel()
	self.BoneMod.cur = {}
	
	for i = 1, vm:GetBoneCount() - 1 do
		self.BoneMod.cur[vm:GetBoneName(i)] = {curoffset = Vector(0, 0, 0), currotation = Angle(0, 0, 0)}
	end
end

function SWEP:Initialize()
	if SERVER then
		self:SetNPCMinBurst(30)
		self:SetNPCMaxBurst(30)
		self:SetNPCFireRate(0.01)
	end
	
	self:CalculateEffectiveRange()	
	self:SetWeaponHoldType(self.HoldType)
	self:SetDTInt(3, 0)
	self:SetDTFloat(0, 0)
	self:SetDTInt(2, 0)
	self.BodyGroup = self.SightBG
	self.FireMode = self.FireModes[1]
	self.FireModes[#self.FireModes + 1] = "safe"
	self.ReloadDelay = CurTime() + 0.1
	self.Primary.Recoil = self.DefRecoil
	self.Primary.Damage_Orig = self.Primary.Damage
	self.Primary.ClipSize_Orig = self.Primary.ClipSize
	self.IronsightsCone_Orig = self.IronsightsCone
	self.HipCone_Orig = self.HipCone
	self.Primary.Delay_Orig = self.Primary.Delay
	self.ConeInaccuracyAff1_Orig = self.ConeInaccuracyAff1
	self.BurstMod_Orig = self.BurstMod
	self.BurstAccMod_Orig = self.BurstAccMod
	self.BurstRecoilMod_Orig = self.BurstRecoilMod
	self:SetClip1(self.Primary.ClipSize)
	self.DamageMods = {}
	self.RecoilMods = {}
	self.HipConeMods = {}
	self.AimConeMods = {}
	self.FirerateMods = {}
	self.OtherMods = {}
	
	if not self.Owner.FuseTime then
		self.Owner.FuseTime = 3
	end
	
	if not self.AmmoTypes then
		self.AmmoTypes = {"hp", "ap", "magnum", "incendiary"}
	end
	
	t = self.FireModeNames[self.FireModes[1]]
	self.Primary.Automatic = t.auto
	self.Bullets = t.bul
	
    if CLIENT then
		self.RecoilDisplay = math.Round(self.DefRecoil * 100, 2)
		
		if IsValid(self.Owner) and self.Owner == LocalPlayer() then
			self:MakeBoneMods()
		end
		
		self.AimPos_Orig = self.AimPos
		self.AimAng_Orig = self.AimAng
     
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
 
        self:CreateModels(self.VElements) // create viewmodels
        self:CreateModels(self.WElements) // create worldmodels
    end
end

function SWEP:SetupDataTables()
	self:DTVar("Bool", 0, "Sil")
	self:DTVar("Int", 1, "NumShots")
	self.dt.NumShots = 0
	self.dt.Sil = self.IsSilenced
end

local CT, ammotype, clip, mul, seqdur, ammo, AmountToReload, chamber, sequence, AimVec, wepclass, wep, activity, FT, bone, matrix, ply, m, ef, RecMod, eyeang, RS, Off, Off2, Right, Up, Forward, dlight, muz, muz2, number, Width, Height, x2, x3, y2, y3, Text, trace, coords, out_r, out_g, out_b, out_a, in_r, in_g, in_b, in_a, scale, cl, dtint3, fov, ScopeStatus, physobj, time, cyc, s, ent, can
local destr, tsim, app, clamp, sin, cos, rand, rand2 = timer.Destroy, timer.Simple, math.Approach, math.Clamp, math.sin, math.cos, math.random, math.Rand
local tr = {}
local Vec0 = Vector(0, 0, 0)
local Ang0 = Angle(0, 0, 0)

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
		
		if game.SinglePlayer() then
			tsim(0, function()
				if IsValid(self) and self.Owner and self.Owner:Alive() then
					self.Owner:SendLua("local wep = LocalPlayer():GetActiveWeapon() wep:ResetSequence(wep:SelectWeightedSequence(ACT_VM_DRAW))")
				end
			end)
		end
	end
	
	self:SetDTInt(3, 0)
	self.HolsterStatus = 0
	
	return true
end

local initial = false

function SWEP:Holster(weapon)
	if not IsValid(self.Owner) or not self.Owner:Alive() then
		return
	end
	
	CT = CurTime()
	
	if CT < self.HolsterTime then
		return false
	end
	
	if self:GetDTInt(3) != 6 then
		if CT < self.ReloadDelay then
			return false
		end
	end
	
	if self.HolsterStatus == 0 or not self.HolsterStatus then
		self.HolsterStatus = 1
		self:SetDTInt(3, 6)
		self:SetNextPrimaryFire(CT + 0.4)
		self:SetNextSecondaryFire(CT + 0.4)
		self.ReloadDelay = CT + 0.4
		self:EmitSound("weapons/cstm/holster" .. math.random(1, 4) .. ".wav", 65, 100)
		
		timer.Simple(0.35, function()
			if not IsValid(self) or not IsValid(self.Owner) then
				return
			end

			self.Owner:GetViewModel().BuildBonePositions = nil
			self.ReloadTime = nil

			if CLIENT then
				if self:GetOwner() == LocalPlayer() then
					if PAs then
						for k, v in pairs(PAs) do
							if ValidPanel(v) then
								v:Remove()
							end
						end
					end
				end
			end
			
			if SERVER then
				if IsValid(weapon) and self.Owner then
					self.Owner:SetFOV(0, 0.3)
					self.Owner:SelectWeapon(weapon:GetClass())
				end
			end
			
			return true
		end)
		
		return false
	end

	return true
end

function SWEP:Reload()
	if self.ReloadTime then
		return
	end
	
	dtint3 = self:GetDTInt(3)
	
	if dtint3 == 19 then
		return
	end
	
	CT = CurTime()

	if not self.HasReleasedKey or CT < self.ReloadDelay then
		return
	end
	
	if self.Owner:KeyDown(IN_WALK) and dtint3 != 1 then
		if self.CantSilence == true then
			return
		end
	
		if not self.dt.Sil then
			if SERVER then
				self:SetDTInt(3, 6)
				
				tsim(0.5, function()
					if not IsValid(self) then
						return
					end
					
					self.Owner:EmitSound("weapons/usp/usp_silencer_on.wav", 50, rand(99, 101))
					self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
				end)
				
				tsim(2, function()
					if not IsValid(self) then
						return
					end
					
					self:NWAlpha(255)
					self.dt.Sil = true
					self:SetDTInt(3, 7)
				end)
			end
			
		else
			if SERVER then
				self:SetDTInt(3, 6)
				
				tsim(0.5, function()
					if not IsValid(self) then
						return
					end
					
					self.Owner:EmitSound("weapons/usp/usp_silencer_off.wav", 50, rand(99, 101))
					self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_PLACE)
				end)
				
				tsim(1.8, function()
					if not IsValid(self) then
						return
					end
					
					self:NWAlpha(1)
					self.dt.Sil = false
					self:SetDTInt(3, 7)
				end)
			end
			
		end
		
		self:SetNextPrimaryFire(CT + 2.35)
		self:SetNextSecondaryFire(CT + 2.35)
		self.ReloadDelay = CT + 2.35
		self.Owner.AttachDelay = CT + 2.35
		
		return
	end
	
	if self.Owner:KeyDown(IN_USE) then
		if SERVER then
			self:CycleFiremodes()
		end
		
		self.ReloadDelay = CT + 0.25
		
		return
	end
	
	if self.Owner:WaterLevel() >= 3 then
		return
	end
	
	if self.Safe then
		return
	end
	
	clip = self:Clip1()
	
	if self.EmptyReloadOnly and clip != 0 then
		return
	end
	
	if dtint3 != 2 then
		if (not self.CantChamber and clip <= self.Primary.ClipSize) or (self.CantChamber and clip < self.Primary.ClipSize) then
			if self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
				if CT > self.ReloadDelay then
					if SERVER then
						if self.Owner:GetFOV() != 0 then
							self.Owner:SetFOV(0, 0.3)
							self.Owner:DrawViewModel(true)
							self.LastMag = self:Clip1()
							
							if clip >= 1 then
								ammotype = self:GetPrimaryAmmoType()
							
								if not self.CantChamber then
									self.Owner:SetAmmo(self.Owner:GetAmmoCount(ammotype) + clip - 1, ammotype)
									self:SetClip1(1)
								else
									self.Owner:SetAmmo(self.Owner:GetAmmoCount(ammotype) + clip, ammotype)
									self:SetClip1(0)
								end
							end
						end
					end
				
					self:StartCustomReload()
					self.Owner:SetAnimation(PLAYER_RELOAD)
					self.AnimPlayed = false
					self:SetDTInt(3, 0)
				end
			end
		end
	end
end

function SWEP:StartCustomReload()
	clip = self:Clip1()
	vm = self.Owner:GetViewModel()
	mul = 1
	
	if IsFirstTimePredicted() then
		if self.NonEmptyReloadAnim then
			if clip == 0 then
				self:SendWeaponAnim(ACT_VM_RELOAD_EMPTY)
				seqdur = vm:SequenceDuration()
				
				if self.SkipIdle then
					time = seqdur / self.ReloadSpeed
				else
					time = seqdur / self.ReloadSpeed * self.IncAmmoPerc
				end
				
				mul = clip == 0 and 1 or 1 - self.IncAmmoPerc
			else
				self:SendWeaponAnim(ACT_VM_RELOAD)
				seqdur = vm:SequenceDuration()
				time = seqdur / self.ReloadSpeed
			end
		else
			self:SendWeaponAnim(ACT_VM_RELOAD)
			seqdur = vm:SequenceDuration()
			
			if self.SkipIdle then
				time = seqdur / self.ReloadSpeed
			else
				time = seqdur / self.ReloadSpeed * self.IncAmmoPerc
			end
			
			mul = clip == 0 and 1 or 1 - self.IncAmmoPerc
		end
	end
	
	vm:SetPlaybackRate(self.ReloadSpeed)
	
	if clip == 0 then
		self.ShouldBolt = true
	end
	
	CT = CurTime()
	
	self.ReloadTime = CT + time
	self:SetNextPrimaryFire(CT + (seqdur / self.ReloadSpeed) * mul)
	self:SetNextSecondaryFire(CT + (seqdur / self.ReloadSpeed) * mul)
	self.ReloadDelay = CT + (seqdur / self.ReloadSpeed + 0.3) * mul
	self.Owner.AttachDelay = CT + (seqdur / self.ReloadSpeed) * mul
	self.MeleeDelay = CT + (seqdur / self.ReloadSpeed) * mul
end

function SWEP:FinishCustomReload(bolt)
	CT = CurTime()
	clip = self:Clip1()
	ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)
	AmountToReload = clamp(self.Primary.ClipSize - clip, 0, self.Primary.ClipSize)
	
	if clip == 0 then
		self.Owner:RemoveAmmo(AmountToReload, self.Primary.Ammo)
		self:SetClip1(clamp(ammo, 0, self.Primary.ClipSize))
	else
		chamber = self.ChamberAmount or 1
		
		if ammo >= (AmountToReload + chamber) and self.CantChamber != true then
			self.Owner:RemoveAmmo(AmountToReload + chamber, self.Primary.Ammo)
			self:SetClip1(clamp(self.Primary.ClipSize + chamber, 0, self.Primary.ClipSize + chamber))
		else
			self.Owner:RemoveAmmo(AmountToReload + chamber, self.Primary.Ammo)
			self:SetClip1(clamp(ammo + clip, 0, self.Primary.ClipSize))
		end
		
		if self.SkipIdle != true then
			self:SendWeaponAnim(ACT_VM_IDLE)
			self.Owner:GetViewModel():SetPlaybackRate(self.IdleAnimSpeed and self.IdleAnimSpeed or 1)
			self:SetNextPrimaryFire(CT + 0.25)
			self:SetNextSecondaryFire(CT + 0.25)
			self.ReloadDelay = CT + 0.25
			self.Owner.AttachDelay = CT + 0.25
			self.MeleeDelay = CT + 0.25
		end
	end
	
	if bolt == false or self.NoBoltAnim == true then
		self.ShouldBolt = false
	else
		if self.LastMag == 0 then
			self:BoltWeaponry()
		end
		
		self.ShouldBolt = false
	end
end

function SWEP:BoltWeaponry()
	vm = self.Owner:GetViewModel()
	self:SendWeaponAnim(ACT_VM_DRAW)
	vm:SetPlaybackRate(self.ReloadSpeed)
	seqdur = vm:SequenceDuration()
	
	if not self.SkipBoltIdle then
		seqdur = seqdur - 0.2
		self:SetNextPrimaryFire(CT + seqdur)
		self:SetNextSecondaryFire(CT + seqdur)
		self.ReloadDelay = CT + seqdur
		self.Owner.AttachDelay = CT + seqdur
		self.MeleeDelay = CT + seqdur
		
		tsim((vm:SequenceDuration() - 0.2) / self.ReloadSpeed, function()
			if not IsValid(self) or self:GetClass() != self.Owner:GetActiveWeapon():GetClass() then
				return
			end
			
			self:SendWeaponAnim(ACT_VM_IDLE)
			vm:SetPlaybackRate(self.IdleAnimSpeed and self.IdleAnimSpeed or 1)
		end)
	else
		self:SetNextPrimaryFire(CT + seqdur)
		self:SetNextSecondaryFire(CT + seqdur)
		self.ReloadDelay = CT + seqdur
		self.Owner.AttachDelay = CT + seqdur
		self.MeleeDelay = CT + seqdur
	end
end

function SWEP:CycleFiremodes()
	t = self.FireModes
	
	if not t.last then
		t.last = 2
	else
		if not t[t.last + 1] then
			t.last = 1
		else
			t.last = t.last + 1
		end
	end
	
	if self:GetDTInt(3) == 1 then
		if self.FireModes[t.last] == "safe" then
			t.last = 1
		end
	end
	
	if self.FireMode != self.FireModes[t.last] then
		self:SelectFiremode(self.FireModes[t.last])
	end
end

function SWEP:SelectFiremode(n)
	CT = CurTime()
	
	self:SetNextPrimaryFire(CT + 0.2)
	self:SetNextSecondaryFire(CT + 0.2)
	self.ReloadDelay = CT + 0.2
	self.Owner.AttachDelay = CT + 0.2
	self.MeleeDelay = CT + 0.2
	
	self.Primary.Automatic = self.FireModeNames[n].auto
	self.FireMode = n
	self.Safe = self.FireModeNames[n].safe
	
	if CLIENT then
		return
	end
	
	umsg.Start("FRMD")
		umsg.Entity(self.Owner)
		umsg.String(n)
	umsg.End()
end

local sp, vel, force, ong

function SWEP:Think()	
	CT = CurTime()
	dtint3 = self:GetDTInt(3)
	wepclass = self:GetClass()
	vel = self.Owner:GetVelocity():Length()
	ong = self.Owner:OnGround()
	
	if self.ReloadTime then
		if CT > self.ReloadTime then
			if self:Clip1() == 0 then
				self:FinishCustomReload(true)
			else
				self:FinishCustomReload(false)
			end
			
			self.ReloadTime = nil
		end
	end

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
			self.CurCone = self.IronsightsCone / GetConVarNumber("cstm_accuracymod_aim") * (self.dt.Sil and 0.9 or 1)
		elseif dtint3 == 17 then
			self.ConeDecAff2 = 0.0045
			self.RecoilAff1 = 0.5
			self.CurCone = self.IronsightsCone / GetConVarNumber("cstm_accuracymod_aim") * (self.dt.Sil and 0.9 or 1)
		else
			self.ConeDecAff2 = 0
			self.RecoilAff1 = 0
			
			if self.InstalledLaser then
				self.CurCone = clamp(self.HipCone * 0.4 / GetConVarNumber("cstm_accuracymod_hip"), 0.02, 1)
			else
				self.CurCone = self.HipCone / GetConVarNumber("cstm_accuracymod_hip")
			end
		end
		
		if self.InstalledBipod then
			can = false
			
			if self.Owner:EyeAngles().p >= -25 then
				if vel == 0 then
					sp = self.Owner:GetShootPos()
					
					tr.start = sp
					tr.endpos = tr.start + Vector(AimVec.x, AimVec.y, AimVec.z * 0.1 - 1.25) * 25
					tr.filter = self.Owner
					
					trace = util.TraceLine(tr)
					
					if trace.Hit and trace.HitPos.z > self.Owner:GetPos().z + 2 then -- make sure we have something to place the bipod on and we're not placing the bipod on something lower than our standing position
						ent = trace.Entity
						
						if not ent:IsPlayer() and not ent:IsNPC() then
							tr.start = sp - Vector(0, 0, 10)
							tr.endpos = tr.start + AimVec * 30
							tr.filter = self.Owner
							
							trace = util.TraceLine(tr)
							
							if not trace.Hit then -- make sure the bipod is not gonna hit something below your crosshair
								tr.start = sp 
								tr.endpos = tr.start + AimVec * 30
								tr.filter = self.Owner
								
								trace = util.TraceLine(tr)
								
								if not trace.Hit then -- make sure there is nothing ahead of the player
									if not ent:IsPlayer() and not ent:IsNPC() then
										if dtint3 != 1 then
											self.CurCone = self.IronsightsCone + 0.01
											self.RecoilAff1 = 0.6
										else
											self.RecoilAff1 = 0.7
										end
										
										can = true
									end
								end
							end
						end
					end
				end
			end
			
			self:SetDTBool(1, can)
		end
	
		self.Primary.Cone = clamp((self.CurCone + self.ConeInaccuracy + ((vel / 10000) * (dtint3 == 1 and self.VelocitySensivity * 0.3 or self.VelocitySensivity)) - self.ConeAff1 + self.Owner.ViewAff), 0.0004, 0.12)
		self:SetDTFloat(0, clamp(self.Primary.Cone, 0.0004, 0.12 * (1 - (self.RecoilAff1 + self.RecoilAff2))  * (dtint3 == 1 and 0.25 or 1)))
		self:SetDTFloat(1, clamp(1 - self.RecoilAff1 - self.RecoilAff2 - self.RecoilAff3, 0.05, 1))
		
		if CT > self.ConeInaccDelay then
			self.ConeInaccuracy = clamp(self.ConeInaccuracy - 0.0015, 0, 0.08 * self.ConeInaccuracyAff1)
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
	end
	
	if not self.Owner:KeyDown(IN_ATTACK) and self.dt.NumShots != 0 and self.FireMode:find("burst") then
		self:SetNextPrimaryFire(CT + self.Primary.Delay * 2)
		self.dt.NumShots = 0
	end

	if SERVER then
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
	end
	
	dtint3 = self:GetDTInt(3) -- get it again because it was most likely updated
	
	if dtint3 == 1 then
		trace = self.Owner:GetEyeTrace()
		
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 30 and trace.Entity:GetClass() != "prop_ragdoll" then
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
	
	if CLIENT then
		if self:GetDTBool(1) then
			if not self.BipodActive then
				self.BipodActive = true
				surface.PlaySound("weapons/cstm/attach.wav")
			end
		else
			if self.BipodActive then
				self.BipodActive = false
				surface.PlaySound("weapons/cstm/detach.wav")
			end
		end
	end
end

if CLIENT then
	local m
	
	local Vec1, Vec003, Vec001 = Vector(1, 1, 1), Vector(0.005, 0.005, 0.005), Vector(0.001, 0.001, 0.001)
	
	function TWeps_BBP()
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()
		
		if not ply.LastWep then
			ply.LastWep = wep
		end
		
		if not IsValid(wep) then
			return
		end
		
		if not wep.VElements then
			return
		end
		
		vm = ply:GetViewModel()
		activity = vm:GetSequenceActivityName(vm:GetSequence())
		seqdur = vm:SequenceDuration()
		cyc = vm:GetCycle()
		FT = FrameTime()
		m = clamp(FT * 20, 0, 1)
		
		if not wep.IsCSTMWeapon then
			return
		end
		
		if wep.MagBone then
			if wep:IsActiveCModel("cmag") then 
				vm:ManipulateBoneScale(vm:LookupBone(wep.MagBone), Vec003)
			else
				vm:ManipulateBoneScale(vm:LookupBone(wep.MagBone), Vec1)
			end
		end
			
		if wep.OtherBone then
			if (wep:IsActiveCModel("eotech") or wep:IsActiveCModel("aimpoint") or wep:IsActiveCModel("acog") or wep:IsActiveCModel("elcan") or wep:IsActiveCModel("kobra") or wep:IsActiveCModel("riflereflex") or wep:IsActiveCModel("ballistic")) then
				vm:ManipulateBoneScale(vm:LookupBone(wep.OtherBone), Vec001)
			else
				vm:ManipulateBoneScale(vm:LookupBone(wep.OtherBone), Vec1)
			end
		end
		
		if wep.ViewModelBonescales then
			for k, v in pairs( wep.ViewModelBonescales ) do
				bone = vm:LookupBone(k)
				
				if (!bone) then 
					continue 
				end
				
				m = vm:GetBoneMatrix(bone)
				
				if (!m) then 
					continue
				end
				
				m:Scale(v)
				vm:SetBoneMatrix(bone, m)
			end
		end
		
		dtint3 = wep:GetDTInt(3)
		
		if dtint3 == 15 then
			if wep.MeleeOffset then
				wep.BoneMod.target = wep.MeleeOffset
			else
				if wep:IsActiveCModel("cmag") then
					wep.BoneMod.target = wep.CMag_Idle
				elseif wep:IsActiveCModel("vertgrip") then
					wep.BoneMod.target = wep.VertGrip_Idle
				end
			end
		else
			wep.BoneMod.target = nil
				
			if activity then
				if wep:IsActiveCModel("grenadelauncher") then
					if activity:find("ACT_VM_IDLE") or activity:find("ACT_VM_PRIMARYATTACK") or cyc >= wep.ActToCyc[activity] then
						if dtint3 == 8 then
							wep.BoneMod.target = wep.GrenadeLauncher_Active and wep.GrenadeLauncher_Active or wep.GrenadeLauncher_Idle
						else
							wep.BoneMod.target = wep.GrenadeLauncher_Idle
						end
					end
				elseif wep:IsActiveCModel("vertgrip") then
					if activity:find("ACT_VM_IDLE") or activity:find("ACT_VM_PRIMARYATTACK") or cyc >= wep.ActToCyc[activity] then
						wep.BoneMod.target = wep.VertGrip_Idle
					end
				end
				
				if wep:IsActiveCModel("cmag") then 
					if (activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_EMPTY" or activity == "ACT_VM_RELOAD_SILENCED") and cyc <= wep.ActToCyc[activity] then
						wep.BoneMod.target = wep.CMag_Reload 
					else
						if not wep.BoneMod.target then
							wep.BoneMod.target = wep.CMag_Idle
						end
					end
				end
			end
		end
		
		if not wep.BoneMod.cur then
			wep:MakeBoneMods()
		end
		
		if wep.BoneMod.target then
			for k, v in pairs(wep.BoneMod.target) do
				n = wep.BoneMod.cur[k]
				
				if not n then
					wep:MakeBoneMods()
				else
					n.curoffset = LerpVector(m, n.curoffset, v.vector)
					n.currotation = LerpAngle(m, n.currotation, v.angle)
				end
			end
			
			for k, v in pairs(wep.BoneMod.cur) do
				if not wep.BoneMod.target[k] then
					v.curoffset = LerpVector(m, v.curoffset, Vec0)
					v.currotation = LerpAngle(m, v.currotation, Ang0)
				end
				
				bone = vm:LookupBone(k)
				
				if bone then
					vm:ManipulateBonePosition(bone, v.curoffset)
					vm:ManipulateBoneAngles(bone, v.currotation)
				end
			end
		else
			if wep.BoneMod.cur then
				for k, v in pairs(wep.BoneMod.cur) do
					v.curoffset = LerpVector(m, v.curoffset, Vec0)
					v.currotation = LerpAngle(m, v.currotation, Ang0)
					
					bone = vm:LookupBone(k)
					
					if bone then
						vm:ManipulateBonePosition(bone, v.curoffset)
						vm:ManipulateBoneAngles(bone, v.currotation)
					end
				end
			end
		end
	end
end

local rec, burst

function SWEP:PrimaryAttack()
	if self.ReloadTime then
		return
	end
	
	dtint3 = self:GetDTInt(3)
	CT = CurTime()
	
	if self.Owner:KeyDown(IN_WALK) then
		if self.Owner:WaterLevel() < 3 then
			if dtint3 == 0 then
				if self.Owner:GetAmmoCount("Grenade") > 0 then
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

	if self.Owner:WaterLevel() == 3 then
		self:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, rand(99, 101))
		self:SetNextSecondaryFire( CT + 0.05 )
		self:SetNextPrimaryFire( CT + 0.25 )
		return
	end
	
	trace = self.Owner:GetEyeTrace()
	
	if trace.HitPos:Distance(self.Owner:GetShootPos()) < 30 and trace.Entity:GetClass() != "prop_ragdoll" then
		return
	end
	
	if dtint3 == 2 or dtint3 == 19 then
		return
	end
	
	clip = self:Clip1()
	
	if clip == 0 and not self.Grenade then
		self:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, rand(99, 101))
		self:SetNextSecondaryFire( CT + 0.05 )
		self:SetNextPrimaryFire( CT + 0.2 )
		return
	end
	
	if CLIENT and not game.SinglePlayer() then
		if self.Owner:KeyDown(IN_USE) then
			if (self.VElements and self.VElements["grenadelauncher"] and self.VElements["grenadelauncher"].color.a == 255) or dtint3 == 8 then
				return
			end
		else
			if self.VElements and self.VElements["grenadelauncher"] and self.VElements["grenadelauncher"].color.a == 255 and dtint3 == 8 then
				return
			end
		end
	end
	
	if SERVER then
		if self.SecondaryAtt == 1 and self.Grenade and dtint3 == 8 then
			if self.Owner:GetAmmoCount(self.Secondary.Ammo) == 0 then
				self.Owner:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, rand(99, 101))
				self:SetNextPrimaryFire( CT + 0.2 )
				self:SetNextSecondaryFire( CT + 0.05 )
				return
			end
		
			local prop = ents.Create(self.GrenadeType)
			prop:SetPos(self.Owner:EyePos() + self.Owner:GetAimVector() * 24 + self.Owner:GetRight() * 4 + self.Owner:GetUp() * -6)
			prop:SetOwner(self.Owner)
			prop:SetAngles(self.Owner:EyeAngles())
			prop.BlastRadius = self.BlastRadius
			prop.BlastDamage = self.BlastDamage
			prop:Spawn()
			prop:GetPhysicsObject():SetVelocity(self.Owner:GetAimVector() * 5000)
			prop:SetOwner(self.Owner)
			
			self.Owner:ViewPunch(Angle(-10, 0, 0))
			self.Owner:EmitSound("weapons/grenade_launcher1.wav", 85, 100)
			self:TakeSecondaryAmmo(1)
			self:SetDTInt(3, 0)
			self.Owner:SetFOV(0, 0.3)
			
			if self.Owner:GetAmmoCount(self.Secondary.Ammo) > 0 then
				self:SetNextPrimaryFire(CT + 3)
				self:SetNextSecondaryFire(CT + 3)
				self.ReloadDelay = CT + 3
				self.Owner.AttachDelay = CT + 3
			else
				self:SetNextPrimaryFire(CT + 0.3)
				self:SetNextSecondaryFire(CT + 0.3)
				self.ReloadDelay = CT + 0.3
				self.Owner.AttachDelay = CT + 0.3
			end
			
			tsim(0.5, function()
				if (not IsValid(self) or self:GetClass() != self.Owner:GetActiveWeapon():GetClass()) or self.Owner:GetAmmoCount(self.Secondary.Ammo) == 0 then
					return
				end
			
				self:SetDTInt(3, 6)
			end)
				
			tsim(1, function()
				if (not IsValid(self) or self:GetClass() != self.Owner:GetActiveWeapon():GetClass()) or self.Owner:GetAmmoCount(self.Secondary.Ammo) == 0 then
					return
				end
				
				self.Owner:EmitSound("weapons/smg1/smg1_reload.wav", 50, 100)
				self.Owner:DoAnimationEvent(ACT_GMOD_GESTURE_ITEM_GIVE)
			end)
			
			tsim(2.75, function()
				if (not IsValid(self) or self:GetClass() != self.Owner:GetActiveWeapon():GetClass()) or self.Owner:GetAmmoCount(self.Secondary.Ammo) == 0 then
					return
				end
				
				self:SetDTInt(3, 0)
			end)
				
			if self.Owner:GetAmmoCount(self.Secondary.Ammo) == 0 then
				self.Grenade = false
				SendUserMessage("M203_OFF", self.Owner) -- more reliable via UMSGS
			end
			
			return
		end
	end
	
	if ( !self:CanPrimaryAttack() ) then return end
	
	self:TakePrimaryAmmo(1)
	
	if not self.dt.Sil then
		self:EmitSound(self.Primary.Sound, self.UnsilencedVolume, rand(99, 101))
	else
		self:EmitSound(self.SilencedSound, self.SilencedVolume, rand(99, 101))
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
	
	if self.Primary.Delay >= 0.22 then
		self.ReloadDelay = CT + self.Primary.Delay
	else
		self.ReloadDelay = CT + 0.5
	end
	
	self.Owner.AttachDelay = CT + 0.5
	self.MeleeDelay = CT + 0.3
	
	RecMod = GetGlobalFloat("CR")
	rec = self:GetDTFloat(1)
	burst = self.FireMode:find("burst")

	if dtint3 != 1 then
		self:CSShootBullet( self.Primary.Damage, self.DefRecoil * RecMod, self.Primary.NumShots, self:GetDTFloat(0))
		
		if burst and self.BurstDelayedRecoil then
			if (self.dt.NumShots == self.BurstDelayRecoilShots) or clip == 1 then
				self:Recoil(self.DefRecoil * rec * RecMod * (clip == 1 and 1 or self.BurstRecoilMod))
				self.Owner:ViewPunch(Angle(-1 * (self.DefRecoil + self.ConeInaccuracy * 4) * rec, 0, 0 ) * RecMod * (clip == 1 and 1 or self.BurstRecoilMod))
			end
		else
			self:Recoil(self.DefRecoil * rec * RecMod)
			self.Owner:ViewPunch(Angle(-1 * (self.DefRecoil + self.ConeInaccuracy * 4) * rec, 0, 0 ) * RecMod)
		end
	else
		self:CSShootBullet( self.Primary.Damage, self.DefRecoil * 0.75 * RecMod, self.Primary.NumShots, self:GetDTFloat(0))
		
		if burst and self.BurstDelayedRecoil then
			if (self.dt.NumShots == self.BurstDelayRecoilShots) or clip == 1 then
				self:Recoil(self.DefRecoil * 0.75 * rec * RecMod * (clip == 1 and 1 or self.BurstRecoilMod))
				self.Owner:ViewPunch(Angle(-1 * (self.DefRecoil + self.ConeInaccuracy * 4) * rec, 0, 0 ) * RecMod * (clip == 1 and 1 or self.BurstRecoilMod))
			end
		else
			self:Recoil(self.DefRecoil * 0.75 * rec * RecMod)
			self.Owner:ViewPunch(Angle(-1 * (self.DefRecoil + self.ConeInaccuracy * 4) * rec, 0, 0 ) * RecMod)
		end
	end
	
	if burst then
		self.dt.NumShots = self.dt.NumShots + 1
		
		if not self.BurstFireDelay then
			self:SetNextSecondaryFire(CT + self.Primary.Delay * 0.67 * self.BurstMod)
			self:SetNextPrimaryFire(CT + self.Primary.Delay * 0.67 * self.BurstMod)
		else
			self:SetNextSecondaryFire(CT + self.BurstFireDelay)
			self:SetNextPrimaryFire(CT + self.BurstFireDelay)
		end
		
		self.ConeInaccuracy = clamp(self.ConeInaccuracy + ((0.005 + self.DefRecoil * (0.006 - (self.ConeDecAff1 + self.ConeDecAff2))) * self.InaccAff1) * 0.5 * self.BurstAccMod, 0, 0.08 * (self.ConeInaccuracyAff1))
	else
		self:SetNextSecondaryFire( CT + self.Primary.Delay )
		self:SetNextPrimaryFire( CT + self.Primary.Delay )
		self.ConeInaccuracy = clamp(self.ConeInaccuracy + (0.005 + self.DefRecoil * (0.006 - (self.ConeDecAff1 + self.ConeDecAff2))) * self.InaccAff1, 0, 0.08 * (self.ConeInaccuracyAff1))
	end
	
	if self.UnAimAfterShot then
		if self:GetDTInt(3) == 1 then
			self:SetDTInt(3, 0)
			self.Owner:SetFOV(0, 0.3)
		end
	end
	
	self.ConeInaccDelay = CT + self.Primary.Delay * 1.05
	
	if ( self.Owner:IsNPC() ) then return end
end

local Dir, Dir2, dot
local trace_normal = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442, CONTENTS_WATER)
local trace_walls = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)
local NoPenetration = {[MAT_SLOSH] = true}
local NoRicochet = {[MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true}
local PenMod = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul = {}

function SWEP:CSShootBullet(dmg, recoil, numbul, cone)
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
			
		-- 	tr.start = sp
		-- 	tr.endpos = tr.start + Dir2 * 16384
		-- 	tr.filter = self.Owner
		-- 	tr.mask = trace_normal
			
		-- 	trace = util.TraceLine(tr)
			
		-- 	if not NoPenetration[trace.MatType] then
		-- 		dot = -Dir2:DotProduct(trace.HitNormal)
		-- 		ent = trace.Entity
			
		-- 		if dot > 0.26 and not ent:IsNPC() and not ent:IsPlayer() then
		-- 			tr.start = trace.HitPos
		-- 			tr.endpos = tr.start + Dir2 * self.PenStr * (PenMod[trace.MatType] and PenMod[trace.MatType] or 1) * self.PenMod
		-- 			tr.filter = self.Owner
		-- 			tr.mask = trace_walls
					
		-- 			trace = util.TraceLine(tr)
					
		-- 			tr.start = trace.HitPos
		-- 			tr.endpos = tr.start + Dir2 * 0.1
		-- 			tr.filter = self.Owner
		-- 			tr.mask = trace_normal
					
		-- 			trace = util.TraceLine(tr) -- run ANOTHER trace to check whether we've penetrated a surface or not
					
		-- 			if not trace.Hit then
		-- 				bul.Num = 1
		-- 				bul.Src = trace.HitPos
		-- 				bul.Dir = Dir2
		-- 				bul.Spread 	= Vec0
		-- 				bul.Tracer	= 4
		-- 				bul.Force	= dmg * 0.5
		-- 				bul.Damage = bul.Damage * 0.5
		-- 				self.Owner:FireBullets(bul)
		-- 			end
		-- 		else
		-- 			if not NoRicochet[trace.MatType] then
		-- 				Dir2 = Dir2 + (trace.HitNormal * dot) * 3
		-- 				Dir2 = Dir2 + VectorRand() * 0.06
		-- 				bul.Num = 1
		-- 				bul.Src = trace.HitPos
		-- 				bul.Dir = Dir2
		-- 				bul.Spread 	= Vec0
		-- 				bul.Tracer	= 0
		-- 				bul.Force	= dmg * 0.75
		-- 				bul.Damage = bul.Damage * 0.75
						
		-- 				self.Owner:FireBullets(bul)
		-- 			end
		-- 		end
		-- 	end
		 end
		
		-- tr.mask = trace_normal
	//end
	
	vm = self.Owner:GetViewModel()
	dtint3 = self:GetDTInt(3)
	
	if self:GetDTInt(3) != 1 then
		if self.DryFireAnim and self:Clip1() == 0 then
			self:SendWeaponAnim(ACT_VM_DRYFIRE)
		else
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		end
		
		self.AnimPlayed = true
		vm:SetPlaybackRate(self.PlaybackRate or 1)
	else
		if not self.PlayFireAnim then
			if IsFirstTimePredicted() then
				self:VMRecoil()
			end
		end
		
		if self:GetClass():find("cstm_sniper_") then
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		else
			if not self.AnimPlayed or self.PlayFireAnim then
				if self.DryFireAnim and self:Clip1() == 0 then
					self:SendWeaponAnim(ACT_VM_DRYFIRE)
				else
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				end
		
				vm:SetPlaybackRate(self.PlaybackRate or 1)
				
				if not self.PlayFireAnim then
					vm:SetPlaybackRate(10)
				end
				
				self.AnimPlayed = true
			end
		end
	end
	
	if not self.dt.Sil then
		self.Owner:MuzzleFlash()								// Crappy muzzle light
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)				// 3rd Person Animation
	
	if ( self.Owner:IsNPC() ) then return end
end

function SWEP:VMRecoil()
	if CLIENT then
		self.RecoilAmt = self.DefRecoil * self:GetDTFloat(1)
		self.RecoilTime = CurTime() + 0.5
		self:MuzzleFlosh()
	end
		
	if SERVER and game.SinglePlayer() then
		SendUserMessage("RECOIL", self.Owner)
	end
end

function SWEP:Recoil(recoil)
	if ((game.SinglePlayer() && SERVER) || (!game.SinglePlayer() && CLIENT && IsFirstTimePredicted())) then
		eyeang = self.Owner:EyeAngles()
		eyeang.pitch = eyeang.pitch - (recoil * 0.5)
		eyeang.yaw = eyeang.yaw - (recoil * rand(-1, 1) * 0.25)
		self.Owner:SetEyeAngles(eyeang)
	end
end


/*---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
---------------------------------------------------------*/

local CurMul1 = 0
local CurMul2 = 0
local CurMul3 = 0
local CurMove = -2
local AmntToMove = 0.4
local MoveCycle = 0
local Ironsights_Time = 0.1
local CurShakeA = 0.03
local CurShakeB = 0.03
local randomdir = 0
local randomdir2 = 0
local timetorandom = 0
local BlendPos = Vector(0, 0, 0)
local BlendAng = Vector(0, 0, 0)
local Lean = 0
local ApproachRate = 0.2
local Off, Off2, Off3, dist = 0, 0, 0, 0
local Off4 = 0
local co, si, ta, ta2, ws, calc, calc2, speedclamp, len, ang1

function SWEP:GetViewModelPosition(pos, ang)
	CT = CurTime()
	
	if self.UseGoggle then
		if CT > self.TimeToUseGoggle then -- this is when the player is aiming through the scope of a sniper rifle and the scope overlay texture is displayed
			return pos - ang:Forward() * 50, ang
		end
	end
	
	FT = FrameTime()
	dtint3 = self:GetDTInt(3)
	mul = 0.35
	speedclamp = clamp(FT * 10, 0, 1)
	vel = self.Owner:GetVelocity()
	len = vel:Length()
	ong = self.Owner:OnGround()
	
	if dtint3 == 2 then
		vm = self.Owner:GetViewModel()
		activity = vm:GetSequenceActivityName(vm:GetSequence())
		cyc = vm:GetCycle()
		
		if (activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_EMPTY" or activity == "ACT_VM_RELOAD_SILENCED" or activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER") and (self.IsShotgun or cyc < 0.9) then
			if GetConVarNumber("cstm_different_origins") > 0 then
				if self.ViewModelFlip == true then
					TargetPos = self.FlipOriginsPos * 1
					TargetAng = self.FlipOriginsAng * 1
				else
					TargetPos = self.NoFlipOriginsPos * 1
					TargetAng = self.NoFlipOriginsAng * 1
				end
				
				Off = Lerp(clamp(FT * 10, 0, 1), Off, 0)
				Off2 = Lerp(clamp(FT * 10, 0, 1), Off2, 0)
				Off3 = Lerp(clamp(FT * 10, 0, 1), Off3, 0)
			else
				TargetPos = Vec0 * 1
				TargetAng = Vec0 * 1
			end
				
			RS = self.Owner:GetRunSpeed()
			calc = 7 + clamp(RS / 100, 0, 10)
			calc2 = RS / 200
					
			co = math.cos(CT * calc)
			si = math.sin(CT * calc)
			ta = math.atan(co, si)
			ta2 = math.atan(co * si, co * si)
			
			TargetAng.x = TargetAng.x + ta2 * 2 * calc2
			TargetAng.y = TargetAng.y + co * 2 * calc2
			TargetAng.z = TargetAng.z + si * 1.5 * calc2
			
			TargetPos.x = TargetPos.x + si * 0.5 * calc2
			TargetPos.y = TargetPos.y + ta2 * 0.8 * calc2
			TargetPos.z = TargetPos.z + co * si * 0.5 * calc2
		else
			if self.ViewModelFlip then
				TargetPos = (self.RunPos and self.RunPos or Vector(-0.82, -0.165, 0.2))
				TargetAng = (self.RunAng and self.RunAng or Vector(-9.754, -24.673, 0))
			else
				TargetPos = (self.RunPos and self.RunPos or Vector(-0.82, 0.165, 0.2))
				TargetAng = (self.RunAng and self.RunAng or Vector(-9.754, 24.673, 0))
			end
			
			RS = clamp(self.Owner:GetRunSpeed() / 100, 0, 10)
		
			Off = Lerp(speedclamp, Off, sin(CT * (7 + RS)))
			Off2 = Lerp(speedclamp, Off2, cos(CT * (7 + RS)))
			Off3 = Lerp(speedclamp, Off3, math.atan(Off, Off2))
		end
	elseif dtint3 == 1 then
		TargetPos = self.AimPos * 1
		TargetAng = self.AimAng * 1
		mul = 0.05
		ws = self.Owner:GetWalkSpeed()
		
		if len >= ws * 0.3 then
			TargetPos = TargetPos * 1
			TargetAng = TargetAng * 1
			
			calc = clamp((5 + ws / 100) / (self.Owner:Crouching() and 1.25 or 1), 0, 7) -- calc it once
			calc2 = ws / 250
			co = math.cos(CT * calc)
			si = math.sin(CT * calc)
			ta = math.atan(co, si)
			ta2 = math.atan(co * si, co * si)
			
			TargetAng.x = TargetAng.x + ta2 * 0.25
			TargetAng.y = TargetAng.y + co * 0.25
			TargetAng.z = TargetAng.z + si * 0.25
					
			TargetPos.x = TargetPos.x + si * 0.025
			TargetPos.y = TargetPos.y + ta2 * 0.04
			TargetPos.z = TargetPos.z + co * si * 0.025
			
			
		end
	elseif dtint3 == 6 then
		TargetPos = Vector(0, -0.82, -5)
		
		if self.ViewModelFlip then
			TargetAng = Vector(-25.247, -47.049, 0)
		else
			TargetAng = Vector(-25.247, 47.049, 0)
		end
	elseif dtint3 == 15 then
		if self.ViewModelFlip then
			TargetPos = self.MeleePos or Vec0
			TargetAng = self.MeleeAng or Vec0
		else
			TargetPos = self.MeleePosNoFlip or Vec0
			TargetAng = self.MeleeAngNoFlip or Vec0
		end
	elseif dtint3 == 19 then
		if self.ViewModelFlip then
			TargetPos = self.CustomizePos or Vector(-6.244, -1.658, -0.82)
			TargetAng = self.CustomizeAng or Vector(31.43, -35.975, -29.837)
		else
			TargetPos = self.CustomizePos or Vector(7.211, -6.475, 0.093)
			TargetAng = self.CustomizeAng or Vector(30.736, 40.668, 28.569)
		end
		
		ws = self.Owner:GetWalkSpeed()
		
		if len >= ws * 0.3 then
			TargetPos = TargetPos * 1
			TargetAng = TargetAng * 1
			
			calc = clamp((5 + ws / 100) / (self.Owner:Crouching() and 1.25 or 1), 0, 7) -- calc it once
			calc2 = ws / 250
						
			co = math.cos(CT * calc)
			si = math.sin(CT * calc)
			ta = math.atan(co, si) * 0.5
			ta2 = math.atan(co * si, co * si) * 0.5
					
			TargetAng.x = TargetAng.x + ta2 
			TargetAng.y = TargetAng.y + co
			TargetAng.z = TargetAng.z + si
						
			TargetPos.x = TargetPos.x + si * 0.25
			TargetPos.y = TargetPos.y + ta2 * 0.4
			TargetPos.z = TargetPos.z + co * si * 0.25
		else
			TargetPos = TargetPos * 1
			TargetAng = TargetAng * 1
			
			co = math.cos(CT)
			si = math.sin(CT)
			ta = math.atan(co, si)
			TargetPos.z = TargetPos.z + co * si * 0.2
			TargetPos.x = TargetPos.x - ta * 0.1
			TargetPos.y = TargetPos.y - co * si * 0.05
			TargetAng.z = TargetAng.z + ta * 0.5
		end
	else
		if self.Safe then
			if self:GetClass():find("cstm_pistol") then
				if self.ViewModelFlip then
					TargetPos = self.SafePos or Vector(-2.349, -8.492, -9.214)
					TargetAng = self.SafeAng or Vector(70, 0, 0)
				else
					TargetPos = self.SafePos or Vector(2.016, -4.961, -7.345)
					TargetAng = self.SafeAng or Vector(54.291, 0, 0)
				end
			else
				if self.ViewModelFlip then
					TargetPos = self.SafePos or Vector(-0.82, -0.165, 0.656)
					TargetAng = self.SafeAng or Vector(-9.754, -24.673, 0)
				else
					TargetPos = self.SafePos or Vector(-0.82, 0.165, 0.656)
					TargetAng = self.SafeAng or Vector(-9.754, 24.673, 0)
				end
			end
		else
			if GetConVarNumber("cstm_different_origins") > 0 then
				if self.ViewModelFlip == true then
					TargetPos = self.FlipOriginsPos
					TargetAng = self.FlipOriginsAng
				else
					TargetPos = self.NoFlipOriginsPos
					TargetAng = self.NoFlipOriginsAng
				end
			else
				TargetPos = Vec0 
				TargetAng = Vec0
			end
		end
		
		TargetPos = TargetPos * 1
		TargetAng = TargetAng * 1
		
		if ong then
			ws = self.Owner:GetWalkSpeed()
			
			if len >= ws * 0.3 then
				if dtint3 == 18 then
					RS = self.Owner:GetRunSpeed()
					calc = 7 + clamp(RS / 100, 0, 5)
					calc2 = RS / 200
					
					co = math.cos(CT * calc)
					si = math.sin(CT * calc)
					ta = math.atan(co, si)
					ta2 = math.atan(co * si, co * si)
				 
					TargetAng.x = TargetAng.x + ta2 * calc2
					TargetAng.y = TargetAng.y + co * calc2
					TargetAng.z = TargetAng.z + si * calc2
						 
					if self.Safe and self.SafeXMoveMod then
						TargetPos.x = TargetPos.x + si * 0.3 * calc2 * self.SafeXMoveMod
					else
						TargetPos.x = TargetPos.x + si * 0.3 * calc2
					end
					
					TargetPos.y = TargetPos.y + ta2 * 0.6 * calc2
					TargetPos.z = TargetPos.z + co * si * 0.3 * calc2
				else
					calc = clamp((5 + ws / 100) / (self.Owner:Crouching() and 1.25 or 1), 0, 7) -- calc it once
					calc2 = ws / 250
					
					co = math.cos(CT * calc)
					si = math.sin(CT * calc)
					ta = math.atan(co, si)
					ta2 = math.atan(co * si, co * si)
				
					TargetAng.x = TargetAng.x + ta2 
					TargetAng.y = TargetAng.y + co
					TargetAng.z = TargetAng.z + si
						
					if self.Safe and self.SafeXMoveMod then
						TargetPos.x = TargetPos.x + si * 0.25 * self.SafeXMoveMod
					else
						TargetPos.x = TargetPos.x + si * 0.25
					end
			
					TargetPos.y = TargetPos.y + ta2 * 0.4
					TargetPos.z = TargetPos.z + co * si * 0.25
				end
			else
				co = math.cos(CT)
				si = math.sin(CT)
				ta = math.atan(co * si, co * si)
				
				TargetAng.x = TargetAng.x + ta * 1.15
				TargetAng.y = TargetAng.y + co * 0.4
				TargetAng.z = TargetAng.z + si
					
				TargetPos.y = TargetPos.y + ta * 0.2
			end
		end
		
		if not self.Safe then
			EA = self.Owner:EyeAngles().p
			
			if EA > 0 then
				if self.ViewModelFlip then
					TargetPos.x = TargetPos.x - EA / 200
				else
					TargetPos.x = TargetPos.x + EA / 200
				end
			end
			
			TargetPos.z = TargetPos.z - EA / 100
			TargetPos.y = TargetPos.y + EA / 200
			
			if not ong then
				if self.Owner:GetMoveType() == MOVETYPE_WALK then
					TargetPos.z = TargetPos.z + clamp(vel.z / 300, -2, 1)
				end
			end
		
			TargetPos.z = clamp(TargetPos.z, -2, 1)
			
			if ong then
				if self.Owner:Crouching() or (ong and self.Owner:KeyDown(IN_DUCK)) then
					--self.BlendPos.y = self.BlendPos.y - 0.1
					--self.BlendPos.z = self.BlendPos.z + 0.1
				end
			end
		end
	end
	
	if dtint3 == 1 then
		ApproachRate = FT * 15
	elseif dtint3 == 6 or dtint3 == 7 then
		ApproachRate = Lerp(FT * 2, ApproachRate, FT * 4)
	elseif dtint3 == 15 then
		ApproachRate = Lerp(FT * 2, ApproachRate, FT * 30)
	else
		ApproachRate = Lerp(FT * 2, ApproachRate, FT * 7)
	end
	
	ApproachRate = clamp(ApproachRate, 0, 1)
	
	if dtint3 != 2 then
		Off = Lerp(clamp(FT * 5, 0, 1), Off, 0)
		Off2 = Lerp(clamp(FT * 5, 0, 1), Off2, 0)
		Off3 = Lerp(clamp(FT * 5, 0, 1), Off3, 0)
	end
	
	self.BlendPos = LerpVector(ApproachRate, self.BlendPos, TargetPos)
	self.BlendAng = LerpVector(ApproachRate, self.BlendAng, TargetAng)
	
	if dtint3 != 19 and dtint3 != 15 and not self.Safe then
		trace = self.Owner:GetEyeTrace()
		dist = trace.HitPos:Distance(self.Owner:GetShootPos())
		
		if dist <= 30 and trace.Entity:GetClass() != "prop_ragdoll" then
			Off4 = clamp(Lerp(speedclamp, Off4, 30 - dist), 0, 13)
			self.NearWall = true
		else
			Off4 = Lerp(speedclamp, Off4, 0)
			self.NearWall = false
		end
	else
		Off4 = Lerp(speedclamp, Off4, 0)
		self.NearWall = false
	end
	
	ang1 = (dtint3 == 1 and self.AngleDelta * 0.2) or self.AngleDelta

	if self.ViewModelFlip then
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		(Off3 - Off2) * 3 + self.BlendAng.x + ang1.p * 0.5 + Off4 * 3)
		ang:RotateAroundAxis( ang:Up(), 		(Off - Off2) * 10 + self.BlendAng.y)
		ang:RotateAroundAxis( ang:Forward(), 	(Off3 + (Off2 - Off)) * 5 + self.BlendAng.z + ang1.y * 0.3)
		
		pos = pos + (self.BlendPos.x - ang1.y * 0.1 - Off4 * 0.25) * ang:Right() 
		pos = pos + (self.BlendPos.y - Off - self.RecoilAmt * 1.5 - Off4 * 0.6) * ang:Forward()
		pos = pos + (self.BlendPos.z + (Off * Off2) * 0.75 - Off4 * 0.8) * ang:Up()
	else
		ang = ang * 1
		ang:RotateAroundAxis( ang:Right(), 		(Off3 - Off) * 3 + self.BlendAng.x + ang1.p * 0.5 + Off4 * 3)
		ang:RotateAroundAxis( ang:Up(), 		(Off - Off2) * 10 + self.BlendAng.y)
		ang:RotateAroundAxis( ang:Forward(), 	(Off3 + (Off2 - Off)) * 5 + self.BlendAng.z + ang1.y * 0.3)
		
		pos = pos + (self.BlendPos.x + ang1.y * 0.1 + Off4 * 0.25) * ang:Right() 
		pos = pos + ((self.BlendPos.y + Off - self.RecoilAmt * 1.5 - Off4 * 0.6) * ang:Forward())
		pos = pos + (self.BlendPos.z - ang1.p * 0.05 + (Off * Off2) * 0.5 - Off4 * 0.8) * ang:Up()
	end
	
	self.RecoilAmt = Lerp(clamp(FT * 10, 0, 1), self.RecoilAmt, 0)

	return pos, ang
end

if CLIENT then
	local b2, found, t
	local vcret, tid = vgui.Create, surface.GetTextureID
	local press = {times = 0, last = 0}
	
	function SWEP.PlayerBindPress(ply, b, p)
		if p then
			wep = ply:GetActiveWeapon()
			
			if not wep.IsCSTMWeapon or not wep:GetClass():find("cstm_") then
				return
			end
				
			if b == "+menu_context" then
				RunConsoleCommand("cstm_requestpimp")
				
				if wep:GetDTInt(3) != 19 then
					wep.WeaponOverview = false
					wep.Internal = false
				end
				
				return true
			else
				if b == "+use" then
					CT = CurTime()
					
					if CT < press.last then
						press.last = CT + 0.2
						press.times = press.times + 1
					else
						press.last = CT + 0.2
						press.times = 0
					end
					
					if press.times == 1 then
						if wep.CanUseBackUp then
							if wep:GetDTInt(3) == 1 then
								if wep:CanUseBackUp() then
									wep:UseBackUp()
								end
							end
						end
					end
				end
				
				if b == "+attack" and ply:KeyDown(IN_USE) then
					ply:ConCommand("cstm_melee")
					return true
				end
				
				dtint3 = wep:GetDTInt(3)
				
				if dtint3 == 19 then
					if b == "+attack" then
						if wep.InternalParts then
							wep.Internal = !wep.Internal
							
							for k, v in pairs(PAs) do
								if ValidPanel(v) then
									v:Remove()
								end
							end
							
							PAs = {}
						end
					end
					
					if b:find("slot") then
						if not wep.Internal then
							if wep.Attachments then
								b2 = tonumber(string.Right(b, 1))
								t = wep.Attachments[b2]
								
								if t then
									found = 0
									t.last = t.last or {}
									
									for k, v in pairs(t) do
										if not table.HasValue(t.last, v) then
											if table.HasValue(AttOnMe, v) then
												RunConsoleCommand("cstm_pimpmygun", CWAttachments[v].num)
												found = 2
												break
											end
										else
											found = 1
										end
									end
									
									if found == 1 then
										RunConsoleCommand("cstm_unpimpmygun", CWAttachments[t.last[#t.last]].num)
									end
									
									return true
								end
							end
						else
							if wep.InternalParts then
								b2 = tonumber(string.Right(b, 1))
								t = wep.InternalParts[b2]

								if t then
									found = 0
									t.last = t.last or {}
									
									for k, v in pairs(t) do
										if not table.HasValue(t.last, v.key) then
											if table.HasValue(PartOnMe, v.key) then
												RunConsoleCommand("cstm_addswag", CWInternalParts[v.key].num)
												found = 2
												break
											end
										else
											found = 1
										end
									end
									
									if found == 1 then
										RunConsoleCommand("cstm_removeswag", CWInternalParts[t.last[#t.last]].num)
									end
									
									return true
								end
							end
						end
					elseif b == "+reload" then
						if not wep.Internal then
							t = wep.AmmoTypes
							
							if t then
								found = false
								
								for k, v in pairs(t) do
									if table.HasValue(AmmoOnMe, v) then
										if not table.HasValue(wep.AmmoCycle, v) then
											RunConsoleCommand("cstm_selectammo", AmmoTypes[v].num)
											found = true
											break
										end
									end
								end
								
								if not found then
									RunConsoleCommand("cstm_deselectammo")
								end
							end
						end
					elseif b == "+use" then
						wep.WeaponOverview = !wep.WeaponOverview
					end
				elseif dtint3 == 1 then
					if b == "invnext" then
						if wep.VElements then
							t = wep.VElements["ballistic"]
							
							if t and t.color.a == 255 then
								if wep.TargetFOV != 1 then
									wep.TargetFOV = math.Approach(wep.TargetFOV, 1, 0.5)
									surface.PlaySound("weapons/zoom.wav")
								end
							end
						end
						
						return true
					elseif b == "invprev" then
						if wep.VElements then
							t = wep.VElements["ballistic"]
							
							if t and t.color.a == 255 then
								if wep.TargetFOV != 3 then
									wep.TargetFOV = math.Approach(wep.TargetFOV, 3, 0.5)
									surface.PlaySound("weapons/zoom.wav")
								end
							end
						end
						
						return true
					end
				end
			end
		end
	end
	
	hook.Add("PlayerBindPress", "SWEP.PlayerBindPress (CSTM)", SWEP.PlayerBindPress)
	
	function SWEP:DoImpactEffect(trace, dmgtype)
		if not self.Em then
			self.Em = ParticleEmitter(Vec0)
		end
		
		if self:GetDTInt(2) != 1 then
			return
		end
		
		ent = trace.Entity
		
		if IsValid(ent) then
			if ent:GetPos():Distance(self.Owner:GetPos()) <= self.EffectiveRange / 2 then
				dlight = DynamicLight(self.Owner:EntIndex())
				dlight.Pos = trace.HitPos
				dlight.r = 255
				dlight.g = 170
				dlight.b = 0
				dlight.Brightness = 1
				dlight.Size = 128
				dlight.Decay = 512
				dlight.DieTime = CurTime() + 0.2
				ParticleEffect("cstm_incendiary_hit", trace.HitPos, trace.HitNormal:Angle(), nil)
			end
		else
			if trace.HitPos:Distance(self.Owner:GetPos()) <= self.EffectiveRange / 2 then
				dlight = DynamicLight(self.Owner:EntIndex())
				dlight.Pos = trace.HitPos
				dlight.r = 255
				dlight.g = 170
				dlight.b = 0
				dlight.Brightness = 1
				dlight.Size = 128
				dlight.Decay = 512
				dlight.DieTime = CurTime() + 0.2
				ParticleEffect("cstm_incendiary_hit", trace.HitPos, trace.HitNormal:Angle(), nil)
			end
		end
	end
	
	local add, entry

	function SWEP:AdjustMouseSensitivity()
		if self:GetDTBool(1) then
			add = 0.25
		else
			add = 0
		end
		
		if self:GetDTInt(3) == 1 then
			if self.VElements then
				entry = self.VElements["elcan"]
				
				if entry and entry.color.a == 255 then
					if self.AimPos == self.ELCANPos then
						return GetConVarNumber("cstm_aim_sensitivity_elcan") * self.Owner:GetFOV() * (1 - add) * self.OverallMouseSensMod
					end
				else
					entry = self.VElements["acog"]
					
					if entry and entry.color.a == 255 then
						if self.AimPos == self.ACOGPos then
							return GetConVarNumber("cstm_aim_sensitivity_acog") * self.Owner:GetFOV() * (1 - add) * self.OverallMouseSensMod
						end
					else
						entry = self.VElements["ballistic"]
						
						if entry and entry.color.a == 255 then
							return GetConVarNumber("cstm_aim_sensitivity_ballistic") * self.CurFOV * 3 * (1 - add) * self.OverallMouseSensMod
						end
					end
				end
			end
			
			return GetConVarNumber("cstm_aim_sensitivity") * self.Owner:GetFOV() * (1 - add) * self.OverallMouseSensMod
		else
			return 1 * add * self.OverallMouseSensMod
		end
	end
	
	function SWEP:MuzzleFlosh() -- lololol
		if not IsValid(self.Owner) then
			return
		end
			
		vm = self.Owner:GetViewModel()
		
		if not IsValid(vm) then
			return
		end
		
		muz = vm:GetAttachment("1")
		muz2 = vm:LookupAttachment((self.AttachmentName and self.AttachmentName or "1"))
		
		if muz then
			if not self.Em then
				self.Em = ParticleEmitter(muz.Pos)
			end

			if GetConVarNumber("cstm_ef_smoke") > 0 then
				ParticleEffect(self.SmokeEffect or "cstm_child_smoke_small", muz.Pos, self.Owner:EyeAngles(), muz)
			end
		end
				
		if self.dt.Sil then
			return
		end
		
		if (self.VElements and self.VElements["silencer"] != nil and self.Owner:GetActiveWeapon().VElements["silencer"].color.a != 255) or self.VElements and self.VElements["silencer"] == nil then -- I check if it's not nil and then if it's nil to ensure that weapons that don't have a silencer don't bug
			
			if muz then
				if GetConVarNumber("cstm_ef_heat") > 0 then
					local par = self.Em:Add("sprites/heatwave", muz.Pos)
					par:SetStartSize(4)
					par:SetEndSize(1)
					par:SetDieTime(0.3)
				end
			end
			
			if muz2 then			
				if GetConVarNumber("cstm_ef_extramuzzle") > 0 then
					ParticleEffectAttach(self.Muzzle or "cstm_muzzle_pistol", PATTACH_POINT_FOLLOW, vm, muz2)
				end
						
				if GetConVarNumber("cstm_ef_sparks") > 0 then
					ParticleEffectAttach(self.SparkEffect or "cstm_child_sparks_small", PATTACH_POINT_FOLLOW, vm, muz2)
				end
			end
	
		end
	end

	function SWEP:FireAnimationEvent(pos, ang, ev)
		if ev == 5001 or ev == 21 then
			if not self.Owner:ShouldDrawLocalPlayer() then
				self:MuzzleFlosh()
				
				if self.dt.Sil then
					return true
				end
			end
		end
	end
	
	local tid, tex, clr, rect, orect, trect, trectuv, trectrot = surface.GetTextureID, surface.SetTexture, surface.SetDrawColor, surface.DrawRect, surface.DrawOutlinedRect, surface.DrawTexturedRect, surface.DrawTexturedRectUV, surface.DrawTexturedRectRotated
	
	local gap = 5
	local gap2 = 0
	local CurAlpha_Weapon = 255
	local BipodAlpha = 0
	local ScopeTexture = tid("gcellmats/scope_rifle2")
	local GLTexture = tid("sprites/crosshair_gl")
	local UseGoggle = false
	local Bullet = tid("VGUI/bullet")
	local Bipod_Active = tid("VGUI/bipod_active")
	local M203_Active = tid("VGUI/m203_active")
	local XA, YA, CH, bipod, add, tclr, g
	local Gradient, round = surface.GetTextureID("VGUI/gradient"), surface.GetTextureID("round2")
	local rad = math.rad
	local C = {}
	local dclr, dclr2 = Color(255, 255, 255, 255), Color(255, 255, 255, 255)
	local A, AMT = 0, 0
	local ch, ca = 100, 0
	local hp, arm, size, hipsp, maxsp, incsp, movesp, addy

	C.White = Color(255, 255, 255, 255)
	C.Black = Color(0, 0, 0, 255)
	C.Green = Color(182, 255, 116, 255)
	C.Red = Color(255, 84, 81, 255)
	
	function SWEP:DrawHUDElements(x, y, FT)
		CH = GetConVarNumber("cstm_hud_ammo")
		add = 0
		
		vm = self.Owner:GetViewModel()
		cyc = vm:GetCycle()
		activity = vm:GetSequenceActivityName(vm:GetSequence())
		

		bipod = self:GetDTBool(1)
		speedclamp = clamp(FT * 15, 0, 1)
		
		if bipod or self.Grenade then
			BipodAlpha = Lerp(speedclamp, BipodAlpha, 150)
		else
			BipodAlpha = Lerp(speedclamp, BipodAlpha, 0)
		end
		
		if self.Grenade and BipodAlpha > 5 then
			if CH > 0 then
				clr(0, 0, 0, BipodAlpha * 1.333)
				tex(Gradient)
				trect(x - 348, y - 188 - add, 256, 30)
			
				clr(0, 0, 0, BipodAlpha)
				tex(M203_Active)
				trect(x - 145, y - 198 - add, 48, 48)
				
				clr(255, 255, 255, BipodAlpha * 1.7)
				trect(x - 146, y - 198 - add, 48, 48)
				add = add + 35
			else
				clr(0, 0, 0, 150)
				tex(M203_Active)
				trect(x * 0.5 - 25, y - 132, 48, 48)
				
				clr(255, 210, 0, 150)
				trect(x * 0.5 - 24, y - 132, 48, 48)
			end
		end
		
		if bipod and BipodAlpha > 5 then
			if CH > 0 then
				clr(0, 0, 0, BipodAlpha * 1.333)
				tex(Gradient)
				trect(x - 348, y - 208 - add, 256, 50)
				
				clr(0, 0, 0, BipodAlpha)
				tex(Bipod_Active)
				trect(x - 140, y - 208 - add, 48, 48)
				
				clr(255, 255, 255, BipodAlpha * 1.7)
				trect(x - 141, y - 208 - add, 48, 48)
				add = add + 55
			else
				clr(0, 0, 0, BipodAlpha)
				tex(Bipod_Active)
				trect(x * 0.5 - 25, y - 132, 48, 48)
				
				clr(255, 210, 0, BipodAlpha)
				trect(x * 0.5 - 24, y - 132, 48, 48)
			end
		end
		
		dtint3 = self:GetDTInt(3)
		
		if dtint3 == 19 then
			if not self.WeaponOverview then 
				hipsp, maxsp, incsp, movesp, addy = 1, 1, 1, 1, 0
				
				clr(0, 0, 0, 200)
				surface.SetTexture(Gradient)
				
				if self.ClumpSpread and self.ClumpSpread > 0 then
					addy = addy + 15
				end
				
				trect(x - 342, y - 348 - addy - add, 250, 40 + addy)
				trect(x - 342, y - 379 - addy - add, 250, 26)
				
				draw.BlurredText("[E] - Toggle weapon overview",  "BROOP_26", "BROOP_26Blur", x - 100, y - 368 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				
				-- if wep.InternalParts then
					-- trect(x - 342, y - 410 - addy - add, 250, 26)
					-- draw.BlurredText("[LMB] - " .. (wep.Internal and " Customize attachments" or " Customize internal parts"),  "BROOP_26", "BROOP_26Blur", x - 100, y - 399 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				if self:IsActiveCModel("laser") then
					hipsp = hipsp - 0.6
					movesp = movesp - 0.3
					incsp = incsp - 0.15
				end
				
				if self:IsActiveCModel("vertgrip") then
					movesp = movesp - 0.35
				end

				draw.BlurredText(self.PrintName,  "BROOP_20", "BROOP_20Blur", x - 100, y - 338 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				draw.BlurredText("Caliber: " .. self.Primary.Ammo,  "BROOP_16", "BROOP_16Blur", x - 100, y - 318 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				
				-- if self.SilenceTextOverride then
					-- draw.BlurredText(self.SilenceTextOverride,  "BROOP_16", "BROOP_16Blur", x - 100, y - 303 - add - addy, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- if self.CantSilence then
						-- draw.BlurredText("Not suppressable",  "BROOP_16", "BROOP_16Blur", x - 100, y - 303 - add - addy, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
					-- else
						-- draw.BlurredText("Supports a suppressor",  "BROOP_16", "BROOP_16Blur", x - 100, y - 303 - add - addy, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
					-- end
				-- end
				
				-- if self.Primary.Damage > self.Primary.Damage_Orig then
					-- draw.BlurredText("Damage: " .. self.Primary.Damage .. "x" .. self.Primary.NumShots,  "BROOP_16", "BROOP_16Blur", x - 100, y - 288 - add - addy, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.Primary.Damage < self.Primary.Damage_Orig then
					-- draw.BlurredText("Damage: " .. self.Primary.Damage .. "x" .. self.Primary.NumShots,  "BROOP_16", "BROOP_16Blur", x - 100, y - 288 - add - addy, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Damage: " .. self.Primary.Damage .. "x" .. self.Primary.NumShots,  "BROOP_16", "BROOP_16Blur", x - 100, y - 288 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.Primary.Delay < self.Primary.Delay_Orig then
					-- draw.BlurredText("Rate of fire: " .. math.Round(60 / self.Primary.Delay) .. " RPM",  "BROOP_16", "BROOP_16Blur", x - 100, y - 273 - add - addy, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.Primary.Delay > self.Primary.Delay_Orig then
					-- draw.BlurredText("Rate of fire: " .. math.Round(60 / self.Primary.Delay) .. " RPM",  "BROOP_16", "BROOP_16Blur", x - 100, y - 273 - add - addy, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Rate of fire: " .. math.Round(60 / self.Primary.Delay) .. " RPM",  "BROOP_16", "BROOP_16Blur", x - 100, y - 273 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end

				-- if self.HipCone > self.HipCone * hipsp then
					-- draw.BlurredText("Hip accuracy: " .. math.Clamp(math.Round(100 - self.HipCone * 1000 * hipsp, 2), 0, 80) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 258 - add - addy, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.HipCone < self.HipCone * hipsp then
					-- draw.BlurredText("Hip accuracy: " .. math.Clamp(math.Round(100 - self.HipCone * 1000 * hipsp, 2), 0, 80) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 258 - add - addy, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Hip accuracy: " .. math.Clamp(math.Round(100 - self.HipCone * 1000 * hipsp, 2), 0, 80) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 258 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.IronsightsCone > self.IronsightsCone_Orig then
					-- draw.BlurredText("Aimed accuracy: " .. math.Round(100 - (self.IronsightsCone and self.IronsightsCone or self.DefCone) * 1000, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 243 - add - addy, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.IronsightsCone < self.IronsightsCone_Orig then
					-- draw.BlurredText("Aimed accuracy: " .. math.Round(100 - (self.IronsightsCone and self.IronsightsCone or self.DefCone) * 1000, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 243 - add - addy, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Aimed accuracy: " .. math.Round(100 - (self.IronsightsCone and self.IronsightsCone or self.DefCone) * 1000, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 243 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.ClumpSpread and self.ClumpSpread > 0 then
					-- draw.BlurredText("Clump spread: " .. math.Round(self.ClumpSpread * 1000, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 228 - add - addy, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.VelocitySensivity > self.VelocitySensivity * movesp then
					-- draw.BlurredText("Movement sensitivity: " .. math.Round(self.VelocitySensivity * 100 * movesp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 228 - add, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.VelocitySensivity < self.VelocitySensivity * movesp then
					-- draw.BlurredText("Movement sensitivity: " .. math.Round(self.VelocitySensivity * 100 * movesp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 228 - add, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Movement sensitivity: " .. math.Round(self.VelocitySensivity * 100 * movesp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 228 - add, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.Primary.Recoil > self.DefRecoil then
					-- draw.BlurredText("Recoil: " .. self.RecoilDisplay .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 213 - add, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.Primary.Recoil < self.DefRecoil then
					-- draw.BlurredText("Recoil: " .. self.RecoilDisplay .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 213 - add, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Recoil: " .. self.RecoilDisplay .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 213 - add, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.ConeInaccuracyAff1_Orig > self.ConeInaccuracyAff1 * maxsp then
					-- draw.BlurredText("Maximum spread increase: " .. math.Round(self.ConeInaccuracyAff1 * 100 * maxsp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 198 - add, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.ConeInaccuracyAff1_Orig < self.ConeInaccuracyAff1 * maxsp then
					-- draw.BlurredText("Maximum spread increase: " .. math.Round(self.ConeInaccuracyAff1 * 100 * maxsp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 198 - add, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Maximum spread increase: " .. math.Round(self.ConeInaccuracyAff1 * 100 * maxsp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 198 - add, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.Primary.Recoil * self.InaccAff1 > self.DefRecoil * self.InaccAff1 * incsp then
					-- draw.BlurredText("Spread per shot: +" .. math.Round(self.DefRecoil * self.InaccAff1 * 10 * incsp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 183 - add, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.Primary.Recoil * self.InaccAff1 < self.DefRecoil * self.InaccAff1 * incsp then
					-- draw.BlurredText("Spread per shot: +" .. math.Round(self.DefRecoil * self.InaccAff1 * 10 * incsp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 183 - add, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Spread per shot: +" .. math.Round(self.DefRecoil * self.InaccAff1 * 10 * incsp, 2) .. "%",  "BROOP_16", "BROOP_16Blur", x - 100, y - 183 - add, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
				
				-- if self.PenStr > self.PenStr * self.PenMod then
					-- draw.BlurredText("Penetrative effectiveness: " .. math.Round(self.PenStr / 39.37 * self.PenMod, 2) .. "M",  "BROOP_16", "BROOP_16Blur", x - 100, y - 168 - add, 1, C.Red, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- elseif self.PenStr < self.PenStr * self.PenMod then
					-- draw.BlurredText("Penetrative effectiveness: " .. math.Round(self.PenStr / 39.37 * self.PenMod, 2) .. "M",  "BROOP_16", "BROOP_16Blur", x - 100, y - 168 - add, 1, C.Green, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- else
					-- draw.BlurredText("Penetrative effectiveness: " .. math.Round(self.PenStr / 39.37 * self.PenMod, 2) .. "M",  "BROOP_16", "BROOP_16Blur", x - 100, y - 168 - add, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				-- end
			end
		end
		
		if self.Bullets then
			if CH > 0 then
				Text = self.FireModeNames[self.FireMode].n .. " " .. self.Primary.Ammo
				draw.BlurredText(Text, "BROOP_20", "BROOP_20Blur", x - 100, y - 75, 1, C.White, C.Black, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
				
				surface.SetFont("BROOP_20")
				XA, YA = surface.GetTextSize(Text)
				
				clr(0, 0, 0, 255)			
				tex(Bullet)
				
				for i = 1, self.Bullets do
					trectrot(x - 94 - 24 * i - XA, y - 73, 20, 20, 180)
				end
				
				clr(255, 255, 255, 255)	
				
				for i = 1, self.Bullets do
					trectrot(x - 95 - 24 * i - XA, y - 74, 20, 20, 180)
				end	
			else
				Text = self.FireModeNames[self.FireMode].n
				
				draw.RoundedBox(0, x * 0.5 - 60, y - 85, 120, 30, Color(0, 0, 0, 220))
				draw.SimpleText(Text, "VBFONT_InventoryTiny", x * 0.5, y - 75, C.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)	

				clr(255, 210, 0, 255)			
				tex(Bullet)
				
				for i = 1, self.Bullets do
					trectrot(x * 0.5 + 20 * i - (10 + self.Bullets * 10), y - 65, 16, 16, 180)
				end
				
				--draw.SimpleText((self.Owner.FuseTime and self.Owner.FuseTime or 3) .. " SEC", "Default12", x * 0.5, y - 50, C.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end	
	end
	
	local tp
	local ClumpSpread = surface.GetTextureID("VGUI/clumpspread_ring")

	function SWEP:DrawHUD()
		FT = RealFrameTime()
		Width = ScrW()
		Height = ScrH()
		self:DrawHUDElements(Width, Height, FT)
		
		x2 = (Width - 1024) / 2
		y2 = (Height - 1024) / 2
		x3 = Width - x2
		y3 = Height - y2
		tp = self.Owner:ShouldDrawLocalPlayer()
		
		if (self.Owner == LocalPlayer() && tp) then
			tr = util.GetPlayerTrace( self.Owner )
			tr.mask = {CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX}
			trace = util.TraceLine(tr)
			
			coords = trace.HitPos:ToScreen()
			x, y = coords.x, coords.y
		else
			x, y = Width / 2.0, Height / 2.0
		end
		
		vm = self.Owner:GetViewModel()
		
		if tp then
			CurAlpha_Weapon = app(CurAlpha_Weapon, 255, FT / 0.001)
		else
			if dtint3 == 2 or dtint3 == 4 or dtint3 == 19 or dtint3 == 6 or self.Safe or (vm:GetSequenceActivityName(vm:GetSequence()):find("ACT_VM_RELOAD") and vm:GetCycle() < 0.9) or self.NearWall then
				CurAlpha_Weapon = app(CurAlpha_Weapon, 0, FT / 0.001)
			elseif (dtint3 == 1 and self.NoProperIronsights != true) or (dtint3 == 1 and self.HasInstalledScope == true) then
				CurAlpha_Weapon = app(CurAlpha_Weapon, 0, FT / 0.001)
			elseif dtint3 == 0 or dtint3 == 3 or dtint3 == 18 then
				CurAlpha_Weapon = app(CurAlpha_Weapon, 255, FT / 0.001)
			end
		end
		
		if self.ClumpSpread then
			if GetConVarNumber("cstm_spreaddisplay") > 0 then
				size = math.ceil(self.ClumpSpread * 2500)
				clr(0, 0, 0, CurAlpha_Weapon)
				tex(ClumpSpread)
				trect(Width / 2 - size * 0.5 - 1, Height / 2 - size * 0.5 - 1, size + 2, size + 2)
				
				clr(255, 255, 255, CurAlpha_Weapon)
				trect(Width / 2 - size * 0.5, Height / 2 - size * 0.5, size, size)
			end
		end
		
		-- if not self.DisableCrosshair then
			-- scale = (7 / (self.Owner:GetFOV() / 90)) * self:GetDTFloat(0)
			-- gap = Lerp(0.25, gap, scale * 50)
			-- gap = math.Round(gap)
			-- gap2 = GetConVarNumber("cstm_dynamiccrosshair") > 0 and math.Round(gap * 0.2) or 0
		
			-- if dtint3 != 8 then
				-- out_r = GetConVarNumber("cstm_out_r")
				-- out_g = GetConVarNumber("cstm_out_g")
				-- out_b = GetConVarNumber("cstm_out_b")
				-- out_a = GetConVarNumber("cstm_out_a")
				
				-- in_r = GetConVarNumber("cstm_in_r")
				-- in_g = GetConVarNumber("cstm_in_g")
				-- in_b = GetConVarNumber("cstm_in_b")
				-- in_a = GetConVarNumber("cstm_in_a")
				
				-- cl = GetConVarNumber("cstm_crosslength")
				
				-- if GetConVarNumber("cstm_leftcross") > 0 then
					-- clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
					-- rect(x - 3 - gap2 - cl - gap, y - 1, cl + 2 + gap2, 3)
					-- clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
					-- rect(x - 2 - gap2 - cl - gap, y, cl + gap2, 1)
				-- end
				
				-- if GetConVarNumber("cstm_rightcross") > 0 then
					-- clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
					-- rect(x + 2 + gap, y - 1, cl + 2 + gap2, 3)
					-- clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
					-- rect(x + 3 + gap, y, cl + gap2, 1)
				-- end
				
				-- if GetConVarNumber("cstm_lowercross") > 0 then
					-- clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
					-- rect(x - 1, y + 2 + gap, 3, cl + 2 + gap2)
					-- clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
					-- rect(x, y + 3 + gap, 1, cl + gap2)
				-- end
				
				-- if GetConVarNumber("cstm_uppercross") > 0 then
					-- clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
					-- rect(x - 1, y - cl - gap2 - 3 - gap, 3, cl + 2 + gap2)
					-- clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
					-- rect(x, y - cl - gap2 - 2 - gap, 1, cl + gap2)
				-- end
			-- else
				-- clr(255, 255, 255, 255)
				-- tex(GLTexture)
				-- trect(Width / 2 - 32, Height / 2, 64, 64)
			-- end
		-- end
	end
	
	function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
		if self.DifType then
			clr(255, 210, 0, 255)
			tex(self.WepSelectIcon)
			trect(x + 56, y, 128, 128)
		else
			draw.SimpleText( self.IconLetter, "CSSelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
		end
	end
end

local HideModel = false

function SWEP:SecondaryAttack()
	if self.FireMode == "safe" then
		return
	end
	
	if self.ReloadTime then
		return
	end
	
	dtint3 = self:GetDTInt(3)
	
	if self.Owner:KeyDown(IN_WALK) then
		if dtint3 == 0 then
			if SERVER then
				self:SetFuseTime()
			end
			
			return
		end
	end
	
	trace = self.Owner:GetEyeTrace()
	
	if trace.HitPos:Distance(self.Owner:GetShootPos()) < 30 and trace.Entity:GetClass() != "prop_ragdoll" then
		return
	end
	
	if dtint3 == 2 or dtint3 == 18 or dtint3 == 19 or not self.Owner:OnGround() or self.Owner:KeyDown(IN_SPEED) or self.ShouldBolt == true then
		return
	end
	
	CT = CurTime()
	
	if self.SecondaryAtt == 1 and self.Owner:KeyDown(IN_USE) and dtint3 != 8 and dtint3 != 1 then
		if SERVER then
			if self.Grenade == false then
				self.Owner:EmitSound("weapons/shotgun/shotgun_empty.wav", 65, rand(99, 101))
				self.Grenade = true
				
				SendUserMessage("M203_ON", self.Owner) -- more reliable via UMSGS
			else
				self.Owner:EmitSound("weapons/ClipEmpty_Rifle.wav", 65, rand(99, 101))
				self.Grenade = false
				
				SendUserMessage("M203_OFF", self.Owner)
			end
		end
		
		self:SetNextPrimaryFire(CT + 0.1)
		self:SetNextSecondaryFire(CT + 0.1)
		return
	end
	
	if (dtint3 == 0 or dtint3 == 3 or dtint3 == 7) then
		if not self.CanAimWithRail and self.HasRail and self.ScopeStatus == 0 and self.RequiresRail then
			return
		end
	
		if self.Grenade then
			self:SetDTInt(3, 8)
		else
			self:SetDTInt(3, 1)
		end
		
		if SERVER then
			if self.ScopeStatus >= 1 and not self.Grenade then
				self.Owner:SetFOV(90 - self.FOVMod, 0.3)
			else
				self.Owner:SetFOV(self.FOVZoom and self.FOVZoom or 75, 0.3)
			end
		end
	elseif dtint3 == 1 or dtint3 == 8 then
		self:SetDTInt(3, 0)
		
		if SERVER then
			self.Owner:SetFOV(0, 0.3)
			self.Owner:DrawViewModel(true)
		end
	end
	
	self:SetNextPrimaryFire(CT + 0.2)
end

function SWEP:OnRestore()
	self:SetDTInt(3, 0)
end

function SWEP:ThrowGrenade()
	CT = CurTime()
	
	if self.Owner:GetShootPos():Distance(self.Owner:GetEyeTrace().HitPos) <= 30 then
		self:EmitSound("weapons/cstm/holster" .. math.random(1, 4) .. ".wav", 65, 100)
		self:SetDTInt(3, 0)
		self.CookTime = nil
		self.Cooking = false
		self:SetNextPrimaryFire(CT + 0.2)
		self:SetNextSecondaryFire(CT + 0.2)
		self.ReloadDelay = CT + 0.2
		self.HolsterTime = CT + 0.2
		
		return
	end
	
	SendUserMessage("CSTM_QUICKNADE2", self.Owner)

	timer.Simple(0.15, function()
		if not IsValid(self) or not IsValid(self.Owner) or not self.Owner:Alive() then
			return
		end
			
		self.Owner:RemoveAmmo(1, "Grenade")
		
		if IsValid(self.Owner) and IsValid(self) and self == self.Owner:GetActiveWeapon() then
			EA =  self.Owner:EyeAngles()
			pos = self.Owner:GetShootPos()
			pos = pos - EA:Right() * 5 - EA:Up() * 4 + EA:Forward() * 4

			nade = ents.Create("cstm_grenade")
			nade:SetPos(pos)
			nade:SetAngles(Angle(math.random(0, 360), math.random(0, 360), math.random(0, 360)))
			nade:Spawn()
			nade:Activate()
			nade:SetOwner(self.Owner)
			nade:Fuse(self.CookTime - CT)

			phys = nade:GetPhysicsObject()

			if IsValid(phys) then
				force = 1000

				if self.Owner:KeyDown(IN_FORWARD) and ong then
					force = force + vel
				end

				phys:SetVelocity(EA:Forward() * force + Vector(0, 0, 100))
				phys:AddAngleVelocity(Vector(math.random(-500, 500), math.random(-500, 500), math.random(-500, 500)))
			end

			self.CookTime = nil
		end
	end)

	timer.Simple(0.75, function()
		if not IsValid(self) or not IsValid(self.Owner) or not self.Owner:Alive() then
			return
		end
		
		self:EmitSound("weapons/cstm/holster" .. math.random(1, 4) .. ".wav", 65, 100)
		self:SetDTInt(3, 0)
	end)

	self:SetNextPrimaryFire(CT + 1.05)
	self:SetNextSecondaryFire(CT + 1.05)
	self.ReloadDelay = CT + 1.05
	self.HolsterTime = CT + 1.05
	self.Cooking = false
end