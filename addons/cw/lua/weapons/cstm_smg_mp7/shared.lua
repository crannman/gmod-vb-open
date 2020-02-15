if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoDocter = true
	SWEP.NoACOG = true
	SWEP.NoAimpoint = true
	SWEP.DoesntDropRail = true
	SWEP.CantSilence = true
	
	SWEP.RequiresRail = false
end

SWEP.BulletLength = 4.6
SWEP.CaseLength = 30

SWEP.MuzVel = 475.720

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech"},
	[2] = {"laser"}}

SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}
	
if ( CLIENT ) then
	SWEP.PrintName			= "HK MP7"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 2
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "q"
	SWEP.Muzzle = "cstm_muzzle_smg"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	SWEP.SilenceTextOverride = "Pre-installed suppressor"
	SWEP.DifType = true
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_mp7")
	
	killicon.Add( "cstm_smg_mp7", "VGUI/kills/kill_mp7", Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", pos = Vector(9.605, 7.881, 0.25), angle = Angle(180, -4.444, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "body", rel = "", pos = Vector(-2.906, -3.806, -0.008), angle = Angle(90, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "body", rel = "", pos = Vector(-1.17, -3.556, 0.018), angle = Angle(90, 0, -90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "body", rel = "", pos = Vector(-4.795, -1.987, 0.805), angle = Angle(0, -90, -90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", pos = Vector(-6.712, 0.962, 6.394), angle = Angle(-4.444, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.531, 0.717, -5.196), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.425, 0.638, -5.475), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_smg_mp7.mdl", pos = Vector(-1.344, 0.375, 1.776), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.NoRail = true
	SWEP.Silenced = 1
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.Category = "Extra Pack (SMGs)"
SWEP.FireModes = {"auto", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_smg_mp7.mdl"
SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_MP7")
SWEP.Primary.Recoil			= 0.8
SWEP.Primary.Damage			= 18
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Delay			= 0.063
SWEP.Primary.DefaultClip	= 20
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "4.6x30MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedVolume = 70
SWEP.SilencedSound = Sound("CSTM_MP7")

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.6 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.PlaybackRate = 1.5

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.64
SWEP.CurCone				= 0.028
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1.1 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= true
SWEP.IronsightsCone			= 0.013
SWEP.HipCone 				= 0.04
SWEP.InaccAff1				= 0.45
SWEP.ConeInaccuracyAff1 = 0.55

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(2.94, -2.787, 1.491)
SWEP.AimAng = Vector(0.574, 0.006, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ReflexPos = Vector(2.98, -5.41, 0.85)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(2.953, -4.755, 1.235)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(2.953, -4.755, 1.11)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.FlipOriginsPos = Vector(1.639, 0, -0.08)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

util.PrecacheSound("weapons/mp7/mp7_magin.wav")
util.PrecacheSound("weapons/mp7/mp7_magout.wav")
util.PrecacheSound("weapons/mp7/mp7_charger.wav")
util.PrecacheSound("weapons/mp7/mp7_stockpull.wav")
util.PrecacheSound("weapons/mp7/mp7_switch.wav")
util.PrecacheSound("weapons/mp7/mp7-1.wav")