if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 9
SWEP.CaseLength = 19

SWEP.MuzVel = 255.905

if ( CLIENT ) then

	SWEP.PrintName			= "Dual M9 Elites"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "s"
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	SWEP.ReposMyBones = true
	SWEP.BonesToRepos = {}
	SWEP.BonesToRepos["ValveBiped.Bip01_R_UpperArm"] = {ang = Angle(10, 0, 0)}
	SWEP.BonesToRepos["ValveBiped.Bip01_L_UpperArm"] = {ang = Angle(-30, -30, 60)}
	SWEP.BonesToRepos["ValveBiped.Bip01_L_Forearm"] = {ang = Angle(-10, 40, 0)}
	SWEP.BonesToRepos["ValveBiped.Bip01_L_Hand"] = {ang = Angle(0, 0, 40)}
	SWEP.BonesToRepos["ValveBiped.Bip01_L_Finger02"] = {ang = Angle(0, 30, 0)}
	SWEP.BonesToRepos["ValveBiped.Bip01_L_Finger1"] = {ang = Angle(-10, 20, 0)}
	
	killicon.AddFont( "cstm_pistol_dualelites", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.elite_right", rel = "", pos = Vector(0, -1.764, 5.787), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["silencer2"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.elite_left", rel = "", pos = Vector(0, -1.964, 5.787), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["weapon2"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(4.776, 1.962, -2.299), angle = Angle(0, -11.879, -12.129), size = Vector(0.949, 0.949, 0.949), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer2"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(12.192, 2.276, 3.821), angle = Angle(0, 77.235, 90.373), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.062, 2.358, -4.107), angle = Angle(0, -95.378, -93.03), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_pist_elite_single.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.728, 1.763, 2.15), angle = Angle(0.179, -4.998, -180), size = Vector(0.949, 0.949, 0.949), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.NoProperIronsights = true
	SWEP.SafeXMoveMod = 2
end

SWEP.Category = "Customizable Weaponry"
SWEP.Base				= "cstm_base_dual"
SWEP.FireModes = {"semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "duel"
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

SWEP.Primary.Sound			= Sound("Weapon_ELITE.Single")
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.145
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoBoltAnim = true
SWEP.ChamberAmount = 2

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.72 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.FOVZoom = 85

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
SWEP.IronsightsCone 		= 0.02
SWEP.HipCone 				= 0.038
SWEP.ConeInaccuracyAff1 = 0.5
SWEP.SprintAndShoot = true

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

SWEP.SafePos = Vector(0, -7.954, -8.11)
SWEP.SafeAng = Vector(70, 0, 0)

SWEP.CustomizePos = Vector(0, -7.954, -8.11)
SWEP.CustomizeAng = Vector(70, 0, 0)

SWEP.MeleePos = Vector(0.843, -0.956, 0.537)
SWEP.MeleeAng = Vector(0, 8.1, 0)

SWEP.NoFlipOriginsPos = Vector(0, 0, 0)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)
