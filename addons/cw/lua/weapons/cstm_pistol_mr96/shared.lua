if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoAimpoint = true
	SWEP.NoEOTech = true
	SWEP.HasMasher = true
	
	SWEP.RequiresRail = false
end

SWEP.BulletLength = 9.1
SWEP.CaseLength = 33

SWEP.MuzVel = 321.521

SWEP.Attachments = {
	[1] = {"reflex", "acog"},
	[2] = {"laser"}}

if ( CLIENT ) then

	SWEP.PrintName			= "MR96"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 1
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "f"
	SWEP.DifType = true
	SWEP.PitchMod = 1
	SWEP.DrawAngleMod = 0.5
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.SparkEffect = "cstm_child_sparks_large"
	SWEP.SmokeEffect = "cstm_child_smoke_large"
	SWEP.ACOGDist = 6
	SWEP.AimpointDist = 11
	SWEP.SafeXMoveMod = 2
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_mr96")
	killicon.Add( "cstm_pistol_mr96", "VGUI/kills/kill_mr96", Color( 255, 80, 0, 255 ) )

	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "NOT SMDIMPORT :D", rel = "", pos = Vector(4.33, -17.351, -2.563), angle = Angle(0, 0, -90), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "NOT SMDIMPORT :D", rel = "", pos = Vector(4.63, -6.42, -7.051), angle = Angle(0, 180, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "NOT SMDIMPORT :D", rel = "", pos = Vector(4.35, -16.901, -3.681), angle = Angle(-180, 0, 90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "NOT SMDIMPORT :D", rel = "", pos = Vector(4.067, -11.27, -1.945), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["reflex"] = { type = "Model", model = "models/wystan/attachments/2octorrds.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.563, 1.299, -5.182), angle = Angle(0, 90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.544, 0.744, -0.044), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.869, 1.143, -4.382), angle = Angle(-90, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_pist_demr96.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.438, 0.481, 0.218), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.Category = "Extra Pack (Sidearms)"
SWEP.FireModes = {"double"}
SWEP.AmmoTypes = {"hp", "ap", "incendiary", "birdshot"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "pistol"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_pist_demr96.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_MR96")
SWEP.Primary.Recoil			= 2.5
SWEP.Primary.Damage			= 36
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 6
SWEP.Primary.Delay			= 0.27
SWEP.Primary.DefaultClip	= 6
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".357"
SWEP.InitialHoldtype = "pistol"
SWEP.InHoldtype = "pistol"
SWEP.NoBoltAnim = true
SWEP.SilencedSound = Sound("CSTM_SilencedShot2")
SWEP.SilencedVolume = 80
SWEP.DryFireAnim = true
SWEP.SprintAndShoot = true

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.72 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.CantChamber = true
SWEP.SkipIdle = true
SWEP.PlaybackRate = 2
SWEP.FOVZoom = 85

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 2.7
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone 		= 0.011
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

SWEP.AimPos = Vector(2.75, -1.149, 1.177)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(2.769, -1.938, 0.819)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(2.749, -5, 0.1)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(2.749, -5, -0.91)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.FlipOriginsPos = Vector(1.12, 2.786, 0.119)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(4.487, -1.497, -5.277)
SWEP.MeleeAng = Vector(25.629, -30.039, 26.18)

if CLIENT then
	function SWEP:CanUseBackUp()
		if self.VElements["acog"].color.a == 255 then
			return true
		end
		
		return false
	end
	
	function SWEP:UseBackUp()
		if self.VElements["acog"].color.a == 255 then
			if self.AimPos == self.ACOG_BackupPos then
				self.AimPos = self.ACOGPos
				self.AimAng = self.ACOGAng
			else
				self.AimPos = self.ACOG_BackupPos
				self.AimAng = self.ACOG_BackupAng
			end
		end
	end
end