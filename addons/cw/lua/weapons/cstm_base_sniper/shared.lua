if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= false
	SWEP.AutoSwitchFrom		= false
end

if ( CLIENT ) then
	SWEP.DrawAmmo			= true
	SWEP.DrawCrosshair		= false
	SWEP.ViewModelFOV		= 70
	SWEP.ViewModelFlip		= true
	SWEP.CSMuzzleFlashes	= true
end

SWEP.Author			= "LEETNOOB"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= "PRIMARY ATTACK key to fire\nSECONDARY ATTACK key to toggle ironsights\nUSE key + SECONDARY ATTACK key - attach suppressor\nUSE key + RELOAD key - switch between semi-auto/auto firemodes (SMGs/ARs)"

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
SWEP.Base = "cstm_base_pistol"
SWEP.MinFOV = 15
SWEP.MaxFOV = 45
SWEP.CurZoom = 40
SWEP.ZoomDelay = 0
SWEP.CanAdjust = true

local DTInt3, ply, wep, vm, seqdur, activity, bone, matrix, m, CT, Width, Height, x, x2, y, y2, force, ong, vel
local destr, tsim, app, clamp, sin, cos, rand, rand2 = timer.Destroy, timer.Simple, math.Approach, math.Clamp, math.sin, math.cos, math.random, math.Rand

function SWEP:Think()
	CT = CurTime()
	ong = self.Owner:OnGround()
	vel = self.Owner:GetVelocity():Length()
	
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
		
		if self.Owner:Crouching() then
			self.ConeAff1 = 0.005
			self.RecoilAff2 = 0.2
		else
			self.ConeAff1 = 0
			self.RecoilAff2 = 0
		end
		
		if self:GetDTInt(3) == 1 then
			if self.ConeAff2 == 0 then
				self.ConeAff2 = 0.005
			end
			
			if self.HeadbobMul == 1 then
				self.HeadbobMul = 0.4
			end
		else
			if self.ConeAff2 == 0.005 then
				self.ConeAff2 = 0
			end
			
			if self.HeadbobMul == 0.4 then
				self.HeadbobMul = 1
			end
		end
		
		if self.dt.Sil then
			self.RecoilAff3 = 0.15
		else
			self.RecoilAff3 = 0
		end
		
		if self:GetDTInt(3) == 1 then
			self.Primary.Cone = clamp(self.DefCone + self.ConeInaccuracy + ((vel / 10000) * (self:GetDTInt(3) == 1 and self.VelocitySensivity * 0.3 or self.VelocitySensivity)) - self.ConeAff1, 0.001, 0.15)
		else
			self.Primary.Cone = 0.055
		end
		
		if self:GetDTInt(3) == 1 then
			if not self.Owner:KeyDown(IN_ATTACK2) then
				if tonumber(self.Owner:GetInfo("cstm_hold_to_aim")) > 0 then
					self:SetDTInt(3, 0)
					self.Owner:SetFOV(0, 0.3)
					//self.Owner:DrawViewModel(true)
				end
			end
		end
		
		self:SetDTFloat(0, clamp(self.Primary.Cone, 0.0001, 0.15))
		self:SetDTFloat(1, clamp(1 - self.RecoilAff1 - self.RecoilAff2 - self.RecoilAff3, 0.05, 1))
		self.ConeInaccuracy = clamp(self.ConeInaccuracy - self.ConeInaccuracyDec, 0, 0.15 * self.ConeInaccuracyAff1)
		self.ConeInaccuracyDec = clamp(self.ConeInaccuracyDec + 0.00002, 0, 0.02)
	end
	
	if not self.Owner:KeyDown(IN_ATTACK) and self.dt.NumShots != 0 and self.FireMode:find("burst") then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay * 2)
		self.dt.NumShots = 0
	end
	
	DTInt3 = self:GetDTInt(3)
	
	if self.Owner:KeyDown(IN_SPEED) and ong and DTInt3 != 6 and DTInt3 != 10 and DTInt3 != 15 then 
		if vel > self.Owner:GetWalkSpeed() then
			if DTInt3 != 2 and DTInt3 != 15 then
				self:SetDTInt(3, 2)
				if SERVER then
					self.Owner:SetFOV(0, 0.3)
					//self.Owner:DrawViewModel(true)
					self:SetNextPrimaryFire(CurTime() + 0.3)
					self:SetNextSecondaryFire(CurTime() + 0.3)
				end
			end
			
		else
			if self:GetDTInt(3) != 1 or DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 and DTInt3 != 19 then
				self:SetDTInt(3, 0)
				if SERVER then
					self.Owner:SetFOV(0, 0.3)
					//self.Owner:DrawViewModel(true)
				end
			end
		end
	elseif not self.Owner:KeyDown(IN_SPEED) and DTInt3 != 1 and DTInt3 != 0 and DTInt3 != 6 and DTInt3 != 8 and DTInt3 != 10 and DTInt3 != 11 and DTInt3 != 12 and DTInt3 != 15 and DTInt3 != 19 or not ong and DTInt3 != 6 and DTInt3 != 0 and DTInt3 != 15 then
		self:SetDTInt(3, 0)
		if SERVER then
			self.Owner:SetFOV(0, 0.2)
			//self.Owner:DrawViewModel(true)
			self:SetNextPrimaryFire(CurTime() + 0.3)
			self:SetNextSecondaryFire(CurTime() + 0.3)
		end
	end
	
	DTInt3 = self:GetDTInt(3)
	
	if DTInt3 == 1 then
		trace = self.Owner:GetEyeTrace()
		
		if trace.HitPos:Distance(self.Owner:GetShootPos()) <= 30 and trace.Entity:GetClass() != "prop_ragdoll" then
			self:SetDTInt(3, 0)
			self.Owner:SetFOV(0, 0.2)
			self:SetNextPrimaryFire(CT + 0.2)
			self:SetNextSecondaryFire(CT + 0.2)
		end
	end
	
	if SERVER then
		if DTInt3 == 1 then
			if not self.Owner:KeyDown(IN_ATTACK2) then
				if tonumber(self.Owner:GetInfo("cstm_hold_to_aim")) > 0 then
					self:SetDTInt(3, 0)
					self.Owner:SetFOV(0, 0.3)
				end
			end
		end
	end
	
	if not self.Owner:KeyDown(IN_RELOAD) then
		if not self.HasReleasedKey then
			self.HasReleasedKey = true
		end
	end
