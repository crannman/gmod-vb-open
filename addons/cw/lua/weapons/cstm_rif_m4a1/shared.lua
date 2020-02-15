if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoDocter = true
	SWEP.DoesntDropRail = true
	SWEP.NoVertGrip = false
	SWEP.NoCMag = false
	SWEP.NoGL = false
	SWEP.DifferentSilencer = true
	SWEP.NoBipod = false
end

SWEP.BulletLength = 5.56
SWEP.CaseLength = 45

SWEP.MuzVel = 616.796

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint", "elcan", "acog"},
	[2] = {"vertgrip", "grenadelauncher", "bipod"},
	[3] = {"cmag"},
	[4] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}

if ( CLIENT ) then
	SWEP.ActToCyc = {}
	SWEP.ActToCyc["ACT_VM_DRAW"] = 0.5
	SWEP.ActToCyc["ACT_VM_DRAW_SILENCED"] = 0
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.8
	SWEP.ActToCyc["ACT_VM_RELOAD_SILENCED"] = 0.8
	SWEP.ActToCyc["ACT_VM_ATTACH_SILENCER"] = 0.65
	SWEP.ActToCyc["ACT_VM_DETACH_SILENCER"] = 0.5
	
	SWEP.OffsetBones = {}
	SWEP.TargetOffset = {}

	SWEP.PrintName			= "M4A1"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot = 3 //				= 3
	SWEP.SlotPos = 0 //			= 3
	SWEP.IconLetter			= "z"
	SWEP.NoRail = true
	SWEP.InitialDraw = true
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_m4a1")
	SWEP.RollMod = 0.5
	SWEP.ACOGDist = 7
	
	SWEP.GrenadeLauncher_Idle = {
		['Left_L_Arm'] = {vector = Vector(1.8, 0, 2), angle = Angle(0, 0, 0)},
		['Left1'] = {vector = Vector(0, 0, 0), angle = Angle(5.1939997673035, -13.812999725342, 0)},
		['Left2'] = {vector = Vector(0, 0, 0), angle = Angle(0, 11.069000244141, 0)} }
	
	SWEP.GrenadeLauncher_Active = {
		['Left_L_Arm'] = {vector = Vector(-2, 3, 4), angle = Angle(0, -8.6440000534058, 89.849998474121)},
		['Left1'] = {vector = Vector(0, 0, 0), angle = Angle(-7.8249998092651, 0, 0)},
		['Left4'] = {vector = Vector(0, 0, 0), angle = Angle(18.312999725342, -1.5119999647141, 0)},
		['Left7'] = {vector = Vector(0, 0, 0), angle = Angle(14.437999725342, 3.319000005722, 0)},
		['Left10'] = {vector = Vector(0, 0, 0), angle = Angle(7.3629999160767, 0, 0)},
		['Left13'] = {vector = Vector(0, 0, 0), angle = Angle(-8.581000328064, 0, 0)} }
		
	
	SWEP.PitchMod = -0.5
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.Muzzle = "cstm_muzzle_ar"
	
	SWEP.VertGrip_Idle = {
		['Left_L_Arm'] = {vector = Vector(1.2, -0.2, 1.6), angle = Angle(0, 0, 90)},
		['Left4'] = {vector = Vector(0, -0.15000000596046, 0), angle = Angle(60.14400100708, -13.27499961853, 0)},
		['Left5'] = {vector = Vector(0, 0, 0), angle = Angle(19.218999862671, -3.8310000896454, 0)},
		['Left7'] = {vector = Vector(0, 0, 0), angle = Angle(42.444000244141, -8.8680000305176, 0)},
		['Left9'] = {vector = Vector(0, 0, 0), angle = Angle(13.449999809265, 0, 0)},
		['Left10'] = {vector = Vector(0, 0, 0), angle = Angle(31.812000274658, -1.3999999761581, 0)},
		['Left12'] = {vector = Vector(0, 0, 0), angle = Angle(24.488000869751, 0, 0)},
		['Left13'] = {vector = Vector(0, 0, 0), angle = Angle(19.91900062561, 0, 0)},
		['Left1'] = {vector = Vector(0, 0, 0), angle = Angle(27.77499961853, 0.98199999332428, 0)},
		['Left2'] = {vector = Vector(0, 0, 0), angle = Angle(0, 23.14999961853, 0)},
		['Left3'] = {vector = Vector(0, 0, 0), angle = Angle(0, 44.89400100708, 0)} }
	
	SWEP.CMag_Idle = {
	['Left_L_Arm'] = {vector = Vector(3, 0.5, 2.75), angle = Angle(22.937000274658, 0, 0)},
	['Left7'] = {vector = Vector(0, 0, 0), angle = Angle(-7.0689997673035, 0, 0)},
	['Left10'] = {vector = Vector(0, 0, 0), angle = Angle(-9.0069999694824, 0, 0)},
	['Left13'] = {vector = Vector(0, 0, 0), angle = Angle(-12.675999641418, 0, 0)} }
	
	SWEP.OtherBone = "|*M4| - Carry Handle"
	SWEP.MagBone = "|*M4| - Magazine"
	
	killicon.Add( "cstm_rif_m4a1", "VGUI/kills/kill_m4a1", Color( 255, 80, 0, 255 ) )
	
	SWEP.VElements = {
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.425, 2.062, 13.225), angle = Angle(-4.444, 90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-2.106, -3.056, 7.407), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-2.106, -3.056, 7.407), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.683, -9.344, 1.769), angle = Angle(0, 0, 180), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.907, -2.337, 7.381), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-12.275, -15.818, 5.263), angle = Angle(0, -90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cmag"] = { type = "Model", model = "models/wystan/cmag.mdl", bone = "|*M4| - Magazine", rel = "", pos = Vector(-1.788, -6.257, 5.343), angle = Angle(0, 90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grenadelauncher"] = { type = "Model", model = "models/wystan/attachments/m203.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.856, -4.401, 6.057), angle = Angle(0, 0, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-0.806, -13.476, 1.899), angle = Angle(0, 0, 90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.731, -17.768, 4.125), angle = Angle(0, 180, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "|*M4| - Receiver", rel = "", pos = Vector(-1.706, -11.113, 1.462), angle = Angle(180, -180, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(15.975, 16.618, -0.445), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.375, 1.781, 3.957), angle = Angle(-4.444, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.118, 1.187, -1.994), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.118, 1.187, -1.994), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.288, 1.319, -1.951), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_rif_m4cu.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.668, 0.999, -0.245), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.781, 1.519, -7.789), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.762, 1.511, -8.207), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grenadelauncher"] = { type = "Model", model = "models/wystan/attachments/m203.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.049, 0.805, -0.164), angle = Angle(180, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(17.85, 1.574, -2.731), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} }
	}
	
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_xtra_pistol"
SWEP.Category = "Extra Pack (ARs)"
SWEP.FireModes = {"auto", "3burst", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_rif_m4cu.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_M4A1")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 22
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.063
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("CSTM_SilencedShot4")
SWEP.SilencedVolume = 75

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.PlaybackRate = 2
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.55 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.IncAmmoPercSil = 0.6

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 0.9
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.0025
SWEP.HipCone 				= 0.065
SWEP.InaccAff1 = 0.75
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "40MM_HE"
SWEP.Secondary.ClipSize = 1
SWEP.Secondary.DefaultClip	= 0

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(-2.895, -3.319, 0.547)
SWEP.AimAng = Vector(0.079, 0, -0.327)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(-2.846, -2.488, 0.568)
SWEP.ScopeAng = Vector(0, 0.2, 0)

SWEP.NoFlipOriginsPos = Vector(-1.16, 0, -0.16)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(-2.89, -1.311, 0.6)
SWEP.ReflexAng = Vector(-0.814, 0, 0)

SWEP.KobraPos = Vector(-2.892, -2.787, 0.712)
SWEP.KobraAng = Vector(-0.583, 0, 0)

SWEP.ACOGPos = Vector(-2.952, -0.5, 0.268)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(-2.952, -0.5, -0.85)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.ELCANPos = Vector(-2.952, -0.5, 0.25)
SWEP.ELCANAng = Vector(0, 0, 0)

SWEP.ELCAN_BackupPos = Vector(-2.952, -0.5, -0.76)
SWEP.ELCAN_BackupAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-2.902, -1.469, 1.039)
SWEP.RReflexAng = Vector(-1.724, 0, 0)

SWEP.CustomizePos = Vector(8.173, -4.106, -0.895)
SWEP.CustomizeAng = Vector(30.736, 40.667, 28.569)

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
