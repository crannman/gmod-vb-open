CreateClientConVar("cstm_different_origins", "0", true, true)
CreateClientConVar("cstm_attdesc", "1", true, true)
CreateClientConVar("cstm_leftcross", "1", true, true)
CreateClientConVar("cstm_rightcross", "1", true, true)
CreateClientConVar("cstm_lowercross", "1", true, true)
CreateClientConVar("cstm_uppercross", "1", true, true)
CreateClientConVar("cstm_out_r", "0", true, true)
CreateClientConVar("cstm_out_g", "0", true, true)
CreateClientConVar("cstm_out_b", "0", true, true)
CreateClientConVar("cstm_out_a", "255", true, true)
CreateClientConVar("cstm_in_r", "255", true, true)
CreateClientConVar("cstm_in_g", "255", true, true)
CreateClientConVar("cstm_in_b", "255", true, true)
CreateClientConVar("cstm_in_a", "255", true, true)
CreateClientConVar("cstm_crosslength", "11", true, true)
CreateClientConVar("cstm_dynamiccrosshair", "0", true, true)
CreateClientConVar("cstm_ef_heat", "0", true, true)
CreateClientConVar("cstm_ef_smoke", "0", true, true)
CreateClientConVar("cstm_ef_extramuzzle", "1", true, true)
CreateClientConVar("cstm_ef_sparks", "1", true, true)
CreateClientConVar("cstm_ef_laserblur", "1", true, true)
CreateClientConVar("cstm_ef_blur_sprint", "1", true, true)
CreateClientConVar("cstm_ef_blur_aim", "1", true, true)
CreateClientConVar("cstm_ef_blur_reload", "0", true, true)
CreateClientConVar("cstm_ef_blur_customize", "0", true, true)
CreateClientConVar("cstm_ef_blur_viewmodel", "0", true, true)
CreateClientConVar("cstm_ef_blur_depth", "0", true, true)
CreateClientConVar("cstm_aim_sensitivity", "0.01", true, true)
CreateClientConVar("cstm_aim_sensitivity_elcan", "0.007", true, true)
CreateClientConVar("cstm_aim_sensitivity_acog", "0.005", true, true)
CreateClientConVar("cstm_aim_sensitivity_ballistic", "0.015", true, true)
CreateClientConVar("cstm_viewbob_reload", "1", true, true)
CreateClientConVar("cstm_viewbob_silencer", "1", true, true)
CreateClientConVar("cstm_viewbob_draw", "1", true, true)
CreateClientConVar("cstm_hold_to_aim", "1", true, true)
CreateClientConVar("cstm_recoil_head", "1", true, true)
CreateClientConVar("cstm_hud_ammo", "1", true, true)
CreateClientConVar("cstm_hud_health", "1", true, true)
CreateClientConVar("cstm_hud_health_different", "1", true, true)
CreateClientConVar("cstm_hud_reloadprogress", "1", true, true)
CreateClientConVar("cstm_firstpersondeath", "0", true, true)
CreateClientConVar("cstm_firstpersondeath_speed", "1", true, true)
CreateClientConVar("cstm_firstpersondeath_alpha", "200", true, true)
CreateClientConVar("cstm_pitchmod", "1", true, true)
CreateClientConVar("cstm_yawmod", "1", true, true)
CreateClientConVar("cstm_rollmod", "1", true, true)
CreateClientConVar("cstm_lowammo", "0", true, true)
CreateClientConVar("cstm_spreaddisplay", "1", true, true)