end

function SWEP:SecondaryAttack()
	if self.FireMode == "safe" then
		return
	end
	
	if self.ReloadTime then
		return
	end
	
	DTInt3 = self:GetDTInt(3)
	
	if self.Owner:KeyDown(IN_WALK) then
		if DTInt3 == 0 then
			if SERVER then
				self:SetFuseTime()
			end
			
			return
		end
	end
	
	if DTInt3 == 2 or not self.Owner:OnGround() or self.IsReloading == true then
		return
	end
	
	CT = CurTime()

	if self.ShouldBolt == true then
		return
	end

	if (DTInt3 == 0 or DTInt3 == 3 or DTInt3 == 7) then
		self:SetDTInt(3, 1)
		
		if SERVER then
			self.Owner:SetFOV(self.CurZoom, 0.3)
		end
	elseif DTInt3 == 1  then
		self:SetDTInt(3, 0)
		
		if SERVER then
			self.Owner:SetFOV(0, 0.3)
		end
	end
	
	self:SetNextPrimaryFire(CT + 0.2)
	self:SetNextSecondaryFire(CT + 0.3)
	
end

if CLIENT then
	local tid, tex, clr, rect, trectuv, trectrot = surface.GetTextureID, surface.SetTexture, surface.SetDrawColor, surface.DrawRect, surface.DrawTexturedRectUV, surface.DrawTexturedRectRotated
	local ScopeTexture = tid("gcellmats/scope_rifle2")
	local Bullet = tid("VGUI/bullet")

	function SWEP:DrawHUD()
		Width = ScrW()
		Height = ScrH()
		x = (Width - 1024) / 2
		y = (Height - 1024) / 2
		x2 = Width - x
		y2 = Height - y

		if self:GetDTInt(3) == 1 then
			if not self.UseGoggle then
				self.TimeToUseGoggle = CurTime() + 0.15
				self.UseGoggle = true
			end
			
			if CurTime() > self.TimeToUseGoggle then
				clr(255, 255, 255, 255)
				tex(ScopeTexture)
				trectuv(x, y, 1024, 1024, 0, 0, 1, 1)
				
				clr(0, 0, 0, 255)
				rect(0, 0, x, Height)
				rect(x2, 0, x, Height)
				rect(0, 0, Width, y)
				rect(0, y2, Width, y)
			end
		else
			self.UseGoggle = false
		end
		
		self:DrawHUDElements(Width, Height, FrameTime())
	end
end

function SWEP.ZoomIn(ply)
	if SERVER then
		wep = ply:GetActiveWeapon()
		CT = CurTime()
		
		if CT < wep.ZoomDelay or ply:GetFOV() == wep.MinFOV then
			return
		end
		
		wep:UpdateFOV(-15)
		wep.ZoomDelay = CT + 0.2
	end
end

function SWEP.ZoomOut(ply)
	if SERVER then
		wep = ply:GetActiveWeapon()
		CT = CurTime()
		
		if CT < wep.ZoomDelay or ply:GetFOV() == wep.MaxFOV then
			return
		end
	
		wep:UpdateFOV(15)
		wep.ZoomDelay = CT + 0.2
	end
end

function SWEP:UpdateFOV(amount)
	if SERVER then
		self.CurZoom = clamp(self.CurZoom + amount, self.MinFOV, self.MaxFOV)
		self.Owner:SetFOV(self.CurZoom, 0.2)
		self.Owner:EmitSound("weapons/zoom.wav", 40, 100)
	end
end

if CLIENT then
	function SWEP.PlayerBindPress(ply, bnd)
		wep = ply:GetActiveWeapon()
		
		if wep.CanAdjust != true or CurTime() < wep.ZoomDelay then
			return
		end

		if not wep:GetClass():find("^cstm_sniper_") or wep:GetDTInt(3) != 1 then
			return
		end
		
		if bnd == "invprev" then
			RunConsoleCommand("zoom_out")
			return true
		elseif bnd == "invnext" then
			RunConsoleCommand("zoom_in")
			return true
		end
	end
end

if SERVER then
	concommand.Add("zoom_in", SWEP.ZoomIn)
	concommand.Add("zoom_out", SWEP.ZoomOut)
else
	hook.Add("PlayerBindPress", "Change zoom level", SWEP.PlayerBindPress)
end