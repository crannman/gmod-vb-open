if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 9
SWEP.CaseLength = 19

SWEP.MuzVel = 255.905

SWEP.Attachments = {
	[1] = {"eotech", "aimpoint"},
	[2] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "HK MP5"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 2
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "x"
	SWEP.Muzzle = "cstm_muzzle_smg"
	SWEP.SparkEffect = "cstm_child_sparks_small"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_smg_mp5", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.MP5_Parent", pos = Vector(0, 2.986, 12.668), angle = Angle(0, 0, 0), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_weapon.MP5_Parent", pos = Vector(0.25, 0.674, 0.206), angle = Angle(180, 0, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotechdot"] = { type = "Sprite", sprite = "sprites/eotech_reddot", bone = "v_weapon.MP5_Parent", pos = Vector(0.136, 5.315, 5.288), size = { x = 0.7, y = 0.7 }, color = Color(255, 255, 255, 0), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false},
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "v_weapon.MP5_Parent", pos = Vector(-0.137, -7.54, -4.712), angle = Angle(95.237, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "v_weapon.MP5_Parent", pos = Vector(-0.057, 3.4, 5.6), angle = Angle(0, 0, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.MP5_Parent", rel = "", pos = Vector(0.474, 3.881, 11.468), angle = Angle(0, -90, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(25.393, 1.542, -9.329), angle = Angle(-100.503, -2.155, 0), size = Vector(0.043, 0.043, 0.136), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		//["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", pos = Vector(1.123, 0.574, -2.731), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.363, 0.479, -3.1), angle = Angle(180, 90, -10), size = Vector(0.85, 0.85, 0.85), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18.399, 0.529, 2), angle = Angle(175, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.908, 0.899, -8), angle = Angle(180, -92, 10), size = Vector(0.833, 0.833, 0.833), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"auto", "3burst", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_MP5Navy.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.075
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "9x19MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.ReloadAct = "reload1"

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.65 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.65
SWEP.CurCone				= 0.035
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1.5 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.01
SWEP.HipCone 				= 0.048
SWEP.InaccAff1 = 0.5
SWEP.ConeInaccuracyAff1 = 0.55

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(4.75, -4.099, 1.927)
SWEP.AimAng = Vector(1.019, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(4.699, -6.107, 1.467)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(4.751, -4.099, 1.547)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.CustomizePos = Vector(-6.289, -5.328, -2.096)
SWEP.CustomizeAng = Vector(31.43, -35.975, -29.837)