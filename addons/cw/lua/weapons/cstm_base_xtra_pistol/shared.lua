SWEP.Base = "cstm_base_pistol"

if (SERVER) then

	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
	SWEP.ScopeStatus = 0
	SWEP.RequiresRail = false

end

if ( CLIENT ) then
	SWEP.ActToCyc = {}
	SWEP.ActToCyc["ACT_VM_DRAW"] = 0.45
	SWEP.ActToCyc["ACT_VM_DRAW_SILENCED"] = 0.45
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.9
	SWEP.ActToCyc["ACT_VM_RELOAD_SILENCED"] = 0.9
	SWEP.ActToCyc["ACT_VM_ATTACH_SILENCER"] = 0.8
	SWEP.ActToCyc["ACT_VM_DETACH_SILENCER"] = 0.8
	
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
	SWEP.DrawWeaponInfoBox  = true
	SWEP.HasInstalledScope  = false
	SWEP.PitchMod = 1
	SWEP.RollMod = 1
	SWEP.Lasers = {}
	
	language.Add("striderminigun_ammo", "7.62x39MM Ammo")
	language.Add("combinecannon_ammo", ".50AE Ammo")
	language.Add("airboatgun_ammo", "5.56x45MM NATO Ammo")
	language.Add("sniperround_ammo", ".338 Lapua Magnum Ammo")
	language.Add("sniperpenetratedround_ammo", "7.62x51MM NATO Ammo")
	language.Add("alyxgun_ammo", "5.7x28MM Ammo")
	language.Add("helicoptergun_ammo", ".45 ACP Ammo")
	language.Add("gaussenergy_ammo", "9x39MM Ammo")
	language.Add("gravity_ammo", "9x18MM Ammo")
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
SWEP.Category = "Extra Pack"

 Vector(-3.587, -11.735, -0.438)
 Vector(0, -70, 0)

 Vector(0.328, -10.82, -4.621)
 Vector(70, 0, 0)

 Vector(3.443, -10.164, 0)
 Vector(0, 70, 0)

SWEP.FlipOriginsPos = Vector(3.305, -1.968, 0.735)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

SWEP.NoFlipOriginsPos = Vector(-2.25, 0, -0.695)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

SWEP.ConeInaccuracy = 0
SWEP.ConeInaccuracyDec = 0
SWEP.SilencedSound = Sound("weapons/usp/usp1.wav")
SWEP.SilencedVolume = 70

local Vec0 = Vector(0, 0, 0)

