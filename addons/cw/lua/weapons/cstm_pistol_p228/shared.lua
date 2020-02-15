if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 9
SWEP.CaseLength = 19

SWEP.MuzVel = 255.905

SWEP.Attachments = {
	[1] = {"reflex"},
	[2] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "ergonomichandle"}},
	[2] = {{key = "burstconvert"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "P228"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "a"
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_pistol_p228", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.p228_Parent", pos = Vector(0.043, 2.888, 3.599), angle = Angle(0, 0, 0), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "v_weapon.p228_Slide", pos = Vector(-0.207, 0.337, 1.019), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.p228_Parent", rel = "", pos = Vector(0.081, 1.569, 3.2), angle = Angle(0, 180, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(9.404, 1.976, -4), angle = Angle(-91.904, 0, 5.664), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl",pos = Vector(1.363, 0.949, -1.364), angle = Angle(180, 85, 0), size = Vector(1.457, 1.457, 1.457), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.SafeXMoveMod = 2
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_P228.Single")
SWEP.Primary.Recoil			= 0.7
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.035
SWEP.Primary.ClipSize		= 13
SWEP.Primary.Delay			= 0.11
SWEP.Primary.DefaultClip	= 13
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoBoltAnim = true
SWEP.DryFireAnim = true

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.75 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.FOVZoom = 85

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.7
SWEP.CurCone				= 0.035
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.016
SWEP.HipCone 				= 0.041
SWEP.ConeInaccuracyAff1 = 0.5
SWEP.PlayFireAnim = true
SWEP.SprintAndShoot = true

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(4.751, -2.787, 2.871)
SWEP.AimAng = Vector(-0.42, 0.081, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(4.743, -2.951, 2.348)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(4.487, -1.497, -5.277)
SWEP.MeleeAng = Vector(25.629, -30.039, 26.18)

SWEP.SafePos = Vector(-0.392, -10.157, -6.064)
SWEP.SafeAng = Vector(70, 0, 0)