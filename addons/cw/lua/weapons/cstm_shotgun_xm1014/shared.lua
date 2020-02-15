if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 2
SWEP.CaseLength = 10.5 -- this is just to make it so it has an effective range of about 50 meters, size doesn't matter here
SWEP.DamageDecayMod = 3.68

SWEP.MuzVel = 339.894

SWEP.Attachments = {
	[1] = {"eotech"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}
	
SWEP.AmmoTypes = {"magnum", "incendiary", "slug", "frag"}

if ( CLIENT ) then
	SWEP.PrintName			= "XM1014"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 2
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "B"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.SparkEffect = "cstm_child_sparks_verylarge"
	SWEP.SmokeEffect = "cstm_child_smoke_verylarge"
	SWEP.PitchMod = 0.3
	SWEP.RollMod = 0.3
	SWEP.IsShotgun = true
	
	killicon.AddFont( "cstm_shotgun_xm1014", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	
	SWEP.VElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "v_weapon.xm1014_Parent", pos = Vector(-0.207, -7.308, -6.519), angle = Angle(94.319, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", pos = Vector(21.738, 0, 6.711), angle = Angle(183, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.NoRail = true
	
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "shotgun"
SWEP.Base				= "cstm_base_shotgun"
SWEP.FireModes = {"semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_XM1014.Single")
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 5
SWEP.Primary.NumShots		= 12
SWEP.Primary.Cone			= 0.12
SWEP.Primary.ClipSize		= 7
SWEP.Primary.Delay			= 0.2
SWEP.Primary.DefaultClip	= 7
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12G"
SWEP.InitialHoldtype = "shotgun"
SWEP.InHoldtype = "shotgun"

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.15 -- Time in seconds until amount of ammo in shotgun increases
SWEP.CantSilence = true
SWEP.SkipIdle = true

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 5
SWEP.CurCone				= 0.12
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1.7 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.PumpSound				= true
SWEP.IronsightsCone = 0.007
SWEP.HipCone = 0.06
SWEP.ClumpSpread = 0.01

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(5.157, -3.444, 2.151)
SWEP.AimAng = Vector(-0.131, 0.794, 0)

SWEP.ReflexPos = Vector(5.184, -3.438, 1.21)
SWEP.ReflexAng = Vector(0, 0.856, 0)

SWEP.CustomizePos = Vector(-6.289, -5.328, -2.096)
SWEP.CustomizeAng = Vector(31.43, -35.975, -29.837)