if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	SWEP.HasRail = true
	SWEP.NoDocter = true
	SWEP.DoesntDropRail = true
	SWEP.NoVertGrip = false
	
	SWEP.RequiresRail = false
	SWEP.NoLaser = true
	SWEP.NoBipod = false
end

SWEP.BulletLength = 7.62
SWEP.CaseLength = 51

SWEP.MuzVel = 557.741

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint", "elcan", "acog", "ballistic"},
	[2] = {"vertgrip", "grenadelauncher", "bipod"},
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
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.52
	
	SWEP.PrintName			= "M14 EBR"
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot = 4 //				= 3
	SWEP.SlotPos = 0 //			= 3
	SWEP.IconLetter			= "z"
	SWEP.DifType = true
	SWEP.SmokeEffect = "cstm_child_smoke_large"
	SWEP.SparkEffect = "cstm_child_sparks_large"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.ACOGDist = 6
	SWEP.BallisticDist = 4.5
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_m14")
	killicon.Add( "cstm_rif_m14ebr", "VGUI/kills/kill_m14", Color( 255, 80, 0, 255 ) )
	
	SWEP.VertGrip_Idle = {
		["Bip01 L Finger3"] = {vector = Vector(0, 0, 0), angle = Angle(7.847, -11.122, 9.029)},
		["Bip01 L Finger4"] = {vector = Vector(0, 0, 0), angle = Angle(10.013, -46.21, 5.519)},
		["Bip01 L Finger32"] = {vector = Vector(0, 0, 0), angle = Angle(0, 96.419, 0)},
		["Bip01 L Finger41"] = {vector = Vector(0, 0, 0), angle = Angle(0, 13.923, 0)},
		["Bip01 L Finger1"] = {vector = Vector(0, 0, 0), angle = Angle(7.061, 62.048, 19.615)},
		["Bip01 L Finger2"] = {vector = Vector(0, 0, 0), angle = Angle(10.904, 15.048, 10.253)},
		["Bip01 L UpperArm"] = {vector = Vector(1.82, -1.094, -1.308), angle = Angle(-23.269, -8.254, 48.487)},
		["Bip01 L Finger0"] = {vector = Vector(0, 0, 0), angle = Angle(16.545, 9.385, 0)},
		["Bip01 L Finger42"] = {vector = Vector(0, 0, 0), angle = Angle(0, 77.956, 0)},
		["Bip01 L Finger22"] = {vector = Vector(0, 0, 0), angle = Angle(0, 64.885, 0)},
		["Bip01 L Finger12"] = {vector = Vector(0, 0, 0), angle = Angle(0, 37.831, 0)},
		["Bip01 L Finger02"] = {vector = Vector(0, 0, 0), angle = Angle(0, 83.957, 0)},
		["Bip01 L Finger11"] = {vector = Vector(0, 0, 0), angle = Angle(0, -18.858, 0)},
		["Bip01 L Finger01"] = {vector = Vector(0, 0, 0), angle = Angle(0, 15.902, 0)},
		["Bip01 L Hand"] = {vector = Vector(0, 0, 0), angle = Angle(-9.334, 25.951, 19.15)}
	}
	
	SWEP.GrenadeLauncher_Idle = {
		["Bip01 L Finger4"] = {vector = Vector(0, 0, 0), angle = Angle(0, -28.1, 0)},
		["Bip01 L Finger41"] = {vector = Vector(0, 0, 0), angle = Angle(0, -15.388, 0)},
		["Bip01 L Finger2"] = {vector = Vector(0, 0, 0), angle = Angle(0, -7.209, 0)},
		["Bip01 L Finger02"] = {vector = Vector(0, 0, 0), angle = Angle(0, 14.467, 0)},
		["Bip01 L Finger42"] = {vector = Vector(0, 0, 0), angle = Angle(0, 32.63, 0)},
		["Bip01 L Finger32"] = {vector = Vector(0, 0, 0), angle = Angle(0, 53.669, 0)},
		["Bip01 L Finger22"] = {vector = Vector(0, 0, 0), angle = Angle(0, 49.236, 0)},
		["Bip01 L Finger31"] = {vector = Vector(0, 0, 0), angle = Angle(0, -15.502, 0)},
		["Bip01 L Finger21"] = {vector = Vector(0, 0, 0), angle = Angle(0, -56.855, 0)},
		["Bip01 L Finger11"] = {vector = Vector(0, 0, 0), angle = Angle(0, -48.238, 0)},
		["Bip01 L UpperArm"] = {vector = Vector(0.439, -0.857, -2.714), angle = Angle(0, 0, 0)},
		["Bip01 L Finger3"] = {vector = Vector(0, 0, 0), angle = Angle(0, -30.637, 0)}
	}

	SWEP.VElements = {
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.242, -4.685, -4.365), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "M14_Body", rel = "", pos = Vector(-1.517, -5.093, 1.843), angle = Angle(0, -90, 0), size = Vector(1.2, 1.2, 1.2), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "M14_Body", rel = "", pos = Vector(0, 14.041, 0.319), angle = Angle(0, 0, 90), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "M14_Body", rel = "", pos = Vector(0.01, 1.807, 1.289), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "M14_Body", rel = "", pos = Vector(0, 4.638, 1.49), angle = Angle(0, 0, 0), size = Vector(0.75, 0.75, 0.75), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.357, -3.681, -4.5), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grenadelauncher"] = { type = "Model", model = "models/wystan/attachments/m203.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.217, -5.074, -3.596), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.8), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.35, -3.681, -4.421), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.318, 12, -2.29), angle = Angle(0, 0, 0), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "M14_Body", rel = "", pos = Vector(0.287, -8.625, -10.195), angle = Angle(4.443, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "M14_Body", rel = "", pos = Vector(-0.626, 9, 0.768), angle = Angle(90, 0, -90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "M14_Body", rel = "", pos = Vector(-10.57, 6.512, -3.151), angle = Angle(0, 90, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(13.508, 0.544, -5.949), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.376, -0.731, -6.11), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(27.138, 0.564, -4.494), angle = Angle(-90, 0, 0), size = Vector(0.059, 0.059, 0.159), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11.489, 0.544, -5.554), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.804, 0.647, -2.01), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.231, 0.221, 0.159), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["grenadelauncher"] = { type = "Model", model = "models/wystan/attachments/m203.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.627, 0.402, -0.478), angle = Angle(0, -90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.231, 0.221, 0.159), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(19.19, 11.062, -0.545), angle = Angle(0, 0, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.81, 5.979), angle = Angle(-4.444, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.092, 0.317, 0.159), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_cstm_m14.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.658, 0.559, -0.942), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.NoRail = true
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.Category = "Extra Pack (BRs)"
SWEP.FireModes = {"semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_cstm_m14.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_M14")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 42
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.017
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 0.2
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "7.62x51MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("CSTM_SilencedShot2")
SWEP.SilencedVolume = 82

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.6 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.NoAuto = true
SWEP.PlaybackRate = 1.5

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 1.4
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 1.6 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.0015
SWEP.HipCone 				= 0.06
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

SWEP.AimPos = Vector(-2.231, -3.072, 1.218)
SWEP.AimAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(-2.231, -3.072, 0.14)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(-2.22, -3.072, 0.035)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.KobraPos = Vector(-2.231, -3.072, 0.181)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-2.231, -3.072, 0.377)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.BallisticPos = Vector(-2.224, -5.172, 0.105)
SWEP.BallisticAng = Vector(0, 0, 0)

SWEP.NoFlipOriginsPos = Vector(-0.84, 0, -0.32)
SWEP.NoFlipOriginsAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(-2.231, -3.072, -0.066)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(-2.224, -3.072, -1.188)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.ELCANPos = Vector(-2.224, -3.072, -0.196)
SWEP.ELCANAng = Vector(0, 0, 0)

SWEP.ELCAN_BackupPos = Vector(-2.224, -3.072, -1.165)
SWEP.ELCAN_BackupAng = Vector(0, 0, 0)

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