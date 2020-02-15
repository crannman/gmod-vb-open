if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 8.58
SWEP.CaseLength = 69.20

SWEP.MuzVel = 557.741

SWEP.Attachments = {
	[1] = {"kobra", "riflereflex", "eotech", "aimpoint", "elcan", "acog", "ballistic"},
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
	SWEP.ActToCyc = {}
	SWEP.ActToCyc["ACT_VM_DRAW"] = 0
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.9
	SWEP.ActToCyc["ACT_VM_ATTACH_SILENCER"] = 0.8
	SWEP.ActToCyc["ACT_VM_DETACH_SILENCER"] = 0.8
	
	SWEP.PrintName			= "M98B"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot = 4 //				= 3
	SWEP.SlotPos = 0 //			= 3
	SWEP.IconLetter			= "z"
	SWEP.SmokeEffect = "cstm_child_smoke_large"
	SWEP.SparkEffect = "cstm_child_sparks_large"
	SWEP.Muzzle = "cstm_muzzle_br"
	SWEP.ACOGDist = 5
	SWEP.BallisticDist = 4.8
	SWEP.SemiText = "Bolt-action"
	SWEP.ViewMoveWhenFiring = true
	
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/kills/kill_m98b")
	SWEP.DifType = true
	killicon.Add( "cstm_rif_m98", "VGUI/kills/kill_m98b", Color( 255, 80, 0, 255 ) )
	
	SWEP.VertGrip_Idle = {
		['l-pinky-tip'] = {vector = Vector(0, 0, 0), angle = Angle(74.081001281738, 0, 0)},
		['l-ring-tip'] = {vector = Vector(0, 0, 0), angle = Angle(71.34400177002, 0, 0)},
		['l-pinky-low'] = {vector = Vector(0, 0, 0), angle = Angle(-12.755999565125, 0, 0)},
		['l-thumb-low'] = {vector = Vector(0, 0, 0), angle = Angle(6.7439999580383, -13.963000297546, 0)},
		['l-thumb-tip'] = {vector = Vector(0, 0, 0), angle = Angle(55.206001281738, 0, 0)},
		['l-index-mid'] = {vector = Vector(0, 0, 0), angle = Angle(39.474998474121, 0, 0)},
		['l-thumb-mid'] = {vector = Vector(0, 0, 0), angle = Angle(38.224998474121, -5.5560002326965, 0)},
		['l-middle-tip'] = {vector = Vector(0, 0, 0), angle = Angle(38.861999511719, 10.480999946594, 8.7559995651245)},
		['l-ring-low'] = {vector = Vector(0, 0, 0), angle = Angle(18.393999099731, 0, 0)},
		['lwrist'] = {vector = Vector(0, 0, 0), angle = Angle(-1.2059999704361, 41.131000518799, 0.88099998235703)},
		['l-forearm'] = {vector = Vector(-2.3, 0.4, -0.5), angle = Angle(-7.8369998931885, -23.569000244141, 98.680999755859)},
		['l-middle-low'] = {vector = Vector(0, 0, 0), angle = Angle(35.437999725342, 0, 0)},
		['l-index-low'] = {vector = Vector(0, 0, 0), angle = Angle(83.41300201416, -3.1679999828339, -9.326000213623)},
		['l-ring-mid'] = {vector = Vector(0, 0, 0), angle = Angle(-7.4569997787476, 0, 0)},
		['l-pinky-mid'] = {vector = Vector(0, 0, 0), angle = Angle(14.505999565125, 0, 0)}}
		
	SWEP.ActToCyc = {}
	SWEP.ActToCyc["ACT_VM_DRAW"] = 0
	SWEP.ActToCyc["ACT_VM_RELOAD"] = 0.85
	
	SWEP.LaserTune = {
		PosRight = 0,
		PosForward = 0,
		PosUp = 0,
		AngUp = -90,
		AngRight = 0,
		AngForward = 0 }
		
	SWEP.VElements = {
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "body", rel = "", pos = Vector(0.4, 1.649, 1.713), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "body", rel = "", pos = Vector(0.4, 3.18, 1.981), angle = Angle(0, 0, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "body", rel = "", pos = Vector(0.025, -2.05, -3.901), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "body", rel = "", pos = Vector(0.025, -2.05, -3.901), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "body", rel = "", pos = Vector(-0.86, -4, 2.342), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "body", rel = "", pos = Vector(0.425, 11.3, -0.332), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "body", rel = "", pos = Vector(0.688, -8.613, -9.625), angle = Angle(4.443, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "body", rel = "", pos = Vector(0.381, 23.356, 0.962), angle = Angle(0, 0, 90), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "body", rel = "", pos = Vector(1.23, 10.149, 0.931), angle = Angle(-90, 0, -90), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "body", rel = "", pos = Vector(0.03, -2.257, -1.826), angle = Angle(0, 0, 0), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "body", rel = "", pos = Vector(0.168, -4.244, -3.869), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["front"] = { type = "Model", model = "models/bunneh/frontsight.mdl", bone = "body_mesh", rel = "", pos = Vector(-1.777, 2.273, 2.907), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
        ["rear"] = { type = "Model", model = "models/bunneh/rearsight.mdl", bone = "body_mesh", rel = "", pos = Vector(-1.859, -7.371, 2.907), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.061, 1.429, -5.901), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["riflereflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.137, 1.429, -6.17), angle = Angle(0, -90, 180), size = Vector(0.899, 0.899, 0.899), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.062, 1.093, -0.45), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["elcan"] = { type = "Model", model = "models/bunneh/elcan.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.062, 1.093, -0.45), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["ballistic"] = { type = "Model", model = "models/bunneh/scope01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.162, 0.03, -6.564), angle = Angle(0, 0, 180), size = Vector(1.1, 1.1, 1.1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["bipod"] = { type = "Model", model = "models/wystan/attachments/bipod.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(22.173, 1.35, -3.151), angle = Angle(0, 90, -180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {[1] = 1} },
		["eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-4.238, 1.694, 5.493), angle = Angle(-4.444, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(40, 1.455, -4.713), angle = Angle(-90, 0, 0), size = Vector(0.07, 0.07, 0.17), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.08, 1.006, -1.456), angle = Angle(0, -90, 180), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.195, 1.192, -0.364), angle = Angle(0, -90, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = true, material = "", skin = 0, bodygroup = {} },
		["weapon"] = { type = "Model", model = "models/weapons/w_snip_m98.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.175, 1.156, -1.839), angle = Angle(0, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

	SWEP.NoRail = true
end

SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_sniper3"
SWEP.Category = "Extra Pack (SRs)"
SWEP.FireModes = {"bolt"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/v_snip_m98.mdl"
SWEP.WorldModel = "models/weapons/v_snip_m98.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("CSTM_M98B")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 100
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 10
SWEP.Primary.Delay			= 1.5
SWEP.Primary.DefaultClip	= 10
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("CSTM_SilencedShot2")
SWEP.SilencedVolume = 78
SWEP.NoAuto = true
SWEP.UnAimAfterShot = true

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.NoBoltAnim = true
SWEP.AnimPrefix = ""
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.8 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased
SWEP.PlaybackRate = 1

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 6
SWEP.CurCone				= 0.04
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.0001
SWEP.HipCone 				= 0.045
SWEP.InaccAff1 = 0.75
SWEP.ConeInaccuracyAff1 = 0.7
SWEP.PlayFireAnim = true

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(-3.221, -1.181, 0.14)
SWEP.AimAng = Vector(-0.5, -0.2, 0)

SWEP.KobraPos = Vector(-3.215, -3.608, 0.2)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.RReflexPos = Vector(-3.197, -3.608, 0.244)
SWEP.RReflexAng = Vector(0, 0, 0)

SWEP.ScopePos = Vector(-3.197, -3.608, -0.101)
SWEP.ScopeAng = Vector(0, 0, 0)

SWEP.ReflexPos = Vector(-3.197, -3.608, -0.225)
SWEP.ReflexAng = Vector(0, 0, 0)

SWEP.ACOGPos = Vector(-3.221, -3.608, -0.4)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(-3.221, -3.608, -1.55)
SWEP.ACOG_BackupAng = Vector(0, 0, 0)

SWEP.ELCANPos = Vector(-3.221, -3.608, -0.45)
SWEP.ELCANAng = Vector(0, 0, 0)

SWEP.ELCAN_BackupPos = Vector(-3.221, -3.608, -1.45)
SWEP.ELCAN_BackupAng = Vector(0, 0, 0)

SWEP.BallisticPos = Vector(-3.19, -4, -0.06)
SWEP.BallisticAng = Vector(0, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.FlipOriginsPos = Vector(-2, 0, -0.52)
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