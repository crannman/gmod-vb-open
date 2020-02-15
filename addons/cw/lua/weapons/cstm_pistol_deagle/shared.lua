if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 12.7
SWEP.CaseLength = 32.6

SWEP.MuzVel = 261.154

SWEP.Attachments = {
	[1] = {"reflex"},
	[2] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "ergonomichandle"}},
	[2] = {{key = "burstconvert"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "Desert Eagle .50AE"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "f"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.SparkEffect = "cstm_child_sparks_large"
	SWEP.SmokeEffect = "cstm_child_smoke_large"
	
	killicon.AddFont( "cstm_pistol_deagle", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "v_weapon.Deagle_Slide", pos = Vector(-0.239, 0.574, 0.924), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.Deagle_Parent", rel = "", pos = Vector(0, 1.962, 4.138), angle = Angle(0, 0, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", pos = Vector(2.599, 0.99, -2), angle = Angle(180, 85, 0), size = Vector(1.401, 1.401, 1.401), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.SafeXMoveMod = 2
end

SWEP.Category = "Customizable Weaponry"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_DEagle.Single")
SWEP.Primary.Recoil			= 3
SWEP.Primary.Damage			= 43
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.25
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".50AE"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoAuto = true
SWEP.ACOGStatus = 0
SWEP.NoScopes = true
SWEP.CantSilence = true
SWEP.NoBoltAnim = true

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
SWEP.DefRecoil				= 3
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone 		= 0.013
SWEP.HipCone 				= 0.044
SWEP.ConeInaccuracyAff1 = 0.5
SWEP.PlayFireAnim = true
SWEP.DryFireAnim = true
SWEP.SprintAndShoot = true

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(5.139, -3.116, 2.678)
SWEP.AimAng = Vector(0.224, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(5.125, -3.089, 2.361)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(4.487, -1.497, -5.277)
SWEP.MeleeAng = Vector(25.629, -30.039, 26.18)

SWEP.SafePos = Vector(0.388, -10.157, -6.064)
SWEP.SafeAng = Vector(70, 0, 0)