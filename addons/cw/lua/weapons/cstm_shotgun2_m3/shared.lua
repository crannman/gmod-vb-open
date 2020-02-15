SWEP.Base				= "cstm_base_shotgun"

if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
	SWEP.EoTechWithRail = true
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
	SWEP.PrintName			= "M3 Super 90"			
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
	SWEP.ACOGDist = 4.5
	SWEP.IsShotgun = true
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_m3")
	--killicon.Add( "cstm_shotgun_m3cstm", "VGUI/kills/kill_m3", Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.508, -4.724, 5.984), angle = Angle(180, 180, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.322, -12.679, 0.8), angle = Angle(0, 0, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.322, -10.723, 0.944), angle = Angle(0, 0, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.556, -10.388, 2.747), angle = Angle(0, 90, 180), size = Vector(1, 0.6, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.063, -1.117, 11.258), angle = Angle(-4.444, 90, -180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.652, -5.154, 6.07), angle = Angle(0, 0, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "Spas_Body", rel = "", pos = Vector(-2.652, -5.154, 6.07), angle = Angle(0, 0, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.041, 0.876, -6.272), angle = Angle(0, -90, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_cstm_m3super90.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1.213, 0.734, 0), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.331, 0.651, -0.459), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(10.743, 0.889, -5.954), angle = Angle(0, -90, 180), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.445, 0.565, -0.872), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.445, 0.565, -0.872), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.734, 0.657, -4.218), angle = Angle(0, 0, 180), size = Vector(1, 0.75, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.866, 1.139, 5.412), angle = Angle(-4.444, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.HoldType			= "shotgun"
SWEP.Category			= "Extra Pack (Shotguns)"
SWEP.FireModes = {"pump"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.HoldType = "shotgun"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_cstm_m3super90.mdl"
SWEP.WorldModel = "models/weapons/v_shot_m3super90.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_M3")
SWEP.Primary.Recoil			= 5
SWEP.Primary.Damage			= 8
SWEP.Primary.NumShots		= 12
SWEP.Primary.Cone			= 0.12
SWEP.Primary.ClipSize		= 8
SWEP.Primary.Delay			= 0.85
SWEP.Primary.DefaultClip	= 8
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12G"
SWEP.InitialHoldtype = "shotgun"
SWEP.InHoldtype = "shotgun"

-- Animation speed/custom reload function related
SWEP.IdleAnimSpeed = 500
SWEP.IsReloading = false
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.25 -- Amount of time in seconds required to pass in order for the player to insert a shell
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
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.PumpSound				= true
SWEP.IronsightsCone = 0.005
SWEP.HipCone = 0.062
SWEP.ClumpSpread = 0.00675

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(-2.596, -3.664, 1.085)
SWEP.AimAng = Vector(-0.051, 0.1, 0)

SWEP.KobraPos = Vector(-2.6, -5.386, 0.439)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-2.6, -5.386, 0.642)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(-2.58, -5.386, 0.261)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.ScopePos = Vector(-2.563, -5.386, 0.28)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(-2.603, -3.816, 0.061)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(-2.603, -3.816, -0.96)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.ELCANPos = Vector(-2.603, -3.816, 0.02)
SWEP.ELCANAng = Vector(0, 0, 0)

SWEP.ELCAN_BackupPos = Vector(-2.603, -3.816, -0.87)
SWEP.ELCAN_BackupAng = Vector(0, 0, 0)

SWEP.NoFlipOriginsPos = Vector(-0.7, 0.4, 0.2)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

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