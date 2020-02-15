SWEP.Base				= "cstm_base_shotgun"

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.NoAimpoint = true
	SWEP.NoACOG = true
	SWEP.NoDocter = true
	SWEP.DoesntDropRail = true
	SWEP.EoTechWithRail = true
	SWEP.RailType = 2
	
	SWEP.NoLaser = true
end

SWEP.BulletLength = 2
SWEP.CaseLength = 10.5
SWEP.DamageDecayMod = 3.68

SWEP.MuzVel = 339.894

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint", "elcan", "acog"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}
	
SWEP.AmmoTypes = {"magnum", "incendiary", "slug", "frag"}

if ( CLIENT ) then

	SWEP.PrintName			= "Franchi SPAS-12"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 2
	SWEP.SlotPos = 0 //			= 1
	SWEP.IconLetter			= "k"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.SparkEffect = "cstm_child_sparks_verylarge"
	SWEP.SmokeEffect = "cstm_child_smoke_verylarge"
	SWEP.DifType = true
	SWEP.EoTechWithRail = true
	SWEP.PitchMod = 0.3
	SWEP.RollMod = 0.3
	SWEP.IsShotgun = true
	SWEP.ACOGDist = 4.5
	SWEP.ELCANDist = 3
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_spas12")
	
	killicon.Add( "cstm_shotgun_spas12", "VGUI/kills/kill_spas12", Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Spas12_Body", rel = "", pos = Vector(-12.089, -3.356, -0.313), angle = Angle(90, 0, 90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "Spas12_Body", rel = "", pos = Vector(-12.089, -3.356, -0.313), angle = Angle(90, 0, 90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Spas12_Body", rel = "", pos = Vector(-12.634, -3.3, -0.207), angle = Angle(90, 0, 90), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Spas12_Body", rel = "", pos = Vector(-4.606, 2.007, 0), angle = Angle(90, 90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Spas12_Body", rel = "", pos = Vector(-7.132, -0.008, -0.225), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Spas12_Body", rel = "", pos = Vector(-6.475, 1.817, 0), angle = Angle(90, 90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Spas12_Body", rel = "", pos = Vector(-16.532, -9.638, 0.275), angle = Angle(0, -4.444, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.WElements = {
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.252, 0.416, 0.026), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.252, 0.416, 0.026), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.437, 0.708, -5.317), angle = Angle(0, -90, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.834, 0.586, 0), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_shot_francspas.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.719, 0.662, 0.375), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.874, 0.504, -3.313), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(8.654, 0.74, -5.054), angle = Angle(0, -90, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.HoldType			= "shotgun"
SWEP.Category			= "Extra Pack (Shotguns)"
SWEP.FireModes = {"pump"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_shot_francspas.mdl"
SWEP.WorldModel = "models/weapons/w_shot_francspas.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_SPAS12")
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 7
SWEP.Primary.NumShots		= 12
SWEP.Primary.Cone			= 0.12
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 1
SWEP.Primary.DefaultClip	= 8
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
SWEP.IncAmmoPerc = 0.34 -- Amount of time in seconds required to pass in order for the player to insert a shell
SWEP.CantSilence = true
SWEP.SkipIdle = true

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 4.5
SWEP.CurCone				= 0.12
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.PumpSound				= true
SWEP.IronsightsCone = 0.005
SWEP.HipCone = 0.06
SWEP.ClumpSpread = 0.007

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(2.907, 2.224, 2.039)
SWEP.AimAng = Vector(0.1, 0, 0)

SWEP.ReflexPos = Vector(2.898, 0, 0.941)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(2.92, -1.379, 1.261)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(2.898, -1.379, 1.386)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.ScopePos = Vector(2.884, -0.866, 1.177)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(2.89, 0.286, 0.9)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(2.89, 0.286, -0.1)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.ELCANPos = Vector(2.89, 0.286, 0.9)
SWEP.ELCANAng = Vector(0, 0, 0)

SWEP.ELCAN_BackupPos = Vector(2.89, 2, 0)
SWEP.ELCAN_BackupAng = Vector(0, 0, 0)

SWEP.FlipOriginsPos = Vector(1.36, 2.131, 0.28)
SWEP.FlipOriginsAng = Vector(0, 0, 0)

if CLIENT then
	function SWEP:CanUseBackUp()
		if self.VElements["acog"].color.a == 255 or self.VElements["elcan"].color.a == 255 then
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
		elseif self.VElements["elcan"].color.a == 255 then
			if self.AimPos == self.ELCAN_BackupPos then
				self.AimPos = self.ELCANPos
				self.AimAng = self.ELCANAng
			else
				self.AimPos = self.ELCAN_BackupPos
				self.AimAng = self.ELCAN_BackupAng
			end
		end
	end
end