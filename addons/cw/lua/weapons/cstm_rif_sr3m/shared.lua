if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoDocter = true
	SWEP.NoACOG = true
	
	SWEP.RequiresRail = false
end
SWEP.UseHands = true
SWEP.BulletLength = 5.45
SWEP.CaseLength = 39

SWEP.MuzVel = 209.973

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint"},
	[2] = {"vertgrip"},
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
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.6
	
	SWEP.PrintName			= "SR-3M Vikhr"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot = 3 //				= 3
	SWEP.SlotPos = 0 //			= 3
	SWEP.IconLetter			= "z"
	SWEP.DifType = true
	SWEP.PitchMod = -1
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.EoTechWithRail = true
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_sr3m")
	killicon.Add( "cstm_rif_sr3m", "VGUI/kills/kill_sr3m", Color( 255, 80, 0, 255 ) )
	
	SWEP.VertGrip_Idle = {
		["L_Ring1"] = {vector = Vector(0, 0, 0), angle = Angle(-4.663, -3.128, -15.759)},
		["L_Pinky2"] = {vector = Vector(0, 0, 0), angle = Angle(-9.985, 0, 0)},
		["L_Pinky3"] = {vector = Vector(0, 0, 0), angle = Angle(35.334, 0, 0)},
		["L_Mid3"] = {vector = Vector(0, 0, 0), angle = Angle(46.601, 0, 0)},
		["L_Index1"] = {vector = Vector(0, 0, 0), angle = Angle(20.951, 0, 0)},
		["L_Thumb3"] = {vector = Vector(0, 0, 0), angle = Angle(0, 61.23, 0)},
		["L_Ring3"] = {vector = Vector(0, 0, 0), angle = Angle(49.523, 0, 0)},
		["L_Index2"] = {vector = Vector(0, 0, 0), angle = Angle(40, 0, 0)},
		["L_Mid2"] = {vector = Vector(0, 0, 0), angle = Angle(9.642, 0, 0)},
		["L_Mid1"] = {vector = Vector(0, 0, 0), angle = Angle(19.429, -2.56, -14.556)},
		["L_Index3"] = {vector = Vector(0, 0, 0), angle = Angle(57.143, 0, 0)},
		["L_Thumb1"] = {vector = Vector(0, 0, 0), angle = Angle(7.028, 10.659, 0)},
		["L_Pinky1"] = {vector = Vector(0, 0, 0), angle = Angle(-32.163, -4.665, -13.153)},
		["L_Forearm"] = {vector = Vector(-0.942, -0.11, 1.804), angle = Angle(0, 0, 104.762)},
		["L_Wrist"] = {vector = Vector(0, 0, 0), angle = Angle(16.624, 0, 0)}}
		
	SWEP.VElements = {
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Gun", rel = "", pos = Vector(-2.513, 6.724, 0.611), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Gun", rel = "", pos = Vector(-2.033, 11.85, -4.369), angle = Angle(90, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "Gun", rel = "", pos = Vector(-2.494, 2, 6.7), angle = Angle(0, 0, -90), size = Vector(0.8, 1, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "Gun", pos = Vector(-2.326, 2.519, 17.656), angle = Angle(0, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "Gun", rel = "", pos = Vector(-1.632, 1.575, 12.824), angle = Angle(0, 0, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Gun", rel = "", pos = Vector(-2.313, 0.88, 9.48), angle = Angle(0, 0, -90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Gun", rel = "", pos = Vector(-2.313, 1.093, 8.005), angle = Angle(0, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Gun", rel = "", pos = Vector(-2.753, 5.748, 3.263), angle = Angle(0, 0, -90), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-3.326, 1.544, 6.175), angle = Angle(-4.444, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.505, 1.055, 0.381), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.919, 1.019, -3.451), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(20.767, 1.274, -3.225), angle = Angle(-90, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_rif_sr-3m.mdl", pos = Vector(-0.419, 0.981, -0.014), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.088, 1.243, -5.077), angle = Angle(0, -90, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.444, 1.243, -5.59), angle = Angle(0, -90, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.Category = "Extra Pack (ARs)"
SWEP.FireModes = {"auto", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_rif_sr-3m.mdl"
SWEP.WorldModel = "models/weapons/w_rif_galil.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_SR3M")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 29
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.066
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x39MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("CSTM_SilencedShot5")
SWEP.SilencedVolume = 78

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.6 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.PlaybackRate = 2

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.95
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1.4 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.007
SWEP.HipCone 				= 0.04
SWEP.InaccAff1 = 0.55
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(-2.256, -1.795, 0.621)
SWEP.AimAng = Vector(1.156, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(-2.192, -1.149, -0.04)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(-2.231, -1.149, 0.01)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-2.264, -0.82, 0.104)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-2.25, -0.82, 0.365)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.CustomizePos = Vector(5, -4.401, -4.546)
SWEP.CustomizeAng = Vector(21.774, 49.832, 0)

SWEP.NoFlipOriginsPos = Vector(-1.4, 0, -0.801)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

util.PrecacheSound("weapons/sr3m/sr3m_clipout.wav")
util.PrecacheSound("weapons/sr3m/sr3m_clipin.wav")
util.PrecacheSound("weapons/sr3m/sr3m_boltpull.wav")
util.PrecacheSound("weapons/sr3m/sr3m-1.wav")
util.PrecacheSound("weapons/sr3m/draw.wav")