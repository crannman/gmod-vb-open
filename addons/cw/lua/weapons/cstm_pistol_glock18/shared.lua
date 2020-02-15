if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 9
SWEP.CaseLength = 19

SWEP.MuzVel = 255.905

SWEP.Attachments = {
	[1] = {"reflex"}}
	
SWEP.InternalParts = {
	[1] = {{key = "ergonomichandle"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "Glock 18"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "c"
	SWEP.ReloadAngleMod = -1
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_pistol_glock18", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.Glock_Parent", pos = Vector(-2.845, 3.2, -0.557), angle = Angle(92.43, 14.538, 1.187), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "v_weapon.Glock_Slide", pos = Vector(0.887, 0.125, 0.312), angle = Angle(-77.087, -89.825, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(10.404, 1.976, -3.8), angle = Angle(-91.904, 0, 5.664), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", pos = Vector(2.273, 1.1, -2.3), angle = Angle(180, 85, 0), size = Vector(1.299, 1.299, 1.299), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.SafeXMoveMod = 2
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"auto", "3burst", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_Glock.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 19
SWEP.Primary.Delay			= 0.0545
SWEP.Primary.DefaultClip	= 19
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoBoltAnim = true
SWEP.DryFireAnim = true
SWEP.SprintAndShoot = true

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = "glock_"
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.72 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.FOVZoom = 85

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.5
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone 		= 0.017
SWEP.HipCone 				= 0.045
SWEP.ConeInaccuracyAff1 = 0.5
SWEP.PlayFireAnim = true

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(4.335, -2.951, 2.875)
SWEP.AimAng = Vector(0.444, 0.019, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(4.335, -3.056, 2.553)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(4.487, -1.497, -5.277)
SWEP.MeleeAng = Vector(25.629, -30.039, 26.18)

SWEP.SafePos = Vector(-0.392, -10.157, -6.064)
SWEP.SafeAng = Vector(70, 0, 0)