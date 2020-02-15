if ( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

SWEP.BulletLength = 7.62
SWEP.CaseLength = 39
SWEP.PenAdd = 1.5

SWEP.MuzVel = 479.985

SWEP.Attachments = {
	[1] = {"kobra", "aimpoint", "acog"},
	[2] = {"vertgrip"},
	[3] = {"laser"}}
	
SWEP.InternalParts = {
	[1] = {{key = "hbar"}, {key = "lbar"}},
	[2] = {{key = "hframe"}},
	[3] = {{key = "ergonomichandle"}},
	[4] = {{key = "customstock"}},
	[5] = {{key = "lightbolt"}, {key = "heavybolt"}},
	[6] = {{key = "gasdir"}}}

if ( CLIENT ) then
	SWEP.LaserTune = {
		PosRight = 0,
		PosForward = 0,
		PosUp = 0,
		AngUp = -89,
		AngRight = 0,
		AngForward = 0 }

	SWEP.PrintName			= "AK-47"			
	SWEP.Author				= "Counter-Strike"
	SWEP.Slot				= 3
	SWEP.SlotPos = 0 // = 0
	SWEP.IconLetter			= "b"
	SWEP.NoMoveOnDraw = true
	SWEP.Muzzle = "cstm_muzzle_ar"
	SWEP.SparkEffect = "cstm_child_sparks_medium"
	SWEP.SmokeEffect = "cstm_child_smoke_medium"
	SWEP.ACOGDist = 5
	
	killicon.AddFont( "cstm_rif_ak47", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
	SWEP.VertGrip_Idle = {
		['v_weapon.Right_Thumb01'] = {vector = Vector(0, 0, 0), angle = Angle(-11.706000328064, 22.368999481201, 0)},
		['v_weapon.Right_Ring03'] = {vector = Vector(0, 0, 0), angle = Angle(0, -11.536999702454, 0)},
		['v_weapon.Right_Ring02'] = {vector = Vector(0, 0, 0), angle = Angle(0, -14.269000053406, 0)},
		['v_weapon.Right_Index01'] = {vector = Vector(0, 0, 0), angle = Angle(7.4439997673035, -7.3249998092651, 23.738000869751)},
		['v_weapon.Right_Middle01'] = {vector = Vector(0, 0, 0), angle = Angle(12.918999671936, -10.769000053406, 20.625)},
		['v_weapon.Right_Arm'] = {vector = Vector(-1.5, -2.5, 0), angle = Angle(13.868000030518, 14.125, -100.90599822998)},
		['v_weapon.Right_Hand'] = {vector = Vector(0, 0, 0), angle = Angle(15.838000297546, 13.800000190735, 4.2119998931885)},
		['v_weapon.Right_Pinky03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 18.055999755859, 0)},
		['v_weapon.Right_Pinky01'] = {vector = Vector(0, 0, 0), angle = Angle(-12.937999725342, -2.6189999580383, 43)},
		['v_weapon.Right_Ring01'] = {vector = Vector(0, 0, 0), angle = Angle(10.425000190735, -4.5120000839233, 16.038000106812)},
		['v_weapon.Right_Middle02'] = {vector = Vector(0, 0, 0), angle = Angle(0, -20.988000869751, 0)},
		['v_weapon.Right_Middle03'] = {vector = Vector(0, 0, 0), angle = Angle(0, -24.511999130249, 0)},
		['v_weapon.Right_Index03'] = {vector = Vector(0, 0, 0), angle = Angle(0, -24.843999862671, 0)},
		['v_weapon.Right_Thumb02'] = {vector = Vector(0, 0, 0), angle = Angle(-6.0749998092651, 6.1189999580383, 0)},
		['v_weapon.Right_Thumb03'] = {vector = Vector(0, 0, 0), angle = Angle(0, 90.737998962402, 0)},
		['v_weapon.Right_Index02'] = {vector = Vector(0, 0, 0), angle = Angle(1.3689999580383, -39.361999511719, 0)}}
	
	SWEP.VElements = {
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0, 2.93, 18.868), angle = Angle(0.2, 0, 0), size = Vector(0.059, 0.059, 0.159), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {}},	
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0.217, 1.33, -2.556), angle = Angle(180, 0, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(-0.181, 4, 2.5), angle = Angle(0, 0, 90), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "v_weapon.AK47_Parent", pos = Vector(0.125, 1.401, -2.376), angle = Angle(180, 0, 90), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["laser"] = { type = "Model", model = "models/props_c17/FurnitureBoiler001a.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.419, 3.325, 13.807), angle = Angle(0, 90, 180), size = Vector(0.029, 0.029, 0.029), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(-0.35, 0.619, 18.606), angle = Angle(0, 0, 90), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0, 5.313, 2.206), angle = Angle(180, 0, 90), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		//["grenadelauncher"] = { type = "Model", model = "models/wystan/attachments/gp30.mdl", bone = "v_weapon.AK47_Parent", rel = "", pos = Vector(0.238, 0.887, -9.051), angle = Angle(180, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	
	SWEP.WElements = {
		["acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0.652, 0.317, 0.321), angle = Angle(0, -90, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 0.435, 0.298), angle = Angle(0, -90, 170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["silencer"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(31.347, 0.635, -8.101), angle = Angle(-100, 0, 0), size = Vector(0.05, 0.05, 0.15), color = Color(255, 255, 255, 0), surpresslightning = false, material = "models/bunneh/silencer", skin = 0, bodygroup = {} },
		["vertgrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(7.895, 0.323, -0.392), angle = Angle(0, -90, 170), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rail"] = { type = "Model", model = "models/wystan/attachments/akrailmount.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.848, 0.959, -4.678), angle = Angle(0, 90, -170), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["kobra"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.817, 0.708, -6.348), angle = Angle(0, -90, 170), size = Vector(0.699, 0.699, 0.699), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
end

SWEP.Category = "Customizable Weaponry"
SWEP.HoldType			= "ar2"
SWEP.Base				= "cstm_base_pistol"
SWEP.FireModes = {"auto", "semi"}

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = true
SWEP.ViewModel = "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true
SWEP.ViewModelBonescales = {}

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound("Weapon_AK47.Single")
SWEP.Primary.Recoil			= 0.3
SWEP.Primary.Damage			= 29
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.02
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.1
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"
SWEP.InitialHoldtype = "smg"
SWEP.InHoldtype = "smg"
SWEP.SilencedSound = Sound("weapons/m4a1/m4a1-1.wav")
SWEP.SilencedVolume = 75

-- Animation speed/custom reload function related
SWEP.IsReloading = false
SWEP.AnimPrefix = "ak47_"
SWEP.ReloadSpeed = 1
SWEP.ShouldBolt = false
SWEP.ReloadDelay = 0
SWEP.IncAmmoPerc = 0.75 -- Amount of frames required to pass (in percentage) of the reload animation for the weapon to have it's amount of ammo increased

-- Dynamic accuracy related
SWEP.ShotsAmount 			= 0
SWEP.ConeDecAff				= 0
SWEP.DefRecoil				= 1.2
SWEP.CurCone				= 0
SWEP.DecreaseRecoilTime 	= 0
SWEP.ConeAff1 				= 0 -- Crouching/standing
SWEP.ConeAff2 				= 0 -- Using ironsights

SWEP.UnConeTime				= 0 -- Amount of time after firing the last shot that needs to pass until accuracy increases
SWEP.FinalCone				= 0 -- Self explanatory
SWEP.VelocitySensivity		= 2.2 -- Percentage of how much the cone increases depending on the player's velocity (moving speed). Rifles - 100%; SMGs - 80%; Pistols - 60%; Shotguns - 20%
SWEP.HeadbobMul 			= 1
SWEP.IsSilenced 			= false
SWEP.IronsightsCone			= 0.003
SWEP.HipCone 				= 0.062
SWEP.InaccAff1 = 0.75
SWEP.ConeInaccuracyAff1 = 0.7

SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IsUsingIronsights 		= false
SWEP.TargetMul = 0
SWEP.SetAndForget			= false

SWEP.IronSightsPos = Vector(6.0749, -5.5216, 2.3984)
SWEP.IronSightsAng = Vector(2.5174, -0.0099, 0)

SWEP.AimPos = Vector(6.085, -7.049, 2.49)
SWEP.AimAng = Vector(2.374, 0, 0)

SWEP.ChargePos = Vector (5.4056, -10.3522, -4.0017)
SWEP.ChargeAng = Vector (-1.7505, -55.5187, 68.8356)

SWEP.ScopePos = Vector(5.973, -6.456, 2.04)
SWEP.ScopeAng = Vector(-0.551, 0, 0)

SWEP.ACOGPos = Vector(5.985, -4.591, 1.855)
SWEP.ACOGAng = Vector(0, 0, 0)

SWEP.ACOG_BackupPos = Vector(5.97, -4.591, 1.17)
SWEP.ACOG_BackupAng = Vector(-1, -0.1, 0)

SWEP.KobraPos = Vector(6.039, -7.213, 2.079)
SWEP.KobraAng = Vector(0, 0, 0)

SWEP.CustomizePos = Vector(-6.289, -5.328, -2.096)
SWEP.CustomizeAng = Vector(31.43, -35.975, -29.837)

SWEP.MeleePos = Vector(6.692, -4.173, -7.165)
SWEP.MeleeAng = Vector(25.629, -50.985, 26.18)

if CLIENT then
	function SWEP:CanUseBackUp()
		if self.VElements["acog"].color.a == 255 then
			return true
		end
		
		return false
	end
	
	function SWEP:UseBackUp()
		if self.AimPos == self.ACOG_BackupPos then
			self.AimPos = self.ACOGPos
			self.AimAng = self.ACOGAng
		else
			self.AimPos = self.ACOG_BackupPos
			self.AimAng = self.ACOG_BackupAng
		end
	end
end