local CT, clip, mul, ply, wep, sequence, seqdur, activity, bone, matrix, m, AimVec, AvailableReload, AmountToReload, DTInt3, v, model, sprite, pos, ang, drawpos, td, trace, dir, lt, fw, aim, CamData, old, bullet, eyeang, muz, dtint3, par, fov, ScopeStatus, sp, can, wc, cyc, vm
local destr, tsim, tcret, app, clamp, sin, cos, rand, rand2 = timer.Destroy, timer.Simple, timer.Create, math.Approach, math.Clamp, math.sin, math.cos, math.random, math.Rand
local td = {}

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
	
	vm = self.Owner:GetViewModel()

	if self.Owner:KeyDown(IN_WALK) and dtint3 != 1 then
		if self.CantSilence == true then
			return
		end
	
		if not self.dt.Sil then
			if SERVER then
				self:SendWeaponAnim(ACT_VM_ATTACH_SILENCER)
				seqdur = vm:SequenceDuration()
				self:SetNextPrimaryFire(CT + seqdur - 0.2)
				self:SetNextSecondaryFire(CT + seqdur - 0.2)
				
				tsim(1, function()
					if not IsValid(self) then
						return
					end
					
					self.dt.Sil = true
					self.IdleAnim = ACT_VM_IDLE_SILENCED
				end)
				
			end
			
		else
			if SERVER then
				self:SendWeaponAnim(ACT_VM_DETACH_SILENCER)
				seqdur = vm:SequenceDuration()
				self:SetNextPrimaryFire(CT + seqdur - 0.2)
				self:SetNextSecondaryFire(CT + seqdur - 0.2)
				
				tsim(1, function()
					if not IsValid(self) then
						return
					end
					
					self.dt.Sil = false
					self.IdleAnim = ACT_VM_IDLE
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

function SWEP:Deploy()
	if self.dt.Sil then
		self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	else
		self:SendWeaponAnim(ACT_VM_DRAW)
	end
	
	if not self.Owner.FuseTime then
		self.Owner.FuseTime = 3
	end

	CT = CurTime()
	
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
			SendUserMessage("DOVMSTUFF", self.Owner)
		end
	end
	
	if CLIENT then
		self:MakeBoneMods()
	end
	
	self:SetDTInt(3, 0)
	self.HolsterStatus = 0
	
	return true
end

local vel, ong, force

function SWEP:Think()
	CT = CurTime()
	wc = self:GetClass()
	DTInt3 = self:GetDTInt(3)
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
		
		if DTInt3 == 1 then
			self.ConeDecAff2 = 0.0045
			self.RecoilAff1 = 0.3
			
			self.CurCone = self.IronsightsCone / GetConVarNumber("cstm_accuracymod_aim") * (self.dt.Sil and 0.9 or 1)
		elseif DTInt3 == 17 then
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
					
					td.start = sp
					td.endpos = td.start + Vector(AimVec.x, AimVec.y, AimVec.z * 0.1 - 1.25) * 25
					td.filter = self.Owner
					
					trace = util.TraceLine(td)
					
					if trace.Hit and trace.HitPos.z > self.Owner:GetPos().z + 2 then -- make sure we have something to place the bipod on and we're not placing the bipod on something lower than our standing position
						ent = trace.Entity
						
						if not ent:IsPlayer() and not ent:IsNPC() then
							td.start = sp - Vector(0, 0, 10)
							td.endpos = td.start + AimVec * 30
							td.filter = self.Owner
							
							trace = util.TraceLine(td)
							
							if not trace.Hit then -- make sure the bipod is not gonna hit something below your crosshair
								td.start = sp 
								td.endpos = td.start + AimVec * 30
								td.filter = self.Owner
								
								trace = util.TraceLine(td)
								
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
	
		self.Primary.Cone = clamp((self.CurCone + self.ConeInaccuracy + ((vel / 10000) * (DTInt3 == 1 and self.VelocitySensivity * 0.3 or self.VelocitySensivity)) - self.ConeAff1 + self.Owner.ViewAff), 0.0004, 0.12)
		self:SetDTFloat(0, clamp(self.Primary.Cone, 0.0004, 0.12 * (1 - (self.RecoilAff1 + self.RecoilAff2)) * (DTInt3 == 1 and 0.25 or 1)))
		self:SetDTFloat(1, clamp(1 - self.RecoilAff1 - self.RecoilAff2 - self.RecoilAff3, 0.1, 1))
		
		if CT > self.ConeInaccDelay then
			self.ConeInaccuracy = clamp(self.ConeInaccuracy - 0.0015, 0, 0.08 * self.ConeInaccuracyAff1)
		end
		
		if DTInt3 == 1 then
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
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 2)
		self.dt.NumShots = 0
	end
	
	if SERVER then
		if self.Owner:KeyDown(IN_SPEED) and ong and DTInt3 != 6 and DTInt3 != 10 and DTInt3 != 15 then 
			if vel > self.Owner:GetWalkSpeed() then
				if DTInt3 != 2 and DTInt3 != 15 and DTInt3 != 18 then
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
				if DTInt3 != 1 or DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 then
					self:SetDTInt(3, 0)
					
					if SERVER then
						self.Owner:SetFOV(0, 0.3)
						self.Owner:DrawViewModel(true)
					end
				end
			end
		elseif not self.Owner:KeyDown(IN_SPEED) and DTInt3 != 1 and DTInt3 != 0 and DTInt3 != 6 and DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 and DTInt3 != 19 or not ong and DTInt3 != 6 and DTInt3 != 0 and DTInt3 != 15 then
			self:SetDTInt(3, 0)
			
			if SERVER then
				self.Owner:SetFOV(0, 0.2)
				self.Owner:DrawViewModel(true)
			end
		end
	end
	
	DTInt3 = self:GetDTInt(3) -- get it again because it was most likely updated
	
	if DTInt3 == 1 then
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
	local Laser = Material("effects/laser_cstm")
	local LaserDot = Material("effects/brightglow_y")
	local Dot = Material("sprites/aim_reticule")
	local Ret = Material("sprites/eotech_reddot")
	local Tri = Material("sprites/acog_tri")
	local Kobra = Material("sprites/kobra_sight")
	local Scope = Material("gcellmats/scope_rifle")
	local Elcan = Material("sprites/elcan_reticle")
	local White = Color(255, 255, 255, 255)
	local mat, size, dist, scale, EA, delta, FT, mtr, n, f, wep, activity
	local rdrawsprite = render.DrawSprite
	
	local YOff = Vector(1, 1, 0.5)
	local MdlToAim = {}
	MdlToAim["models/wystan/attachments/2otech557sight.mdl"] = {size = 0.375, mat = Ret, dist = "EoTechDist", aimmove = true}
	MdlToAim["models/attachments/cmore.mdl"] = {size = 0.3, mat = Kobra, dist = "KobraDist", aimmove = true}
	MdlToAim["models/attachments/kascope.mdl"] = {size = 0.0375, mat = Dot, dist = "RReflexDist", aimmove = true}
	MdlToAim["models/bunneh/scope01.mdl"] = {size = 4, mat = Scope, dist = "BallisticDist", distno = 5.5}
	MdlToAim["models/bunneh/elcan.mdl"] = {size = 1, mat = Elcan, dist = "ELCANDist", pos = "ELCANPos", distno = 4}
	MdlToAim["models/wystan/attachments/aimpoint.mdl"] = {size = 0.0375, mat = Dot, dist = "AimpointDist", aimmove = true}
	MdlToAim["models/wystan/attachments/2octorrds.mdl"] = {size = 0.0375, mat = Dot, dist = "AimpointDist", aimmove = true}
	MdlToAim["models/wystan/attachments/2cog.mdl"] = {size = 0.25, mat = Tri, dist = "ACOGDist", pos = "ACOGPos", distno = 7}
 
    SWEP.vRenderOrder = nil
	
    function SWEP:ViewModelDrawn()
        vm = self.Owner:GetViewModel()
        if !IsValid(vm) then return end
         
        if (!self.VElements) then return end
         
        if vm.BuildBonePositions ~= self.BuildViewModelBones then
            vm.BuildBonePositions = self.BuildViewModelBones
        end
 
        if (self.ShowViewModel == nil or self.ShowViewModel) then
            vm:SetColor(Color(255,255,255,255))
        else
            // we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
            vm:SetColor(Color(255,255,255,1))
        end
		
		FT = FrameTime()
		EA = self.Owner:EyeAngles()
		delta = Angle(EA.p, EA.y, 0) - self.OldDelta
			
		self.OldDelta = Angle(EA.p, EA.y, 0)
		self.AngleDelta = LerpAngle(FT * 15, self.AngleDelta, delta)
		self.AngleDelta.y = clamp(self.AngleDelta.y, -15, 15)
         
        if (!self.vRenderOrder) then
            // we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}
 
            for k, v in pairs( self.VElements ) do
                if (v.type == "Model") then
                    table.insert(self.vRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.vRenderOrder, k)
                end
            end
             
        end
		
		aim = self.Owner:EyeAngles()
		dtint3 = self:GetDTInt(3)
		self.DrawTable = nil
 
        for k, name in ipairs( self.vRenderOrder ) do
			v = self.VElements[name]
			
            if (!v) then self.vRenderOrder = nil break end
			
			if v.color.a == 255 then         
				model = v.modelEnt
				sprite = v.spriteMaterial
				 
				if (!v.bone) then continue end
				 
				pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
				 
				if (!pos) then continue end
				 
				if (v.type == "Model" and IsValid(model)) then
					mtr = Matrix()
					mtr:Scale(v.size)
					model:EnableMatrix("RenderMultiply", mtr)
					model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)
					model:SetAngles(ang)
					 
					if (v.material == "") then
						model:SetMaterial("")
					elseif (model:GetMaterial() != v.material) then
						model:SetMaterial( v.material )
					end
					 
					if (v.skin and v.skin != model:GetSkin()) then
						model:SetSkin(v.skin)
					end
					 
					if (v.bodygroup) then
						for k, v in pairs( v.bodygroup ) do
							if (model:GetBodygroup(k) != v) then
								model:SetBodygroup(k, v)
							end
						end
					end
					 
					if (v.surpresslightning) then
						render.SuppressEngineLighting(true)
					end
					
					mdl = model:GetModel()
					n = CWAttachments[name]
					
					if n then
						n = CWAttachments[name].scope
					end
					
					if n then
						f = false
						
						if n.pos then
							if self.AimPos != self[n.pos] then
								f = true
							end
						end
						
						if not f and dtint3 == 1 then
							if self[n.dist] then
								dist = self[n.dist] * (dtint3 == 1 and 1 or 2)
							elseif n.distno then
								dist = n.distno * (dtint3 == 1 and 1 or 2)
							else
								dist = 10 * (dtint3 == 1 and 1 or 2)
							end
							
							if mdl == "models/wystan/attachments/2cog.mdl" then
								dist = dist - 2.5
							end
							
							size = n.size
							dir = self.Owner:EyeAngles() + self.Owner:GetPunchAngle()
							
							if n.aimmove then
								dir.y = dir.y + self.AngleDelta.y * 0.1
								dir.p = dir.p - self.AngleDelta.p * 0.1
							end
							
							dir = dir:Forward()
							dist = dist - self.RecoilAmt
							scale = 10 / dist
							size = size / scale
							self.DrawTable = {dist = dist - self.RecoilAmt, scale = scale, size = size, dir = dir, mat = n.mat}
						end
						
						render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
						render.SetBlend(v.color.a/255)
						model:DrawModel()
						render.SetBlend(1)
						render.SetColorModulation(1, 1, 1)
						 
						if (v.surpresslightning) then
							render.SuppressEngineLighting(false)
						end
					else
						render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
						render.SetBlend(v.color.a/255)
						model:DrawModel()
						render.SetBlend(1)
						render.SetColorModulation(1, 1, 1)
						 
						if (v.surpresslightning) then
							render.SuppressEngineLighting(false)
						end
					end
					 
				elseif (v.type == "Sprite" and sprite) then
					 
					drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					render.SetMaterial(sprite)
					render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
					 
				elseif (v.type == "Quad" and v.draw_func) then
					 
					drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)
					 
					cam.Start3D2D(drawpos, ang, v.size)
						v.draw_func( self )
					cam.End3D2D()
	 
				end
            end
        end
		
		if self.VElements then
			entry = self.VElements["laser"]
			
			if entry and entry.color.a == 255 and IsValid(entry.modelEnt) then
				lt = self.LaserTune
				fw = entry.modelEnt:GetAngles()
				pos = entry.modelEnt:GetPos()
				pos = pos + aim:Right() * lt.PosRight + aim:Up() * lt.PosUp + aim:Forward() * lt.PosForward
				fw:RotateAroundAxis(fw:Right(), lt.AngUp)
				fw:RotateAroundAxis(fw:Up(), lt.AngRight)
				fw:RotateAroundAxis(fw:Forward(), lt.AngForward)
				fw = fw:Forward()
				
				if dtint3 == 1 then
					if self.MoveWithFiringAnim then
						activity = vm:GetSequenceActivityName(vm:GetSequence())
						
						if activity == "ACT_VM_PRIMARYATTACK" and vm:GetCycle() < 0.99 then
							dir = fw
						else
							dir = (aim + Angle(self.AngleDelta.p / -9, self.AngleDelta.y / 9, 0) + self.Owner:GetPunchAngle()):Forward()
						end
					else
						dir = (aim + Angle(self.AngleDelta.p / -9, self.AngleDelta.y / 9, 0) + self.Owner:GetPunchAngle()):Forward()
					end
				else
					dir = fw
				end
				
				td.start = pos
				td.endpos = td.start + dir * 8192
				td.filter = self.Owner
				
				trace = util.TraceLine(td)
				
				if util.PointContents(trace.HitPos) != CONTENTS_SOLID then
					dist = td.start:Distance(trace.HitPos)
					
					render.SetMaterial(Laser)
					render.DrawBeam(pos + dir, pos + dir * clamp(dist, 0, 75), 0.1, 0, 0.99, Color(255, 0, 0, 200))
					
					render.SetMaterial(LaserDot)
					
					if GetConVarNumber("cstm_ef_laserblur") > 0 then
						if self.LastLaserPos then
							render.DrawBeam(trace.HitPos + YOff, self.LastLaserPos - YOff, 2, 0, 1, Color(255, 0, 0, 255))
						end
						
						self.LastLaserPos = trace.HitPos
					else
						rdrawsprite(trace.HitPos, 2, 2, Color(255, 0, 0, 255))
						self.LastLaserPos = nil
					end
				end
			end
		end
		
		if IsValid(self.Owner.CSTM_Nade) then
			wep = self.Owner.CSTM_Nade
			
			if wep:GetCycle() < 0.98 then
				FT = FrameTime()
				EP = EyePos()
				EA = EyeAngles()
				EP = EP - EA:Up() * wep.Lower
				wep:SetRenderOrigin(EP + EA:Forward() * 8)
				wep:SetRenderAngles(EA)
				wep:FrameAdvance(FT)
				wep:SetupBones()
				wep:DrawModel()
					
				wep.Lower = Lerp(FT * 5, wep.Lower, 2)
			end
		end
		
		TWeps_BBP()
    end
