if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	
	SWEP.MaxAmmoMod = 0.25
end

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45

SWEP.MuzVel = 616.796

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint"},
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
	SWEP.ActToCyc = {}
	SWEP.ActToCyc["ACT_VM_DRAW"] = 0
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.88
	
	SWEP.PrintName			= "M249 Para"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 4
	SWEP.SlotPos = 0 //			= 3
	SWEP.IconLetter			= "z"
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.EoTechWithRail = true
	
	killicon.AddFont( "cstm_rif_m249", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VertGrip_Idle = {
		['v_weapon.Left_Ring01'] = {vector = Vector(0, 0, 0), angle = Angle(0, 23.39999961853, 0)},
		['v_weapon.Left_Index03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 84.65599822998, 0)},
		['v_weapon.Left_Index01'] = {vector = Vector(0, 0, 0), angle = Angle(0.73100000619888, 20.468999862671, 0)},
		['v_weapon.Left_Ring03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 60.325000762939, 0)},
		['v_weapon.Left_Pinky01'] = {vector = Vector(0, 0, 0), angle = Angle(-2.930999994278, 22.113000869751, 4.9629998207092)},
		['v_weapon.Left_Arm'] = {vector = Vector(-1.5, 0, 2), angle = Angle(15.956000328064, 23.856000900269, 112.125)},
		['v_weapon.Left_Pinky03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 43.256000518799, 0)},
		['v_weapon.Left_Hand'] = {vector = Vector(0, 0, 0), angle = Angle(33.375, 0, 0)},
		['v_weapon.Left_Thumb01'] = {vector = Vector(0, 0, 0), angle = Angle(6.2930002212524, -16.518999099731, -11.550000190735)},
		['v_weapon.Left_Thumb02'] = {vector = Vector(0, 0, 0), angle = Angle(0, -34.763000488281, 0)},
		['v_weapon.Left_Thumb03'] = {vector = Vector(0, 0, 0), angle = Angle(0, -73.724998474121, 0)},
		['v_weapon.Left_Middle03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 66.53099822998, 0)}}
		
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.m249", pos = Vector(0.101, -1.063, 22.312), angle = Angle(0, 0, 0), size = Vector(0.059, 0.059, 0.159), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-8.94, -0.131, 4.368), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-1.035, 0.082, -0.932), angle = Angle(0, -90, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-14.631, 0.328, 9.977), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-3.36, -0.163, 1.067), angle = Angle(0, 0, 180), size = Vector(1, 0.75, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "v_weapon.receiver", rel = "", pos = Vector(-2.735, 0.082, -0.778), angle = Angle(0, -90, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0.425, -1.152, 16.399), angle = Angle(180, 180, 0), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(-0.281, 3.375, 0.667), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "v_weapon.m249", rel = "", pos = Vector(0, 0.944, 16.693), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(30, 0, -4.533), angle = Angle(-87.695, 0, 0), size = Vector(0.059, 0.059, 0.159), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.838, 0.052, -6.6), angle = Angle(180, 90, 3), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.273, 0.699, -1.4), angle = Angle(180, 90, -9), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.628, 0.043, -6.492), angle = Angle(180, 90, 3), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.727, 0.779, -6.301), angle = Angle(-9.205, 0, -180), size = Vector(0.889, 0.889, 0.889), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20.454, 0.699, 3.45), angle = Angle(180, 0, 0), size = Vector(1.09, 1.09, 1.09), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.156, -0.306, 0.869), angle = Angle(0, -90, 180), size = Vector(0, 0, 0), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(23.326, 0, -2.181), angle = Angle(0, 90, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
	}
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"auto"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_M249.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 24
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 100
SWEP.Primary.Delay			= 0.0775
SWEP.Primary.DefaultClip	= 100
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
SWEP.IncAmmoPerc = 0.7 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.CantChamber = true
SWEP.ConeInaccuracyAff1 = 0.2

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
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.006
SWEP.HipCone 				= 0.07
SWEP.SkipIdle = true

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(-4.456, -0.985, 2.119)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(-4.423, -3.859, 1.315)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-4.448, -3.859, 1.399)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-4.43, -3.859, 1.567)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(-4.461, -3.859, 1.22)
SWEP.ReflexAng = Vector(0, 0, 0)