surface.CreateFont("Default12", {font = "Default", size = 12, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("Default12B", {font = "Default", size = 12, weight = 700, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CSKI16", {font = "csd", size = 40, weight = 500, blursize = 0, antialias = true, shadow = true})
surface.CreateFont("CSKillIcons", {font = "csd", size = ScreenScale(30), weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("CSSelectIcons", {font = "csd", size = ScreenScale(60), weight = 500, blursize = 0, antialias = true, shadow = false})

surface.CreateFont("BROOP_Big", {font = "CloseCaption_Normal", size = 40, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("BROOP_BigBlur", {font = "CloseCaption_Normal", size = 40, weight = 500, blursize = 2, antialias = true, shadow = false})

surface.CreateFont("BROOP_26", {font = "CloseCaption_Normal", size = 26, weight = 500, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("BROOP_26Blur", {font = "CloseCaption_Normal", size = 26, weight = 500, blursize = 2, antialias = true, shadow = false})

surface.CreateFont("BROOP_20", {font = "CloseCaption_Normal", size = 20, weight = 600, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("BROOP_20Blur", {font = "CloseCaption_Normal", size = 20, weight = 600, blursize = 0, antialias = true, shadow = false})

surface.CreateFont("BROOP_18", {font = "CloseCaption_Normal", size = 18, weight = 600, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("BROOP_18Blur", {font = "CloseCaption_Normal", size = 18, weight = 600, blursize = 0, antialias = true, shadow = false})

surface.CreateFont("BROOP_16", {font = "CloseCaption_Normal", size = 16, weight = 600, blursize = 0, antialias = true, shadow = false})
surface.CreateFont("BROOP_16Blur", {font = "CloseCaption_Normal", size = 16, weight = 600, blursize = 0, antialias = true, shadow = false})

local CurAlpha = 0
local PitchMod = 0
local YawMod = 0
local RollMod = 0
local PAPR = 0 -- pitch approach rate
local YAPR = 0 -- yaw approach rate
local RAPR = 0 -- roll approach rate
local PT = 0 -- pitch target
local YT = 0 -- yaw target
local RT = 0 -- roll target
local PT2 = 0
local RT2 = 0
local BlackOut = {vig = 0, all = 0}

local ply, wep, vm, attachment, FT, CT, vel, runspeed, eyeang, activity, str, ShakeSTR, WeaponAnglePitch, WeaponAngleRoll, func, x, y, aim, ang, mag, clr, EP, EA, r, calc, arm, re, att, old, f, m, c, s1, s2, s3, s4, s5, s6, s7, add, hp, c2
local rbox, app, cos, sin, rad, rand, clamp = draw.RoundedBox, math.Approach, math.cos, math.sin, math.rad, math.random, math.Clamp

/*
Arguments that need to be passed on to draw.BlurredText:
t - text
f - main font
bf - blurred font
x - X position
y - Y position
bos - distance between the shadow and the text itself
fc - font color
bfc - blurred font color
xa - X align
ya - Y align
*/

function draw.BlurredText(t, f, bf, x, y, bos, fc, bfc, xa, ya)
	draw.SimpleText(t, bf, x + bos, y + bos, bfc, (xa and xa or TEXT_ALIGN_CENTER), (ya and ya or TEXT_ALIGN_CENTER))
	draw.SimpleText(t, f, x, y, fc, (xa and xa or TEXT_ALIGN_CENTER), (ya and ya or TEXT_ALIGN_CENTER))
end

local Gradient = surface.GetTextureID("VGUI/gradient")
local WasZero = false
local C = {}
local dclr = Color(255, 255, 255, 255)

C.White = Color(255, 255, 255, 255)
C.Black = Color(0, 0, 0, 255)
C.Green = Color(182, 255, 116, 255)
C.Red = Color(255, 84, 81, 255)

local function CSTM_InitPostEntity()
	ply = LocalPlayer()
	ply.CSTM_Nade = ClientsideModel("models/weapons/v_eq_fraggrenade.mdl", RENDERGROUP_BOTH)
	ply.CSTM_Nade:SetNoDraw(true)
	ply.CSTM_Nade:ResetSequence(ply.CSTM_Nade:LookupSequence("pullpin"))
	ply.CSTM_Nade:SetCycle(1)
	ply.CSTM_Nade.Lower = 2
	AttOnMe = AttOnMe or {}
	AmmoOnMe = AmmoOnMe or {}
	PartOnMe = PartOnMe or {}
end

hook.Add("InitPostEntity", "CSTM_InitPostEntity", CSTM_InitPostEntity)

local round, vig = surface.GetTextureID("round2"), surface.GetTextureID("VGUI/vignette")
local CLR, rect, rrect = surface.SetDrawColor, surface.DrawRect, surface.DrawTexturedRectRotated

local function TWeps_HUDPaint()
	ply = LocalPlayer()

	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) then
			x, y = ScrW(), ScrH()
			
			if IsValid(ply.MedkitWeapon)  then
				if ply.MedkitWeapon.dt.progress == 100 then
					CurAlpha = app(CurAlpha, 0, 6)
				else
					CurAlpha = app(CurAlpha, 255, 6)
				end
			else
				return
			end
			
			rbox(4, x * 0.5 - 100, y * 0.8, 200, 16, Color(0, 0, 0, CurAlpha))
			rbox(4, x * 0.5 - 99, y * 0.8 + 1, 198, 14, Color(70, 70, 70, CurAlpha))
			
			if IsValid(ply.MedkitWeapon) then
				if ply.MedkitWeapon.dt.progress > 1 then
					rbox(4, x * 0.5 - 99, y * 0.8 + 1, ply.MedkitWeapon.dt.progress * 1.98, 14, Color(174, 255, 0, CurAlpha))
				end
			end
		end
	else
		-- if GetConVarNumber("cstm_firstpersondeath") > 0 then
		-- 	FT = FrameTime()
		-- 	x, y = ScrW(), ScrH()
		-- 	add = clamp(GetConVarNumber("cstm_firstpersondeath_speed"), 0.2, 2)
		-- 	str = clamp(GetConVarNumber("cstm_firstpersondeath_alpha"), 150, 255)
			
		-- 	BlackOut.vig = app(BlackOut.vig, 255, FT * 50 * add)
			
		-- 	if BlackOut.vig >= 150 then
		-- 		BlackOut.all = app(BlackOut.all, str, FT * 30 * add)
		-- 	end
			
		-- 	CLR(0, 0, 0, BlackOut.vig)
		-- 	surface.SetTexture(vig)
		-- 	surface.DrawTexturedRect(0, 0, x, y)
			
		-- 	CLR(0, 0, 0, BlackOut.all)
		-- 	rect(0, 0, x, y)
		-- end
	end
end

hook.Add("HUDPaint", "TWeps_HUDPaint", TWeps_HUDPaint)

local BlackAmt = 1
local Ini = true
local CamData = {}
local Lens = surface.GetTextureID("models/wystan/attachments/acog/lense2")
local Tri = Material("sprites/acog_tri")

local function TWeps_RenderScene()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	if IsValid(wep) then
		if wep.IsCSTMWeapon then
			if wep.RenderSceneFunc then
				wep:RenderSceneFunc()
			end
			
			if wep.ScopeRenderFunc then
				wep:ScopeRenderFunc(wep)
			end
		end
	end
end

hook.Add("RenderScene", "TWeps_RenderScene", TWeps_RenderScene)

local time = 0
local WeaponAngle = 0
local animplayed = true
local lastanim = ""
local lastwep = ""
local att, x, y, atts, cl, dt3, ammo, al, PA, PA2, bc
local vcret = vgui.Create
local Vec0, Vec1, Ang0 = Vector(0, 0, 0), Vector(1, 1, 1), Angle(0, 0, 0)
local AngMod1, AngMod2, AngMod3 = Angle(15, -45, 0), Angle(15, 15, -15), Angle(10, -30, 60)
local view = {}

local function TWeps_Think()
	ply = LocalPlayer()
	al = ply:Alive()
	
	if not al then
		if not ply.WasAlive then
			ply.WasAlive = true
			BlackOut.vig = 0
			BlackOut.all = 0
		end
	end
	
	vm = ply:GetViewModel()
	FT = FrameTime()
	
	if IsValid(vm) then
		attachment = vm:GetAttachment("1")
	end
	
	if attachment then
		ply.attachment = attachment -- getting the attachment in a Think hook, because CalcView doesn't seem to like GetAttachment and pretty much breaks
	end
	
	for k, v in pairs(player.GetAll()) do
		wep = v:GetActiveWeapon()
		
		if IsValid(wep) then
			if wep.IsCSTMWeapon then
				if not v.AnglePosMod then
					v.AnglePosMod = 0
				end
				
				v:ManipulateBoneAngles(v:LookupBone("ValveBiped.Bip01_R_UpperArm"), AngMod1 * v.AnglePosMod)
				v:ManipulateBoneAngles(v:LookupBone("ValveBiped.Bip01_R_Forearm"), AngMod2 * v.AnglePosMod)
				v:ManipulateBoneAngles(v:LookupBone("ValveBiped.Bip01_R_Hand"), AngMod3 * v.AnglePosMod)
				
				if not wep.Safe then
					dt3 = wep:GetDTInt(3)
					
					if dt3 == 2 then
						if wep.HoldType == "pistol" then
							wep:SetWeaponHoldType("pistol")
						else
							wep:SetWeaponHoldType("passive")
						end
						
						v.AnglePosMod = Lerp(FT * 10, v.AnglePosMod, 0)
					elseif dt3 == 1 then
						if wep.HoldType == "pistol" then
							if wep.HoldType != "duel" then
								wep:SetWeaponHoldType("revolver")
							else
								wep:SetWeaponHoldType("duel")
							end
						else
							if wep.IsShotgun then
								wep:SetWeaponHoldType("ar2")
							else
								wep:SetWeaponHoldType(wep.HoldType)
							end
						end
						
						v.AnglePosMod = Lerp(FT * 10, v.AnglePosMod, 0)
					elseif dt3 == 19 then
						wep:SetWeaponHoldType("slam")
						v.AnglePosMod = Lerp(FT * 10, v.AnglePosMod, 1)
					else
						if wep.HoldType == "pistol" then
							wep:SetWeaponHoldType("pistol")
						else
							if wep.IsShotgun then
								wep:SetWeaponHoldType("shotgun")
							elseif wep.HoldType == "duel" then
								wep:SetWeaponHoldType("duel")
							else
								wep:SetWeaponHoldType("crossbow")
							end
						end
						
						v.AnglePosMod = Lerp(FT * 10, v.AnglePosMod, 0)
					end
				else
					v.AnglePosMod = Lerp(FT * 10, v.AnglePosMod, 0)
				end
			end
		end
	end
	
	wep = ply:GetActiveWeapon()
	
	if IsValid(wep) then
		if al then
			if (ply.LastWep and ply.LastWep != wep) or not wep.ResetBones then
				vm = ply:GetViewModel()
				
				if IsValid(vm) and vm:GetBoneCount() then
					for i = 1, vm:GetBoneCount() - 1 do
						m = vm:LookupBone(vm:GetBoneName(i))
						
						if m then
							vm:ManipulateBonePosition(m, Vec0)
							vm:ManipulateBoneAngles(m, Ang0)
							vm:ManipulateBoneScale(m, Vec1)
						end
					end
				
					wep.ResetBones = true
					ply.LastWep = nil
				end
			end
		end
		
		if wep.IsCSTMWeapon then
			if wep:GetDTInt(3) == 19 then
				if #PAs == 0 then
						AttOnMe = AttOnMe or {}
						atts = wep.Attachments and #wep.Attachments or 0
							
						ammo = #wep.AmmoTypes
						x, y = ScrW(), ScrH()
							
						if IsValid(vm) then
							att = vm:GetAttachment("1")
							
							if att then
								att = att.Pos:ToScreen()
							end
						end
							
						if atts > 0 then
							for k, v in ipairs(wep.Attachments) do
								PA = vcret("AttachmentSelectionPanel")
								PA:SetSize(158 + math.max(0, ((#v - 3) * 52)), 75)
								PA.Off = 80 * (k - 1) //- 40 * atts
								PA.Key = k
								
								if not att or att.x > x or att.y > y or att.x < 0 or att.y < 0 then
									PA:SetPos(200, y * 0.5 + PA.Off)
									PA.DontRepos = true
								else
									PA:SetPos(math.max(50, att.x - 100), att.y + PA.Off - 50)
								end
								
								table.insert(PAs, PA)
								
								for k2, v2 in ipairs(v) do
									PA2 = vcret("AttachmentIcon", PA)
									PA2:SetSize(50, 50)
									PA2:SetPos(52 * (k2 - 1) + 2, 20)
									PA2.Att = v2
									PA2.Texture = CWAttachments[v2].displaytexture
									PA2.Ref = v2
								end
							end
						end
							
						PA = vcret("AmmoSelectionPanel")
						PA:SetSize(158 + math.max(0, ((ammo - 3) * 52)), 75)
						PA.Off = 80 * atts
						
						if not att or att.x > x or att.y > y or att.x < 0 or att.y < 0 then
							PA:SetPos(200, y * 0.5 + PA.Off)
							PA.DontRepos = true
						else
							PA:SetPos(math.max(50, att.x - 100), att.y + PA.Off - 50)
						end
							
						table.insert(PAs, PA)
							
						for k2, v2 in ipairs(wep.AmmoTypes) do
							PA2 = vcret("AmmoIcon", PA)
							PA2:SetSize(50, 50)
							PA2:SetPos(52 * (k2 - 1) + 2, 20)
							PA2.Ammo = v2
							PA2.Ref = v2
						end
					else
					for k, v in pairs(PAs) do
						if not ValidPanel(v) then
							v:Remove()
						end
					end
				end
			else
				if PAs then
					if #PAs > 0 then
						for k, v in pairs(PAs) do
							if ValidPanel(v) then
								v:Remove()
							end
						end
						
						PAs = {}
						return
					end
				else
					PAs = {}
				end
			end
		end
	end
end

hook.Add("Think", "TWeps_Think", TWeps_Think)

local CurWeaponAngleMod = 1
local WeaponAngle = Angle(0, 0, 0)
local ShakeSTR = Angle(0, 0, 0)
local CurShake = Angle(0, 0, 0)
local kd, ws

local function TWeps_ViewShake(ply, pos, angles, fov)
	FT = FrameTime()
	CT = CurTime()
	wep = ply:GetActiveWeapon()
	
	-- if not ply:Alive() and GetConVarNumber("cstm_firstpersondeath") > 0 then
	-- 	re = ply:GetRagdollEntity()
		
	-- 	if IsValid(re) then
	-- 		att = re:GetAttachment(re:LookupAttachment("eyes"))
			
	-- 		view.angles = att.Ang
	-- 		view.origin = att.Pos + att.Ang:Forward() * 2
	-- 		view.fov = fov
			
	-- 		return GAMEMODE:CalcView(ply, view.origin, view.angles, view.fov, 0.1)
	-- 	end
	-- end
	
	if not IsValid(wep) or not wep.IsCSTMWeapon then
		animplayed = false
		PAPR = 0.05
		YAPR = 0.05
		RAPR = 0.05
		PT = 0
		YT = 0
		RT = 0
		PT2 = app(PT2, 0, 0.17)
		RT2 = app(RT2, 0, 0.17)
		return
	end
	
	if ply:OnGround() then 
		vel = ply:GetVelocity():Length()
		runspeed = ply:GetRunSpeed()
		kd = ply:KeyDown(IN_SPEED)
		ws = ply:GetWalkSpeed()
		
		if kd and vel > ply:GetWalkSpeed() * 1.2 then
			PAPR = 0.5
			YAPR = 0.5
			RAPR = 0.5
			PT = cos(CT * (runspeed / 18)) * 0.35
			YT = cos(CT * 10) * 0.1
			RT = cos(CT * 10) * 0.2
			
		elseif vel < runspeed and vel > 50 and not kd then
			PAPR = 0.6
			YAPR = 0.6
			RAPR = 0.6
			PT = cos(CT * 15) * 0.1
			YT = cos(CT * 10) * 0.05
			RT = cos(CT * 10) * 0.05
		elseif wep:GetDTInt(3) == 1 and vel < runspeed and vel > 50 and not kd then
			PAPR = 0.6
			YAPR = 0.6
			RAPR = 0.6
			PT = cos(CT * 15) * 0.1
			YT = cos(CT * 10) * 0.05
			RT = cos(CT * 10) * 0.05
		else
			PAPR = 0.25
			YAPR = 0.25
			RAPR = 0.25
			PT = 0
			YT = 0
			RT = 0
		end
				
		if kd and vel > ws * 1.2 then
			if ply:KeyDown(IN_MOVELEFT) then
				RT2 = app(RT2, -1.5, 0.15)
			elseif ply:KeyDown(IN_MOVERIGHT) then
				RT2 = app(RT2, 1.5, 0.15)
			else
				RT2 = app(RT2, 0, 0.15)
			end
		else
			RT2 = app(RT2, 0, 0.15)
		end
		
	else
		PAPR = 0.05
		YAPR = 0.05
		PAPR = 0.05
		PT = 0
		YT = 0
		RT = 0
		PT2 = app(PT2, 0, 0.2)
		RT2 = app(RT2, 0, 0.2)
	end
	
	animplayed = false
	
	vm = ply:GetViewModel()
	eyeang = ply:EyeAngles()
	activity = vm:GetSequenceActivityName(vm:GetSequence())
				
	if ply.attachment then
			if GetConVarNumber("cstm_viewbob_reload") > 0 and (activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_EMPTY" or activity == "ACT_VM_RELOAD_SILENCED") or GetConVarNumber("cstm_viewbob_silencer") > 0 and (activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER") or GetConVarNumber("cstm_viewbob_draw") > 0 and (activity == "ACT_VM_DRAW" or activity == "ACT_VM_DRAW_SILENCED") or wep.ViewMoveWhenFiring and activity == "ACT_VM_PRIMARYATTACK" then
			cyc = vm:GetCycle()
				
			if cyc <= 0.9 then
				CurWeaponAngleMod = 0.5
				
				if activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED" then
					CurWeaponAngleMod = wep.ReloadAngleMod or 1
				elseif activity == "ACT_VM_DRAW" or activity == "ACT_VM_DRAW_SILENCED" then
					CurWeaponAngleMod = wep.DrawAngleMod or 1
				elseif activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER" then
					CurWeaponAngleMod = wep.SilencerAngleMod or 1
				end
				
				animplayed = true
			end
		else
			animplayed = false
			time = 0
		end
	end
	
	if animplayed then
		WeaponAngle = LerpAngle(FT * 5, WeaponAngle, (ply.attachment.Ang - angles) * 0.15)
	else
		WeaponAngle = LerpAngle(FT * 5, WeaponAngle, Ang0)
	end
	
	PitchMod = app(PitchMod, PT, PAPR)
	YawMod = app(YawMod, YT, YAPR)
	RollMod = app(RollMod, RT, RAPR)
	
	view.angles = angles + Angle(PitchMod, YawMod, RollMod + RT2)
	view.angles.p = view.angles.p + WeaponAngle.p * (wep.PitchMod or 1) * CurWeaponAngleMod * clamp(GetConVarNumber("cstm_pitchmod"), 0.2, 2)
	view.angles.y = view.angles.y - (WeaponAngle.p + WeaponAngle.y) * 0.05 * (wep.YawMod or 1) * CurWeaponAngleMod * clamp(GetConVarNumber("cstm_yawmod"), 0.2, 2)
	view.angles.r = view.angles.r + WeaponAngle.p * (wep.RollMod or 1) * CurWeaponAngleMod * clamp(GetConVarNumber("cstm_rollmod"), 0.2, 2)
	view.origin = pos
	view.fov = fov + (GetConVarNumber("cstm_recoil_head") >= 1 and wep.RecoilAmt or 0)
	
	func = wep.GetViewModelPosition
	
	if func then
		view.vm_origin,  view.vm_angles = func(wep, pos * 1, angles * 1)
	end
	
	func = wep.CalcView
	
	if func then
		view.origin, view.angles, view.fov = func(wep, ply, pos * 1, angles * 1, fov)
	end
	
	return GAMEMODE:CalcView(ply, view.origin, view.angles, view.fov)
end

hook.Add("CalcView", "TWeps_ViewShake", TWeps_ViewShake)

local Blur = 0

local NoBlur = {["cstm_base_sniper"] = true,
	["cstm_base_sniper2"] = true}
	
local GlobalBlur = 0

CreateClientConVar("cstm_ef_blur_sprint", "1", true, true)
CreateClientConVar("cstm_ef_blur_aim", "1", true, true)
CreateClientConVar("cstm_ef_blur_reload", "0", true, true)
CreateClientConVar("cstm_ef_blur_customize", "0", true, true)

function TWeps_SightsBlur(x, y, fwd, spin)
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	c = false
	c2 = false
	FT = FrameTime()
	
	if not IsValid(wep) then
		return x, y, fwd, spin
	end
	
	if wep.IsCSTMWeapon then
		dt3 = wep:GetDTInt(3)
			
		if (GetConVarNumber("cstm_ef_blur_aim") > 0 and dt3 == 1 and not NoBlur[wep.Base]) or (GetConVarNumber("cstm_ef_blur_sprint") > 0 and ply:KeyDown(IN_SPEED) and ply:OnGround() and ply:GetVelocity():Length() > ply:GetWalkSpeed() * 1.3) then
			Blur = app(Blur, 0.015, FT / 10)
			c = true
		end
		
		if not ply:ShouldDrawLocalPlayer() then
			if dt3 == 19 then
				if GetConVarNumber("cstm_ef_blur_customize") > 0 then
					c2 = true
				end
			else
				if GetConVarNumber("cstm_ef_blur_reload") > 0 then
					vm = ply:GetViewModel()
					activity = vm:GetSequenceActivityName(vm:GetSequence())
					cyc = vm:GetCycle()
			
					if wep.IsShotgun then
						if activity == "ACT_VM_RELOAD" or activity == "ACT_SHOTGUN_RELOAD_START" then
							c2 = true
						elseif activity == "ACT_SHOTGUN_RELOAD_FINISH" and cyc <= 0.8 then
							c2 = true
						end
					else
						if (activity == "ACT_VM_RELOAD" or activity == "ACT_VM_RELOAD_SILENCED" or activity == "ACT_VM_ATTACH_SILENCER" or activity == "ACT_VM_DETACH_SILENCER") and cyc <= 0.9 then
							c2 = true
						end
					end	
				end
			end
		end
	end
	
	if not c then
		Blur = app(Blur, 0, FT / 10)
	end
	
	if not c2 then
		GlobalBlur = app(GlobalBlur, 0, FT / 16)
	else
		GlobalBlur = app(GlobalBlur, 0.01, FT / 16)
	end
	
	x, y, fwd = x + GlobalBlur, y, fwd + Blur -- make sure we also keep the old motion blur values
	
	return x, y, fwd, spin
end

hook.Add("GetMotionBlurValues", "TWeps_SightsBlur", TWeps_SightsBlur)

local adir, acdir, at, apeak = 0, 0, 0, 0

function TWeps_CreateMove(c)
	ply = LocalPlayer()
	
	if ply:Alive() then
		-- if GetConVarNumber("cstm_firstpersondeath") > 0 then
		-- 	if ply.WasAlive then
		-- 		ang = c:GetViewAngles()
		-- 		ang.r = 0
		-- 		c:SetViewAngles(ang)
		-- 		ply.WasAlive = false
		-- 		BlackOut.vig = 0
		-- 		BlackOut.all = 0
		-- 	end
		-- end
		
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) then
			if wep.IsCSTMWeapon then
				if not wep:GetClass():find("cstm_sniper") then
					CT = CurTime()
					FT = FrameTime()
					
					if CT >= wep.RecoilTime then
						acdir = Lerp(FT * 10, acdir, 0)
						
						if acdir then
							apeak = 0
						end
					else
						acdir = Lerp(FT * 10, acdir, adir)
					end
						
					if wep:GetDTInt(3) == 1 then
						str = (wep:GetDTFloat(0) - wep.IronsightsCone - ply:GetVelocity():Length() / 10000 * 0.3) * (wep:GetDTBool(1) and 1 or 2)
						
						if str > apeak then
							apeak = str
						end
						
						if CT >= at then
							adir = math.Rand(-1, 1)
							at = CT + 0.2
						end
						
						if apeak >= 0.02 and apeak <= 0.08 then
							ang = c:GetViewAngles()
							
							ang.p = ang.p - apeak * 0.75
							ang.y = ang.y - apeak * acdir
							c:SetViewAngles(ang)
						end
					end
				end
			end
		end
	else
		-- if GetConVarNumber("cstm_firstpersondeath") > 0 then
		-- 	re = ply:GetRagdollEntity()
			
		-- 	if IsValid(re) then
		-- 		att = re:GetAttachment(re:LookupAttachment("eyes"))
		-- 		c:SetViewAngles(att.Ang)
		-- 	end
		-- end
	end
end

hook.Add("CreateMove", "TWeps_CreateMove", TWeps_CreateMove)

local AttToText = {
	["ballistic"] = "Ballistic 12x Scope",
	["acog"] = "ACOG 4x Scope",
	["elcan"] = "ELCAN C79 Scope",
	["aimpoint"] = "Aimpoint holo-scope",
	["eotech"] = "EoTech 557 holo-sight",
	["kobra"] = "Kobra reflex sight",
	["reflex"] = "Docter reflex sight",
	["vertgrip"] = "Foregrip",
	["cmag"] = "Beta C-Magazine",
	["grenadelauncher"] = "M203",
	["laser"] = "Laser Sight",
	["bipod"] = "Bipod",
	["riflereflex"] = "Rifle reflex sight"}
	
local function GetAttachments(um)
	s = um:ReadString()
	AttOnMe = {}
	
	s = string.Explode(" ", s)
	
	for k, v in pairs(s) do
		table.insert(AttOnMe, v)
	end
end

usermessage.Hook("GETATTS", GetAttachments)

local function NoAttachments()
	AttOnMe = {}
end

usermessage.Hook("NOATTS", NoAttachments)

local function PickUpAttachment(um)
	s = um:ReadString()
	
	if not AttOnMe then
		AttOnMe = {}
	end
	
	table.insert(AttOnMe, s)
	ClientsideNotify("Got new weapon attachment: " .. CWAttachments[s].name .. ".")
end

usermessage.Hook("PICKUPATT", PickUpAttachment)

local function PickUpAttachmentSilent(um)
	s = um:ReadString()
	AttOnMe = AttOnMe or {}
	
	table.insert(AttOnMe, s)
end

usermessage.Hook("PICKUPATTSIL", PickUpAttachmentSilent)

local function PickUpInternalPart(um)
	s = um:ReadString()
	PartOnMe = PartOnMe or {}
	
	table.insert(PartOnMe, s)
	ClientsideNotify("Got new internal weapon part: " .. CWInternalParts[s].name .. ".")
end

usermessage.Hook("PICKUPPART", PickUpInternalPart)

local function PickUpInternalPartSilent(um)
	s = um:ReadString()
	PartOnMe = PartOnMe or {}
	
	table.insert(PartOnMe, s)
end

usermessage.Hook("PICKUPATTSIL", PickUpInternalPartSilent)

local function GetParts(um)
	s = um:ReadString()
	PartOnMe = {}
	
	s = string.Explode(" ", s)
	
	for k, v in pairs(s) do
		table.insert(PartOnMe, v)
	end
end

usermessage.Hook("GETPARTS", GetParts)

local function NoParts()
	PartOnMe = {}
end

usermessage.Hook("NOPARTS", NoParts)

local function ReceiveWeaponStats(um)
	s = um:ReadFloat()
	s2 = um:ReadFloat()
	s3 = um:ReadFloat()
	s4 = um:ReadFloat()
	s5 = um:ReadFloat()
	s6 = um:ReadFloat()
	s7 = um:ReadFloat()
	
	wep = LocalPlayer():GetActiveWeapon()
	
	wep.DefRecoil = math.Round(s, 2)
	wep.RecoilDisplay = math.Round(s * 100, 2)
	wep.Primary.Damage = math.Round(s2)
	wep.ClumpSpread = s3
	wep.HipCone = math.Round(s4, 7)
	wep.IronsightsCone = math.Round(s5, 7)
	wep.Primary.Delay = math.Round(s6, 7)
	wep.ConeInaccuracyAff1 = math.Round(s7, 7)
end

usermessage.Hook("CSTM_WEPSTATS", ReceiveWeaponStats)

local function GetAmmoTypes(um)
	s = um:ReadString()
	AmmoOnMe = {}
	
	s = string.Explode(" ", s)
	
	for k, v in pairs(s) do
		table.insert(AmmoOnMe, v)
	end
end

usermessage.Hook("GETAMMO", GetAmmoTypes)

local function PickUpAmmo(um)
	s = um:ReadString()
	
	if not AmmoOnMe then
		AmmoOnMe = {}
	end
	
	table.insert(AmmoOnMe, s)
	ClientsideNotify("Got new ammo type: " .. AmmoTypes[s].name .. ".")
end

usermessage.Hook("PICKUPAMMO", PickUpAmmo)

local function PickUpAmmoSilent(um)
	s = um:ReadString()
	
	if not AmmoOnMe then
		AmmoOnMe = {}
	end
	
	table.insert(AmmoOnMe, s)
end

usermessage.Hook("PICKUPAMMOSIL", PickUpAmmoSilent)

local function NoAmmo()
	AmmoOnMe = {}
end

usermessage.Hook("NOAMMO", NoAmmo)

local function ReceiveMouseSensitivity(um)
	s = um:ReadFloat()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	wep.OverallMouseSensMod = s
end

usermessage.Hook("MOUSESENS", ReceiveMouseSensitivity)

local ThrowAnims = {"pullpin", "pullpin2", "pullpin3", "pullpin4"}

local function CSTM_QuickGrenade1()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	ply.CSTM_Nade.Lower = 10
	ply.CSTM_Nade:ResetSequence(ply.CSTM_Nade:LookupSequence(table.Random(ThrowAnims)))
	ply.CSTM_Nade:SetPlaybackRate(2)
	ply.CSTM_Nade:SetCycle(0)
	wep.Cooking = true
	
	timer.Simple(0.125, function()
		ply:EmitSound("weapons/pinpull.wav", 100, 100)
	end)
end

usermessage.Hook("CSTM_QUICKNADE1", CSTM_QuickGrenade1)

local function CSTM_QuickGrenade2()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	ply.CSTM_Nade:ResetSequence(ply.CSTM_Nade:LookupSequence("throw"))
	ply.CSTM_Nade:SetPlaybackRate(1.25)
	ply.CSTM_Nade:SetCycle(0.25)
	CT = CurTime()
	
	wep:SetNextPrimaryFire(CT + 1.05)
	wep:SetNextSecondaryFire(CT + 1.05)
	wep.ReloadDelay = CT + 1.05
	wep.HolsterTime = CT + 1.05
	wep.Cooking = false
end

usermessage.Hook("CSTM_QUICKNADE2", CSTM_QuickGrenade2)

local time

local function CSTM_FuseTime(um)
	time = um:ReadFloat()
	ply = LocalPlayer()
	
	if ply:Alive() then
		ply.FuseTime = time
	end
end

usermessage.Hook("CSTM_FUSETIME", CSTM_FuseTime)

net.Receive("SENDATTACHMENTS", function(l, c)
	AttOnMe = net.ReadTable()
end)

net.Receive("SENDAMMOTYPES", function(l, c)
	AmmoOnMe = net.ReadTable()
end)

net.Receive("SENDINTERNALPARTS", function(l, c)
	PartOnMe = net.ReadTable()
end)

net.Receive("SENDFIREMODES", function(l, c)
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	wep.FireModes = net.ReadTable()
	wep.FireMode = wep.FireModes[1]
	s1 = wep.FireModeNames[wep.FireModes[1]]
	
	wep.Bullets = s1.bul
	wep.Primary.Automatic = s1.auto
end)