end

local time

function SWEP:StartCustomReload()
	if IsFirstTimePredicted() then
		if self.dt.Sil then
			self:SendWeaponAnim(ACT_VM_RELOAD_SILENCED)
		else
			self:SendWeaponAnim(ACT_VM_RELOAD)
		end
	end
	
	vm = self.Owner:GetViewModel()
	vm:SetPlaybackRate(self.ReloadSpeed)
	
	clip = self:Clip1()
	mul = clip == 0 and 1 or 1 - self.IncAmmoPerc
	
	if clip then
		self.ShouldBolt = true
	end
	
	seqdur = vm:SequenceDuration()

	if self.SkipIdle then
		time = seqdur / self.ReloadSpeed
	else
		if self.dt.Sil then
			if self.IncAmmoPercSil then
				time = seqdur / self.ReloadSpeed * self.IncAmmoPercSil
			else
				time = seqdur / self.ReloadSpeed * self.IncAmmoPerc
			end
		else
			time = seqdur / self.ReloadSpeed * self.IncAmmoPerc
		end
	end
	
	CT = CurTime()
	
	self.ReloadTime = CT + time
	self:SetNextPrimaryFire(CT + (seqdur / self.ReloadSpeed) * mul)
	self:SetNextSecondaryFire(CT + (seqdur / self.ReloadSpeed) * mul)
	self.ReloadDelay = CT + (seqdur / self.ReloadSpeed + 0.3) * mul
	self.Owner.AttachDelay = CT + (seqdur / self.ReloadSpeed) * mul
	self.MeleeDelay = CT + (seqdur / self.ReloadSpeed) * mul
