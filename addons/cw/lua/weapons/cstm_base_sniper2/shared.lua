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

local CT, DT3
local destr, tsim, app, clamp, sin, cos, rand, rand2 = timer.Destroy, timer.Simple, math.Approach, math.Clamp, math.sin, math.cos, math.random, math.Rand

function SWEP:SecondaryAttack()
	if self.FireMode == "safe" then
		return
	end
	
	if self.ReloadTime then
		return
	end
	
	DT3 = self:GetDTInt(3)

	if self.Owner:KeyDown(IN_WALK) then
		if DT3 == 0 then
			if SERVER then
				self:SetFuseTime()
			end
			
			return
		end
	end
	
	if DT3 == 2 or not self.Owner:OnGround() or self.IsReloading == true then
		return
	end

	if self.ShouldBolt == true then
		return
	end
	
	CT = CurTime()
	
	if (DT3 == 0 or DT3 == 3 or DT3 == 7) then
		self:SetDTInt(3, 1)
		
		if SERVER then
			tsim(0.15, function()
				DT3 = self:GetDTInt(3)
				
				if self == nil or DT3 != 1 then
					return
				end
				
				self.Owner:DrawViewModel(false)
			end)
			
			self.Owner:SetFOV((self.ZoomAmount or 20), 0.3)
		end
	elseif DT3 == 1  then
		self:SetDTInt(3, 0)
		
		if SERVER then
			self.Owner:SetFOV(0, 0.3)
			self.Owner:DrawViewModel(true)
		end
	end
	
	self:SetNextPrimaryFire(CT + 0.2)
	self:SetNextSecondaryFire(CT + 0.3)
end

if CLIENT then

	local tid, tex, clr, rect, orect, trect, trectuv, trectrot = surface.GetTextureID, surface.SetTexture, surface.SetDrawColor, surface.DrawRect, surface.DrawOutlinedRect, surface.DrawTexturedRect, surface.DrawTexturedRectUV, surface.DrawTexturedRectRotated
	local gap = 5
	local ScopeTexture = tid("gcellmats/scope_rifle2")
	local Bullet = tid("VGUI/bullet")
	local CurAlpha_Weapon = 255
	local Text, tp

	function SWEP:DrawHUD()
		local Width = ScrW()
		local Height = ScrH()
		local x2 = (Width - 1024) / 2
		local y2 = (Height - 1024) / 2
		local x3 = Width - x2
		local y3 = Height - y2
		local FT = FrameTime()
		DT3 = self:GetDTInt(3)
		
		if DT3 == 1 then
			if UseGoggle == false then
				TimeToUseGoggle = CurTime() + 0.15
				UseGoggle = true
			end
			
			if CurTime() > TimeToUseGoggle then
				clr(255, 255, 255, 255)
				tex(ScopeTexture)
				trectuv(x2, y2, 1024, 1024, 0, 0, 1, 1)
				
				clr(0, 0, 0, 255)
				rect(0, 0, x2, Height)
				rect(x3, 0, x2, Height)
				rect(0, 0, Width, y2)
				rect(0, y3, Width, y2)
			end
		else
			UseGoggle = false
		end
		
		self:DrawHUDElements(Width, Height, FT)
		tp = self.Owner:ShouldDrawLocalPlayer()
		
		if ( self.Owner == LocalPlayer() && tp ) then

			local tr = util.GetPlayerTrace( self.Owner )
			tr.mask = {CONTENTS_SOLID, CONTENTS_MOVEABLE, CONTENTS_MONSTER, CONTENTS_WINDOW, CONTENTS_DEBRIS, CONTENTS_GRATE, CONTENTS_AUX}
			local trace = util.TraceLine( tr )
			
			local coords = trace.HitPos:ToScreen()
			x, y = coords.x, coords.y

		else
			x, y = Width / 2.0, Height / 2.0
		end
		
		local scale = 10 * self:GetDTFloat(0) //self.Primary.Cone
		
		if tp then
			CurAlpha_Weapon = app(CurAlpha_Weapon, 255, FT / 0.001)
		else
			if DT3 == 2 or DT3 == 4 or DT3 == 6 or DT3 == 19 or self.Safe then
				CurAlpha_Weapon = app(CurAlpha_Weapon, 0, FT / 0.0017)
			elseif (DT3 == 1 and self.NoProperIronsights != true) or UseGoggle == true or (DT3 == 1 and self.HasInstalledScope == true) then
				CurAlpha_Weapon = app(CurAlpha_Weapon, 0, FT / 0.001)
			elseif DT3 == 0 or DT3 == 3 then
				CurAlpha_Weapon = app(CurAlpha_Weapon, 255, FT / 0.001)
			end
		end
		
		gap = Lerp(0.25, gap, scale * 50)
		
		if GetConVarNumber("cstm_dynamiccrosshair") > 0 then
			gap2 = gap
		else
			gap2 = 0
		end
		
		out_r = GetConVarNumber("cstm_out_r")
		out_g = GetConVarNumber("cstm_out_g")
		out_b = GetConVarNumber("cstm_out_b")
		out_a = GetConVarNumber("cstm_out_a")
				
		in_r = GetConVarNumber("cstm_in_r")
		in_g = GetConVarNumber("cstm_in_g")
		in_b = GetConVarNumber("cstm_in_b")
		in_a = GetConVarNumber("cstm_in_a")
				
		cl = GetConVarNumber("cstm_crosslength")
				
		if GetConVarNumber("cstm_leftcross") > 0 then
			clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
			rect(x - 3 - gap2 - cl - gap, y - 1, cl + 2 + gap2, 3)
			clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
			rect(x - 2 - gap2 - cl - gap, y, cl + gap2, 1)
		end
				
		if GetConVarNumber("cstm_rightcross") > 0 then
			clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
			rect(x + 2 + gap, y - 1, cl + 2 + gap2, 3)
			clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
			rect(x + 3 + gap, y, cl + gap2, 1)
		end
				
		if GetConVarNumber("cstm_lowercross") > 0 then
			clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
			rect(x - 1, y + 2 + gap, 3, cl + 2 + gap2)
			clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
			rect(x, y + 3 + gap, 1, cl + gap2)
		end
				
		if GetConVarNumber("cstm_uppercross") > 0 then
			clr(out_r, out_g, out_b, CurAlpha_Weapon * (out_a / 255))
			rect(x - 1, y - cl - gap2 - 3 - gap, 3, cl + 2 + gap2)
			clr(in_r, in_g, in_b, CurAlpha_Weapon * (in_a / 255))
			rect(x, y - cl - gap2 - 2 - gap, 1, cl + gap2)
		end
	end
end