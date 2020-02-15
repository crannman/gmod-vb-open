if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45

SWEP.MuzVel = 616.796

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "aimpoint", "acog"},
	[2] = {"vertgrip", "bipod"},
	[3] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "IMI Galil ARM"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 3
	SWEP.SlotPos = 0 // = 0
	SWEP.IconLetter			= "v"
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.ACOGDist = 5
	
	killicon.AddFont( "cstm_rif_galil", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VertGrip_Idle = {
		['v_weapon.Left_Ring01'] = {vector = Vector(0, 0, 0), angle = Angle(0, 20.212999343872, -9.7749996185303)},
		['v_weapon.Left_Index03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 61.731998443604, 0)},
		['v_weapon.Left_Index02'] = {vector = Vector(0, 0, 0), angle = Angle(0, 7.938000202179, 0)},
		['v_weapon.Left_Index01'] = {vector = Vector(0, 0, 0), angle = Angle(-8.3559999465942, 29.093000411987, -17.836999893188)},
		['v_weapon.Left_Ring03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 57.069000244141, 0)},
		['v_weapon.Left_Middle01'] = {vector = Vector(0, 0, 0), angle = Angle(-13.781000137329, 21.738000869751, -17.85000038147)},
		['v_weapon.Left_Arm'] = {vector = Vector(-4.3, -2.5, 1), angle = Angle(1.5379999876022, 40.375, 121.94999694824)},
		['v_weapon.Left_Pinky03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 46.062000274658, 0)},
		['v_weapon.Left_Hand'] = {vector = Vector(0, 0, 0), angle = Angle(33.848999023438, 0, 0)},
		['v_weapon.Left_Thumb01'] = {vector = Vector(0, 0, 0), angle = Angle(-10.069000244141, -19.113000869751, 0)},
		['v_weapon.Left_Thumb02'] = {vector = Vector(0, 0, 0), angle = Angle(0, -27.91900062561, 0)},
		['v_weapon.Left_Thumb03'] = {vector = Vector(0, 0, 0), angle = Angle(0, -78.180999755859, 0)},
		['v_weapon.Left_Middle03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 63.849998474121, 0)},
		['v_weapon.handle'] = {vector = Vector(0, 0, 0), angle = Angle(-37.868999481201, 0, 0)}}
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.galil", pos = Vector(0.037, -0.057, 21.461), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.17), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {}},
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.013, -1.994, 2.736), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.018, -2.07, 4.099), angle = Angle(0, 0, -90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "v_weapon.galil", pos = Vector(-0.232, 2.088, -1.538), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "v_weapon.galil", pos = Vector(0.193, -0.72, 3), angle = Angle(180, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_weapon.galil", pos = Vector(-0.101, 1.919, -1.889), angle = Angle(180, 180, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0.524, -1.045, 14.368), angle = Angle(0, 0, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(-0.207, 3.23, 0.962), angle = Angle(0, 0, -90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "v_weapon.galil", rel = "", pos = Vector(0, 2.012, 12.13), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(32, 0.25, -3.701), angle = Angle(-90, 0, 0), size = Vector(0.059, 0.059, 0.159), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.363, 0.2, -1.101), angle = Angle(180, 90, -10), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.5, 0.73, -3.401), angle = Angle(180, -90, 10), size = Vector(0.833, 0.833, 0.833), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5, 0.699, -7.301), angle = Angle(180, -90, 10), size = Vector(0.666, 0.666, 0.666), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.862, 0, 0), angle = Angle(0, -90, 180), size = Vector(0, 0, 0), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.231, 0.162, -1.157), angle = Angle(0, 90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.3, 0.529, -7), angle = Angle(180, 90, -10), size = Vector(0.725, 0.725, 0.725), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.842, 0.702, -5.832), angle = Angle(180, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"auto", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_rif_galil.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_Galil.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 22
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 35
SWEP.Primary.Delay			= 0.095
SWEP.Primary.DefaultClip	= 35
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("weapons/m4a1/m4a1-1.wav")
SWEP.SilencedVolume = 75

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.NoBoltAnim = true
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.57 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.9
SWEP.CurCone				= 0.03
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.002
SWEP.HipCone 				= 0.06
SWEP.InaccAff1 = 0.75
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(-5.145, -5.574, 2.322)
SWEP.AimAng = Vector(-0.276, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(-5.095, -5.91, 1.61)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-5.157, -7.377, 1.741)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-5.148, -7.377, 1.922)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(-5.153, -4.591, 1.55)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(-5.153, -6, 0.76)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

if CLIENT then
	function SWEP:CanUseBackUp()
		if self.VElements["acog"].color.a == 255 then
			return true
		end
		
		return false
	end
	
	function SWEP:UseBackUp()
		if self.AimPos == self.ACOG_BackupPos then
			self.AimPos = self.ACOGPos
			self.AimAng = self.ACOGAng
		else
			self.AimPos = self.ACOG_BackupPos
			self.AimAng = self.ACOG_BackupAng
		end
	end
end