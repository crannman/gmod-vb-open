if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45

SWEP.MuzVel = 616.796

SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}

if ( CLIENT ) then

	SWEP.PrintName			= "SIG SG550"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 5
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "o"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_small"
	
	killicon.AddFont( "cstm_sniper_sg550", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.sg550_Parent", pos = Vector(0, 3.506, 27.861), angle = Angle(0, 0, 0), size = Vector(0.07, 0.07, 0.18), color = Color(255, 255, 255, 1), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", pos = Vector(31.913, 0.875, -8.089), angle = Angle(-100.158, 0, 0), size = Vector(0.07, 0.07, 0.18), color = Color(255, 255, 255, 1), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} }
	}
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_sniper"
SWEP.FireModes = {"auto", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_snip_sg550.mdl"
SWEP.WorldModel = "models/weapons/w_snip_sg550.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_SG550.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 25
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.085
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"

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
SWEP.DefRecoil				= 1.2
SWEP.DefCone				= 0.0002
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false

SWEP.IronsightsCone			= 0.0001
SWEP.HipCone = 0.06

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(5.599, -4.92, 1.879)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)