end

local chamber, ammo

function SWEP:FinishCustomReload(bolt)
	clip = self:Clip1()
	ammo = self.Owner:GetAmmoCount(self.Primary.Ammo)
	AmountToReload = self.Primary.ClipSize - clip
	CT = CurTime()
	
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
			if self.dt.Sil then
				self:SendWeaponAnim(ACT_VM_IDLE_SILENCED)
			else
				self:SendWeaponAnim(ACT_VM_IDLE)
			end
			
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
		self:BoltWeaponry()
		self.ShouldBolt = false
	end
end

local Dir, Dir2, ent, dot
local trace_normal = bit.bor(CONTENTS_SOLID, CONTENTS_OPAQUE, CONTENTS_MOVEABLE, CONTENTS_DEBRIS, CONTENTS_MONSTER, CONTENTS_HITBOX, 402653442)
local trace_walls = bit.bor(CONTENTS_TESTFOGVOLUME, CONTENTS_EMPTY, CONTENTS_MONSTER, CONTENTS_HITBOX)
local NoRicochet = {[MAT_FLESH] = true, [MAT_ANTLION] = true, [MAT_BLOODYFLESH] = true, [MAT_DIRT] = true, [MAT_SAND] = true, [MAT_GLASS] = true, [MAT_ALIENFLESH] = true}
local PenMod = {[MAT_SAND] = 0.5, [MAT_DIRT] = 0.8, [MAT_METAL] = 1.1, [MAT_TILE] = 0.9, [MAT_WOOD] = 1.2}
local bul = {}

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
			-- dot = -Dir2:DotProduct(tr.HitNormal)
			-- ent = tr.Entity
			
			-- if dot > 0.26 and not ent:IsNPC() and not ent:IsPlayer() then
			-- 	td.start = tr.HitPos
			-- 	td.endpos = td.start + Dir2 * self.PenStr * (PenMod[tr.MatType] and PenMod[tr.MatType] or 1) * self.PenMod
			-- 	td.filter = self.Owner
			-- 	td.mask = trace_walls
				
			-- 	tr = util.TraceLine(td)
				
			-- 	td.start = tr.HitPos
			-- 	td.endpos = td.start + Dir2 * 0.1
			-- 	td.filter = self.Owner
			-- 	td.mask = trace_normal
				
			-- 	tr = util.TraceLine(td) -- run ANOTHER trace to check whether we've penetrated a surface or not
				
			-- 	if not tr.Hit then
			-- 		bul.Num = 1
			-- 		bul.Src = tr.HitPos
			-- 		bul.Dir = Dir2
			-- 		bul.Spread 	= Vec0
			-- 		bul.Tracer	= 4
			-- 		bul.Force	= dmg * 0.5
			-- 		bul.Damage = bul.Damage * 0.5
			-- 		self.Owner:FireBullets(bul)
			-- 	end
			-- else
			-- 	if not NoRicochet[tr.MatType] then
			-- 		Dir2 = Dir2 + (tr.HitNormal * dot) * 3
			-- 		Dir2 = Dir2 + VectorRand() * 0.06
			-- 		bul.Num = 1
			-- 		bul.Src = tr.HitPos
			-- 		bul.Dir = Dir2
			-- 		bul.Spread 	= Vec0
			-- 		bul.Tracer	= 0
			-- 		bul.Force	= dmg * 0.75
			-- 		bul.Damage = bul.Damage * 0.75
					
			-- 		self.Owner:FireBullets(bul)
			-- 	end
			-- end
		end
		
		td.mask = trace_normal
	//end
	
	if self:GetDTInt(3) != 1 then
		if self.dt.Sil then
			if self.DryFireAnim and self:Clip1() == 0 then
				self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)
			else
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
			end
		else
			if self.DryFireAnim and self:Clip1() == 0 then
				self:SendWeaponAnim(ACT_VM_DRYFIRE)
			else
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			end
		end
	
		self.Owner:GetViewModel():SetPlaybackRate(self.PlaybackRate or 1)
		self.AnimPlayed = true
	else
		if not self.PlayFireAnim then
			if IsFirstTimePredicted() then
				self:VMRecoil()
			end
		end
		
		if not self.AnimPlayed or self.PlayFireAnim then
			if self.dt.Sil then
				if self.DryFireAnim and self:Clip1() == 0 then
					self:SendWeaponAnim(ACT_VM_DRYFIRE_SILENCED)
				else
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK_SILENCED)
				end
			else
				if self.DryFireAnim and self:Clip1() == 0 then
					self:SendWeaponAnim(ACT_VM_DRYFIRE)
				else
					self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				end
			end
			
			vm = self.Owner:GetViewModel()
			vm:SetPlaybackRate(self.PlaybackRate or 1)
			
			if not self.PlayFireAnim then
				vm:SetPlaybackRate(10)
			end
			
			self.AnimPlayed = true
		end
	end
	
	if not self.dt.Sil then
		self.Owner:MuzzleFlash()
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)				// 3rd Person Animation
end


if CLIENT then
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
	
	function SWEP:DrawWeaponSelection( x, y, wide, tall, alpha )
		surface.SetDrawColor(255, 210, 0, 255)
		surface.SetTexture(self.WepSelectIcon)
		surface.DrawTexturedRect(x + 56, y, 128, 128)
		//draw.SimpleText( self.WepSelectIcon, "CSSelectIcons", x + wide/2, y + tall*0.2, Color( 255, 210, 0, 255 ), TEXT_ALIGN_CENTER )
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
	
	tr = self.Owner:GetEyeTrace()
	
	if tr.HitPos:Distance(self.Owner:GetShootPos()) < 30 and tr.Entity:GetClass() != "prop_ragdoll" then
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
end
