if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.NoGL = true
	SWEP.NoDocter = true
	SWEP.NoVertGrip = false
	SWEP.NoBipod = false
	SWEP.RailType = 2
	
	SWEP.EoTechWithRail = true
	SWEP.DoesntDropRail = true
end

SWEP.BulletLength = 5.45
SWEP.CaseLength = 39

SWEP.MuzVel = 616.796

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint", "elcan", "acog"},
	[2] = {"vertgrip", "bipod"},
	[3] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}

if ( CLIENT ) then
	SWEP.PrintName			= "L85A2"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot = 3 //				= 2
	SWEP.SlotPos = 0 // = 0
	SWEP.IconLetter			= "b"
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.EoTechWithRail = true
	SWEP.ACOGDist = 6
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_l85a2")
	SWEP.DifType = true
	
	SWEP.LaserTune = {
		PosRight = 0,
		PosForward = 0,
		PosUp = 0.3,
		AngUp = -90,
		AngRight = 0,
		AngForward = 0 }
	
	SWEP.VertGrip_Idle = {
	['Bone24(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(0, -29.037000656128, 0)},
	['Bone23(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(0, -56.993999481201, 0)},
	['Bone01(mirrored)'] = {vector = Vector(6.5, 5.5, -5), angle = Angle(-43.111999511719, 68.949996948242, 43.512001037598)},
	['Bone10(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-54.319000244141, 0, 0)},
	['Bone18(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-49.25, 0, 0)},
	['Bone16(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-12.218999862671, 0, 0)},
	['Bone04(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-3.3369998931885, 11.081000328064, 0)},
	['Bone11(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(3.4619998931885, 0, 0)},
	['Bone07(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(6.1380000114441, 0, 0)},
	['Bone06(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-69.055999755859, 0, 0)},
	['Bone14(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-46.924999237061, 0, 0)},
	['Bone20(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-11.64999961853, 0, 0)},
	['Bone19(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(21.937000274658, 0, 0)},
	['Bone22(mirrored)'] = {vector = Vector(0, 0, 0), angle = Angle(-24.95599937439, 0, 0)} }
	
	killicon.Add( "cstm_rif_l85a2", "VGUI/kills/kill_l85a2", Color( 255, 80, 0, 255 ) )

	SWEP.VElements = {
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "Body", rel = "", pos = Vector(0.168, -1.02, -0.438), angle = Angle(0, 90, 0), size = Vector(0.899, 0.8, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "Body", rel = "", pos = Vector(0.3, 3.599, -4.908), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "Body", rel = "", pos = Vector(0.3, 3.599, -4.908), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "Body", rel = "", pos = Vector(-0.431, -23.282, -4.075), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "Body", rel = "", pos = Vector(0.037, -12.464, 0.337), angle = Angle(-180, 0, 90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "Body", rel = "", pos = Vector(-0.281, 8.5, -10.652), angle = Angle(4.443, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "Body", rel = "", pos = Vector(0, -15.306, -0.264), angle = Angle(0, 0, -90), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "Body", rel = "", pos = Vector(0.244, 4.394, -4.85), angle = Angle(0, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "Body", rel = "", pos = Vector(0.061, -12.306, -1.92), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "Body", rel = "", pos = Vector(-0.014, -3.664, 0.893), angle = Angle(0, -180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "Body", rel = "", pos = Vector(-0.019, -2.457, 0.787), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["rear"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "Body", rel = "", pos = Vector(2.22, 5.931, 1.937), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["front"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "Body", rel = "", pos = Vector(2.22, -2.869, 1.939), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.638, -0.044), angle = Angle(0, -90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(18.413, 1.131, -4.019), angle = Angle(-90, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/rail.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.413, 0.869, -3.905), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-5.401, 0.762, 0.081), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-5.401, 0.762, 0.081), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-6.331, 0.862, -0.051), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-10.414, 1.406, 5.769), angle = Angle(-4.444, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_rif_l85.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-6.757, 0.787, 1.562), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(14.381, 1.031, -1.889), angle = Angle(0, 90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.587, 1.087, -5.7), angle = Angle(0, -90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.732, 1.087, -5.975), angle = Angle(0, -90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	}
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.Category = "Extra Pack (ARs)"
SWEP.FireModes = {"auto", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_rif_l85.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_L85A2")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 22
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.098
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("CSTM_SilencedShot4")
SWEP.SilencedVolume = 75

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = "ak47_"
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.5 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 1
SWEP.CurCone				= 0
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.002
SWEP.HipCone 				= 0.056
SWEP.InaccAff1 = 0.75
SWEP.SkipIdle = false
SWEP.NoBoltAnim = true
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(2.559, 0, 1.01)
SWEP.AimAng = Vector(-0.5, -0.18, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(2.601, -0.985, 0.746)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(2.55, 0, 0.483)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(2.55, 0, -0.64)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.ELCANPos = Vector(2.55, 0, 0.45)
SWEP.ELCANAng = Vector(0, 0, 0)

SWEP.ELCAN_BackupPos = Vector(2.55, 0, -0.55)
SWEP.ELCAN_BackupAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(2.6, -0.985, 0.64)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(2.599, -3.444, 1.042)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(2.599, -2.787, 1.235)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.MeleePos = Vector(-4.47, -15.247, -0.24)
SWEP.MeleeAng = Vector(0, -130, 0)

SWEP.FlipOriginsPos = Vector(0.72, 0, -0.361)
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