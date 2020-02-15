if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoDocter = true
	SWEP.DoesntDropRail = true
	SWEP.NoGL = false
	SWEP.NoVertGrip = false
	SWEP.NoBipod = false
	SWEP.DifferentSilencer = true
end

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45

SWEP.MuzVel = 616.796

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint", "elcan", "acog"},
	[2] = {"vertgrip", "grenadelauncher", "bipod"},
	[3] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "HK G36C"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot = 3 //				= 3
	SWEP.SlotPos = 0 //			= 3
	SWEP.IconLetter			= "z"
	SWEP.NoRail = true
	SWEP.DrawAngleMod = -1
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.ACOGDist = 8
	
	SWEP.VertGrip_Idle = {
		['Right_Forearm'] = {vector = Vector(0.75, 0, 4.5), angle = Angle(0, 0, 0)},
		['R_Thumb'] = {vector = Vector(0, 0, 0), angle = Angle(-2.9189999103546, -14.031000137329, -2.625)},
		['R_Thumb2'] = {vector = Vector(0, 0, 0), angle = Angle(-0.31900000572205, 0, -20.325000762939)}}
		
	SWEP.GrenadeLauncher_Idle = {
		['Right_Arm'] = {vector = Vector(0, 0, 0), angle = Angle(0, 0, 0)}}
		
	SWEP.GrenadeLauncher_Active = {
		['Right_Arm'] = {vector = Vector(0, -1, 1), angle = Angle(0, 0, 0)}}
		
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_g36c")
	killicon.Add( "cstm_rif_g36c", "VGUI/kills/kill_g36c", Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "BaseW", pos = Vector(-0.212, -0.169, -6.901), angle = Angle(4.512, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grenadelauncher"] = { type = "Model", model = "models/wystan/attachments/m203.mdl", bone = "BaseW", rel = "", pos = Vector(0.275, -4.296, -2.095), angle = Angle(180, 0, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "BaseW", pos = Vector(0.368, -6.709, -1.157), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "BaseW", pos = Vector(0.368, -6.709, -1.157), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "BaseW", pos = Vector(0.212, -4.581, -1.032), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "BaseW", rel = "", pos = Vector(10.562, -17.726, -0.301), angle = Angle(0, -90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "BaseW", rel = "", pos = Vector(-0.944, -18.15, 2.357), angle = Angle(-90, 0, 90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "BaseW", rel = "", pos = Vector(0.112, -19.25, 0.537), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "BaseW", rel = "", pos = Vector(0.037, -13.195, 4.736), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "BaseW", rel = "", pos = Vector(0.025, -10.483, 4.487), angle = Angle(0, 180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", pos = Vector(-3.188, 0.837, 4.044), angle = Angle(-3.931, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", pos = Vector(2.368, 0.231, -1.762), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", pos = Vector(2.368, 0.231, -1.762), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", pos = Vector(1.587, 0.4, -1.744), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.187, 15.718, -1.058), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_rif_g36c.mdl", pos = Vector(-0.201, 0, -0.413), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grenadelauncher"]  = { type = "Model", model = "models/wystan/attachments/m203.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.43, 0.324, 0.181), angle = Angle(180, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.252, 1.23, -2.402), angle = Angle(0, 90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.519, 0.58, -7.314), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.262, 0.569, -7.776), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_xtra_pistol"
SWEP.Category = "Extra Pack (ARs)"
SWEP.FireModes = {"auto", "2burst", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_rif_g36c.mdl"
SWEP.WorldModel = "models/weapons/w_rif_g36c.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_G36C")
SWEP.Primary.Recoil			= 0.9
SWEP.Primary.Damage			= 22
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.078
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("CSTM_SilencedShot5")
SWEP.SilencedVolume = 75

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.55 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.9
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1.5 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.005
SWEP.HipCone 				= 0.045
SWEP.InaccAff1 = 0.75
SWEP.PlaybackRate = 2.5
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "40MM_HE"
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip	= 0

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(4.064, -3, 1.475)
SWEP.AimAng = Vector(0.237, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(3.997, -3.75, 0.714)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.FlipOriginsPos = Vector(2.799, 0, -0.08)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(4.105, -4.5, 0.64)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(4.071, -3.994, 0.981)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(4.07, -3.994, 1.138)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(4.04, -4, 0.53)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(4.04, -5, -0.6)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.ELCANPos = Vector(4.04, -5, 0.5)
SWEP.ELCANAng = Vector(0, 0, 0)

SWEP.ELCAN_BackupPos = Vector(4.04, -5, -0.515)
SWEP.ELCAN_BackupAng = Vector(0, 0, 0)

if CLIENT then
	function SWEP:CanUseBackUp()
		if self.VElements["acog"].color.a == 255 or self.VElements["elcan"].color.a == 255 then
			return true
		end
		
		return false
	end
	
	function SWEP:UseBackUp()
		if self.VElements["acog"].color.a == 255 then
			if self.AimPos == self.ACOG_BackupPos then
				self.AimPos = self.ACOGPos
				self.AimAng = self.ACOGAng
			else
				self.AimPos = self.ACOG_BackupPos
				self.AimAng = self.ACOG_BackupAng
			end
		elseif self.VElements["elcan"].color.a == 255 then
			if self.AimPos == self.ELCAN_BackupPos then
				self.AimPos = self.ELCANPos
				self.AimAng = self.ELCANAng
			else
				self.AimPos = self.ELCAN_BackupPos
				self.AimAng = self.ELCAN_BackupAng
			end
		end
	end
end