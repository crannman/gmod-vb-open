if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoEOTech = true
	SWEP.NoDocter = true
	
	SWEP.RequiresRail = false
end

SWEP.BulletLength = 9
SWEP.CaseLength = 19

SWEP.MuzVel = 255.905

SWEP.Attachments = {
	[1] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "ergonomichandle"}},
	[2] = {{key = "burstconvert"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "Beretta 92FS"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "c"
	SWEP.DifType = true
	SWEP.Muzzle = "cstm_muzzle_pistol"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	SWEP.SafeXMoveMod = 2
	
	SWEP.LaserTune = {
		PosRight = 0,
		PosForward = 0,
		PosUp = 0,
		AngUp = -90,
		AngRight = 0,
		AngForward = 0 }
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_m92fs")
	killicon.Add( "cstm_pistol_m92fs", "VGUI/kills/kill_m92fs", Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "Bitch_Controller", rel = "", pos = Vector(0.086, -2.082, 3.706), angle = Angle(0, 0, -90), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "Bitch_Controller", rel = "", pos = Vector(0.112, -0.681, 2.851), angle = Angle(0, 180, -90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "weapon", pos = Vector(10.944, -0.564, 3.842), angle = Angle(-90, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_pist_beretta92.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.519, 1.625, 0.356), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.Category = "Extra Pack (Sidearms)"
SWEP.FireModes = {"semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_beretta92.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_92FS")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 15
SWEP.Primary.Delay			= 0.15
SWEP.Primary.DefaultClip	= 15
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9x19MM"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoBoltAnim = true
SWEP.DryFireAnim = true
SWEP.SprintAndShoot = true

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
SWEP.DefRecoil				= 0.5
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 0.95 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone 		= 0.014
SWEP.HipCone 				= 0.04
SWEP.ConeInaccuracyAff1 = 0.5
SWEP.PlayFireAnim = true

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(2.773, -1.157, 1.529)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(4.324, -3.056, 2.563)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.FlipOriginsPos = Vector(1.36, 0, -0.52)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

SWEP.SafePos = Vector(-1.149, -10.82, -6.722)
SWEP.SafeAng = Vector(70, 0, 0)

SWEP.MeleePos = Vector(4.487, -1.497, -5.277)
SWEP.MeleeAng = Vector(25.629, -30.039, 26.18)

util.PrecacheSound("weapons/makarov/maginscratch.wav")
util.PrecacheSound("weapons/makarov/magout.wav")
util.PrecacheSound("weapons/makarov/magintap.wav")
util.PrecacheSound("weapons/makarov/makarov-1.wav")
util.PrecacheSound("weapons/makarov/slideback.wav")
util.PrecacheSound("weapons/makarov/slideforward.wav")
util.PrecacheSound("weapons/makarov/sliderelease.wav")