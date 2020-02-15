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

	SWEP.PrintName			= "Famas"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 3
	SWEP.SlotPos = 0 // = 0
	SWEP.IconLetter			= "t"
	SWEP.NoProperIronsights = true
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.ACOGDist = 5
	
	killicon.AddFont( "cstm_rif_famas", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VertGrip_Idle = {
		['v_weapon.Left_Ring01'] = {vector = Vector(0, 0, 0), angle = Angle(4.3810000419617, 36.924999237061, -22.386999130249)},
		['v_weapon.Left_Ring02'] = {vector = Vector(0, 0, 0), angle = Angle(0, -6.5999999046326, 0)},
		['v_weapon.Left_Index03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 62.868999481201, 0)},
		['v_weapon.Left_Pinky03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 43.581001281738, 0)},
		['v_weapon.Left_Hand'] = {vector = Vector(0, 0, 0), angle = Angle(22.16900062561, 4.7940001487732, 0)},
		['v_weapon.Left_Ring03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 29.85000038147, 0)},
		['v_weapon.Left_Thumb02'] = {vector = Vector(0, 0, 0), angle = Angle(4.6630001068115, -53.513000488281, 0)},
		['v_weapon.Left_Pinky02'] = {vector = Vector(0, 0, 0), angle = Angle(0, 26.288000106812, 0)},
		['v_weapon.Left_Index01'] = {vector = Vector(0, 0, 0), angle = Angle(0, 37.76900100708, -32.493999481201)},
		['v_weapon.Left_Thumb01'] = {vector = Vector(0, 0, 0), angle = Angle(-5.9749999046326, 3.0820000171661, -55.487998962402)},
		['v_weapon.Left_Pinky01'] = {vector = Vector(0, 0, 0), angle = Angle(16.731000900269, 4.938000202179, -9.3690004348755)},
		['v_weapon.Left_Middle01'] = {vector = Vector(0, 0, 0), angle = Angle(0, 41.89400100708, -19.375)},
		['v_weapon.Left_Thumb03'] = {vector = Vector(0, 0, 0), angle = Angle(0, -71.84400177002, 0)},
		['v_weapon.Left_Arm'] = {vector = Vector(3.5, -1, 2), angle = Angle(0, 31.180999755859, 127.78099822998)},
		['v_weapon.Left_Middle03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 12.305999755859, 0)} }
		
	SWEP.VElements = {
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(0.043, -3.918, 11.661), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(0.043, -3.675, 10.13), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.famas", pos = Vector(0.105, -0.494, 22.031), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "v_weapon.famas", pos = Vector(-0.195, 0.342, 4.818), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_weapon.famas", pos = Vector(-0.125, 1.924, 3.974), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(-0.32, -1.094, 16.924), angle = Angle(0, 90, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(-0.219, 2.855, 4.343), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "v_weapon.famas", rel = "", pos = Vector(0.037, 1.325, 16.805), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
	}
	
	SWEP.WElements = {
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.405, -1.953), angle = Angle(0, -90, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.5, -1.953), angle = Angle(0, -90, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22.653, 0.792, -7.18), angle = Angle(-100, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(16.5, 0.879, -3.61), angle = Angle(0, -90, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.648, 0.4, 0.962), angle = Angle(0, -90, 170), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.96, 0.749, -8.829), angle = Angle(0, -90, 170), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.496, 0.749, -8.195), angle = Angle(0, -90, 170), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.NoRail = true
	
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"auto", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_FAMAS.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 22
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 25
SWEP.Primary.Delay			= 0.066
SWEP.Primary.DefaultClip	= 25
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("weapons/m4a1/m4a1-1.wav")
SWEP.SilencedVolume = 75

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.6 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.8
SWEP.CurCone				= 0
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.004
SWEP.HipCone 				= 0.055
SWEP.InaccAff1 = 0.75
SWEP.SkipIdle = false
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.AimPos = Vector(-2.441, -3.116, 1.639)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(-4.622, -2.083, -0.224)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(-4.699, -1.875, 0)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(-4.699, -2.5, -0.78)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-4.72, -3.77, -0)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-4.709, -3.77, 0.093)
SWEP.RReflexAng = Vector(0, 0, 0)

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