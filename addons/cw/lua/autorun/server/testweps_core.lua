local ra, ps = resource.AddFile, umsg.PoolString

-- File download list --

-- Materials & textures --

/*ra("materials/models/wystan/attachments/bipod/Harris_Bipod.vmt")
ra("materials/models/wystan/attachments/aimpoint/aim1.vmt")
ra("materials/models/wystan/attachments/aimpoint/aim2.vmt")
ra("materials/models/wystan/attachments/doctor/frame1.vmt")
ra("materials/models/wystan/attachments/eotech/557.vmt")
ra("materials/models/wystan/attachments/acog/acog.vmt")
ra("materials/models/wystan/attachments/acog/acog.vtf")
ra("materials/models/wystan/attachments/acog/lense.vmt")
ra("materials/models/wystan/attachments/acog/lense.vtf")
ra("materials/models/wystan/attachments/akrail/newscope.vmt")
ra("materials/models/wystan/attachments/m203/m203.vmt")
ra("materials/models/wystan/cmag/cmag.vmt")
ra("materials/models/wystan/cmag/bbulet.vmt")
ra("materials/models/wystan/attachments/vert.vmt")
ra("materials/models/bunneh/silencer.vmt")
ra("materials/models/bunneh/silencernormal.vtf")
ra("materials/models/bunneh/Scope.vmt")
ra("materials/models/bunneh/elcan/elcan.vmt")
ra("materials/models/bunneh/akrail/newscope.vmt")
ra("materials/models/blacktea/attachments/aim2.vmt")
ra("materials/models/blacktea/attachments/CMore_D.vmt")
ra("materials/models/blacktea/attachments/KAScope08_D.vmt")
ra("materials/sprites/frostbreath.vmt")
ra("materials/sprites/eotech_reddot.vmt")
ra("materials/sprites/aim_reticule.vmt")
ra("materials/sprites/acog_tri.vmt")
ra("materials/sprites/crosshair_gl.vmt")
ra("materials/effects/laser_cstm.vmt")
ra("materials/VGUI/bullet.vmt")
ra("materials/VGUI/vignette.vmt")
ra("materials/VGUI/bipod_active.vmt")
ra("materials/VGUI/bullet.vmt")
ra("materials/VGUI/gradient.vmt")
ra("materials/VGUI/gradient_dual.vmt")
ra("materials/VGUI/m203_active.vmt")
ra("materials/VGUI/brightglow_y_nomodel.vmt")
ra("materials/VGUI/bipod_active.vmt")
ra("materials/VGUI/m203_active.vmt")
ra("materials/VGUI/clumpspread_ring.vmt")
ra("materials/VGUI/entities/upgr_acog.vmt")
ra("materials/VGUI/entities/upgr_elcan.vmt")
ra("materials/VGUI/entities/upgr_aimpoint.vmt")
ra("materials/VGUI/entities/upgr_eotech557.vmt")
ra("materials/VGUI/entities/upgr_bipod.vmt")
ra("materials/VGUI/entities/upgr_cmag.vmt")
ra("materials/VGUI/entities/upgr_lasersight.vmt")
ra("materials/VGUI/entities/upgr_m203.vmt")
ra("materials/VGUI/entities/upgr_reflexsight.vmt")
ra("materials/VGUI/entities/upgr_vertgrip.vmt")
ra("materials/VGUI/entities/upgr_kobra.vmt")
ra("materials/VGUI/entities/upgr_riflereflex.vmt")
ra("materials/VGUI/entities/upgr_ballistic.vmt")
ra("materials/round.vmt")
ra("materials/gcellmats/scope_rifle.vmt")
ra("materials/gcellmats/scope_rifle2.vmt")

-- Models --
ra("models/wystan/attachments/2cog.mdl")
ra("models/wystan/attachments/akrailmount.mdl")
ra("models/wystan/attachments/aimpoint.mdl")
ra("models/wystan/attachments/2octorrds.mdl")
ra("models/wystan/attachments/2otech557sight.mdl")
ra("models/wystan/attachments/m203.mdl")
ra("models/wystan/attachments/bipod.mdl")
ra("models/wystan/cmag.mdl")
ra("models/wystan/attachments/foregrip1.mdl")
ra("models/bunneh/scope01.mdl")
ra("models/bunneh/elcan.mdl")
ra("models/attachments/cmore.mdl")
ra("models/attachments/kascope.mdl")

-- Particles --

ra("particles/cstm_muzzleflashes.pcf")
ra("particles/cstm_muzzleflashes2.pcf")

-- Sounds --

ra("sound/weapons/cstm/attach_attachment.mp3")
ra("sound/weapons/cstm/attach.wav")
ra("sound/weapons/cstm/detach.wav")*/

for i = 1, 4 do
	ra("sound/weapons/cstm/holster" .. i .. ".wav")
end

for i = 1, 4 do
	ra("sound/weapons/cstm/firemode" .. i .. ".wav")
end

AddCSLuaFile("autorun/client/medkitregenprogressbar.lua")
AddCSLuaFile("autorun/client/cstm_menu.lua")
AddCSLuaFile("autorun/client/helpmeicantfuckingread.lua")
AddCSLuaFile("autorun/particleprecache.lua")
include("autorun/physbul.lua")
CreateConVar("cstm_accuracymod_aim", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_accuracymod_hip", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_recoilmod", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_damagemod", "1", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})

CreateConVar("cstm_ammo_incendiary", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_ammo_ap", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_ammo_hp", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_ammo_magnum", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_ammo_slug", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_ammo_birdshot", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_ammo_frag", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_ammo_smoke", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("cstm_physbul_sp", "0", {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})

SetGlobalFloat("CR", GetConVarNumber("cstm_recoilmod")) -- I'm sorry, but I have to use a global ;_;
ps("NWATT2")
ps("NWAlpha")
ps("NWSPD")
ps("NWRATT")
ps("NWAMMO")
ps("NWHT")
ps("NBUL")
ps("FRMD")
ps("RECOIL")
ps("PICKUPATT")
ps("PICKUPATTSIL")
ps("GETATTS")
ps("REMATT")
ps("NOATTS")
ps("CSTM_RECOIL")
ps("M203_ON")
ps("M203_OFF")
ps("PICKUPAMMO")
ps("PICKUPAMMOSIL")
ps("GETAMMO")
ps("NOAMMO")
ps("DESELECTAMMO")
ps("DOVMSTUFF")
ps("NWAMMO")
ps("CSTM_FUSETIME")
ps("CSTM_QUICKNADE1")
ps("CSTM_QUICKNADE2")
ps("40MMTYPE")
ps("INTERNALPART")
ps("INTERNALPARTREM")
util.AddNetworkString("SENDATTACHMENTS")
util.AddNetworkString("SENDAMMOTYPES")
util.AddNetworkString("SENDINTERNALPARTS")
util.AddNetworkString("SENDFIREMODES")

local Armored = {
	["npc_combine_s"] = true,
	["npc_cscanner"] = true,
	["npc_clawscanner"] = true,
	["npc_manhack"] = true,
	["npc_combine_camera"] = true,
	["npc_turret_ceiling"] = true,
	["npc_metropolice"] = true,
	["npc_antlionguard"] = true,
	["npc_hunter"] = true,
	["npc_antlionguardian"] = true,
	["npc_zombine"] = true}

local wep, wepclass, CT, distance, FinalDamageDecay, Accuracy, Accuracy2, Recoil, Damage, isp, arm, npc, ammo

local function TWeps_Think()
	for k, v in pairs(player.GetAll()) do
		wep = v:GetActiveWeapon()
		CT = CurTime()
		
		if v:HasWeapon("test_medkit") then
			wep = v:GetWeapon("test_medkit")
			
			if CT > wep.IncreaseDelay then
				wep.dt.progress = math.Clamp(wep.dt.progress + 1, 0, 100)
				wep.IncreaseDelay = CT + 0.1
			end
		end
	end
end

hook.Add("Think", "TWeps_Think", TWeps_Think)

local function TWeps_KeyRelease(ply, key)
	if ply:Alive() then
		wep = ply:GetActiveWeapon()
		
		if IsValid(wep) and wep.IsCSTMWeapon then
			if ply:GetVelocity():Length() >= ply:GetWalkSpeed() * 0.8 then
				if key == IN_SPEED then
					if not wep.Cooking and not wep.ReloadTime then
						CT = CurTime()
					
						if wep.Primary.Delay <= 0.2 then
							wep:SetNextPrimaryFire(CT + 0.2)
							wep:SetNextSecondaryFire(CT + 0.2)
							wep.ReloadDelay = CT + 0.2
						end
					end
				end
			end
		end
	end
end

hook.Add("KeyRelease", "TWeps_KeyRelease", TWeps_KeyRelease)

local att

local function TWeps_EntityTakeDamage(ent, d)
	att = d:GetAttacker()
	
	if not IsValid(ent) or not IsValid(att) or not att:IsPlayer() or not IsValid(att:GetActiveWeapon()) then
		return
	end
	
	if d:GetDamageType() == DMG_BURN then
		return
	end
	
	wep = att:GetActiveWeapon()
			
	if wep.IsCSTMWeapon then
		if wep.EffectiveRange then
			distance = att:GetPos():Distance(ent:GetPos())
			isp = ent:IsPlayer()
			ammo = wep:GetDTInt(2) -- value 2 is armor piercing, value 3 is hollow point
			
			if isp then
				arm = ent:Armor()
				
				if arm > 0 then
					if ammo == 2 then 
						att.DamageAff1 = 0.3
					elseif ammo == 3 then
						att.DamageAff1 = -0.3
					else
						att.DamageAff1 = 0
					end
				else
					if ammo == 2 then
						att.DamageAff1 = -0.3
					elseif ammo == 3 then
						att.DamageAff1 = 0.3
					else
						att.DamageAff1 = 0
					end
				end
			else -- if he is an NPC then do the same as if he wouldn't have armor/etc.
				npc = ent:IsNPC()
				
				if ammo == 2 then
					if npc then
						if Armored[ent:GetClass()] then
							att.DamageAff1 = 0.3
						else
							att.DamageAff1 = -0.3
						end
					else
						att.DamageAff1 = 0.3 -- breakable stuff should get extra damage
					end
				elseif ammo == 3 then
					if npc then
						if Armored[ent:GetClass()] then
							att.DamageAff1 = -0.3
						else
							att.DamageAff1 = 0.3
						end
					else
						att.DamageAff1 = -0.3 -- breakable stuff should get less damage
					end
				else
					att.DamageAff1 = 0
				end
			end
			
			if distance >= wep.EffectiveRange then
				FinalDamageDecay = wep.DamageDecay
			else
				FinalDamageDecay = wep.DamageDecay * (distance / wep.EffectiveRange)
			end
			
			d:ScaleDamage((1 + att.DamageAff1 - FinalDamageDecay) * GetConVarNumber("cstm_damagemod"))
		end
	end
end

hook.Add("EntityTakeDamage", "TWeps_EntityTakeDamage", TWeps_EntityTakeDamage)

local mc = math.Clamp
local gcc = game.ConsoleCommand

local function TWeps_ApplyChanges(ply)
	if not ply:IsAdmin() then
		return
	end

	gcc("cstm_accuracymod_aim " .. mc(tonumber(ply:GetInfo("cstm_accuracymod_aim_cl")), 0.2, 2) .. "\n")
	gcc("cstm_accuracymod_hip " .. mc(tonumber(ply:GetInfo("cstm_accuracymod_hip_cl")), 0.2, 2) .. "\n")
	gcc("cstm_recoilmod " .. mc(tonumber(ply:GetInfo("cstm_recoilmod_cl")), 0.2, 2) .. "\n")
	gcc("cstm_damagemod " .. mc(tonumber(ply:GetInfo("cstm_damagemod_cl")), 0.2, 2) .. "\n")
	
	timer.Simple(0.1, function()
		SetGlobalFloat("CR", GetConVarNumber("cstm_recoilmod"))
	end)
	
	for k, v in pairs(CWAttachments) do
		gcc("cstm_att_" .. v.key .. " " .. mc(tonumber(ply:GetInfo("cstm_att_" .. v.key .. "_cl")), 0, 1) .. "\n")
	end
	
	for k, v in pairs(CWInternalParts) do
		gcc("cstm_part_" .. v.key .. " " .. mc(tonumber(ply:GetInfo("cstm_part_" .. v.key .. "_cl")), 0, 1) .. "\n")
	end
	
	gcc("cstm_ammo_incendiary " .. mc(tonumber(ply:GetInfo("cstm_ammo_incendiary_cl")), 0, 1) .. "\n")
	gcc("cstm_ammo_ap " .. mc(tonumber(ply:GetInfo("cstm_ammo_ap_cl")), 0, 1) .. "\n")
	gcc("cstm_ammo_hp " .. mc(tonumber(ply:GetInfo("cstm_ammo_hp_cl")), 0, 1) .. "\n")
	gcc("cstm_ammo_magnum " .. mc(tonumber(ply:GetInfo("cstm_ammo_magnum_cl")), 0, 1) .. "\n")
	gcc("cstm_ammo_slug " .. mc(tonumber(ply:GetInfo("cstm_ammo_slug_cl")), 0, 1) .. "\n")
	gcc("cstm_ammo_birdshot " .. mc(tonumber(ply:GetInfo("cstm_ammo_birdshot_cl")), 0, 1) .. "\n")
	gcc("cstm_ammo_frag " .. mc(tonumber(ply:GetInfo("cstm_ammo_frag_cl")), 0, 1) .. "\n")
	gcc("cstm_ammo_smoke " .. mc(tonumber(ply:GetInfo("cstm_ammo_smoke_cl")), 0, 1) .. "\n")
end

concommand.Add("cstm_applychanges", TWeps_ApplyChanges)

local function TWeps_ResetSettings(ply)
	if not ply:IsAdmin() then
		return
	end

	gcc("cstm_accuracymod_aim 1\n")
	gcc("cstm_accuracymod_hip 1\n")
	gcc("cstm_recoilmod 1\n")
	gcc("cstm_damagemod 1\n")
	
	for k, v in pairs(CWAttachments) do
		gcc("cstm_att_" .. v.key .. " 0\n")
		ply:ConCommand("cstm_att_" .. v.key .. "_cl 0")
	end
	
	for k, v in pairs(CWInternalParts) do
		gcc("cstm_part_" .. v.key .. " 0\n")
		ply:ConCommand("cstm_part_" .. v.key .. "_cl 0")
	end
	
	gcc("cstm_ammo_incendiary 0\n")
	gcc("cstm_ammo_ap 0\n")
	gcc("cstm_ammo_hp 0\n")
	gcc("cstm_ammo_magnum 0\n")
	gcc("cstm_ammo_slug 0\n")
	gcc("cstm_ammo_birdshot 0\n")
	gcc("cstm_ammo_frag 0\n")
	gcc("cstm_ammo_smoke 0\n")
	
	ply:ConCommand("cstm_accuracymod_aim_cl 1")
	ply:ConCommand("cstm_accuracymod_hip_cl 1")
	ply:ConCommand("cstm_recoilmod_cl 1")
	ply:ConCommand("cstm_damagemod_cl 1")
	
	ply:ConCommand("cstm_ammo_incendiary_cl 0")
	ply:ConCommand("cstm_ammo_ap_cl 0")
	ply:ConCommand("cstm_ammo_hp_cl 0")
	ply:ConCommand("cstm_ammo_magnum_cl 0")
	ply:ConCommand("cstm_ammo_slug_cl 0")
	ply:ConCommand("cstm_ammo_birdshot_cl 0")
	ply:ConCommand("cstm_ammo_frag_cl 0")
	ply:ConCommand("cstm_ammo_smoke_cl 0")
	
	SetGlobalFloat("CR", 1)
end

concommand.Add("cstm_resetsettings", TWeps_ResetSettings)

local s
	
local AutoAmmo = {
	["cstm_ammo_incendiary"] = "incendiary",
	["cstm_ammo_ap"] = "ap",
	["cstm_ammo_hp"] = "hp",
	["cstm_ammo_magnum"] = "magnum",
	["cstm_ammo_slug"] = "slug",
	["cstm_ammo_birdshot"] = "birdshot",
	["cstm_ammo_frag"] = "frag",
	["cstm_ammo_smoke"] = "smoke"}

local function TWeps_PlayerSpawn(ply)
	if gamemode.Get("bro-op") then
		return
	end
	
	ply.Attachments = {}
	ply.InternalParts = {}
	ply.AmmoTypes = {}
	s = ""
	
	for k, v in pairs(AutoAtt) do
		if GetConVarNumber(k) >= 1 then
			s = s .. " " .. v
			table.insert(ply.Attachments, v)
		end
	end
	
	if s != "" then
		umsg.Start("GETATTS", ply)
			umsg.String(s)
		umsg.End()
	else
		SendUserMessage("NOATTS", ply)
	end
	
	s = ""
	
	for k, v in pairs(AutoPart) do
		if GetConVarNumber(k) >= 1 then
			s = s .. " " .. v
			table.insert(ply.InternalParts, v)
		end
	end
	
	if s != "" then
		umsg.Start("GETPARTS", ply)
			umsg.String(s)
		umsg.End()
	else
		SendUserMessage("NOPARTS", ply)
	end
	
	s = ""
	
	for k, v in pairs(AutoAmmo) do
		if GetConVarNumber(k) >= 1 then
			s = s .. " " .. v
			table.insert(ply.AmmoTypes, v)
		end
	end
	
	if s != "" then
		umsg.Start("GETAMMO", ply)
			umsg.String(s)
		umsg.End()
	else
		SendUserMessage("NOAMMO", ply)
	end
end

hook.Add("PlayerSpawn", "TWeps_PlayerSpawn", TWeps_PlayerSpawn)

local PLY = debug.getregistry().Player

function PLY:HasAttachment(att)
	if table.HasValue(self.Attachments, att) then
		return true
	end
	
	return false
end

function PLY:PickUpAttachment(att, sil)
	table.insert(self.Attachments, att)
	
	if sil then
		umsg.Start("PICKUPATTSIL", self)
			umsg.String(att)
		umsg.End()
	else
		umsg.Start("PICKUPATT", self)
			umsg.String(att)
		umsg.End()
	end
end

function PLY:HasInternalPart(part)
	if table.HasValue(self.InternalParts, part) then
		return true
	end
	
	return false
end

function PLY:PickUpInternalPart(part, sil)
	if table.HasValue(self.InternalParts, part) then
		return
	end
	
	table.insert(self.InternalParts, part)
	
	if sil then
		umsg.Start("PICKUPPARTSIL", self)
			umsg.String(part)
		umsg.End()
	else
		umsg.Start("PICKUPPART", self)
			umsg.String(part)
		umsg.End()
	end
end

function PLY:HasAmmoType(am)
	if table.HasValue(self.AmmoTypes, am) then
		return true
	end
	
	return false
end

function PLY:PickUpAmmoType(am, sil)
	if table.HasValue(self.AmmoTypes, am) then
		return
	end
	
	table.insert(self.AmmoTypes, am)
	
	if sil then
		umsg.Start("PICKUPAMMOSIL", self)
			umsg.String(am)
		umsg.End()
	else
		umsg.Start("PICKUPAMMO", self)
			umsg.String(am)
		umsg.End()
	end
end

function PLY:RemoveAttachment(att)
	if not table.HasValue(self.Attachments, att) then
		return
	end
	
	for k, v in pairs(self.Attachments) do
		if v == att then
			table.remove(self.Attachments, k)
			
			net.Start("SENDATTACHMENTS")
				net.WriteTable(self.Attachments)
			net.Send(self)
			
			break
		end
	end
end

function PLY:RemoveAmmoType(am)
	if not table.HasValue(self.AmmoTypes, am) then
		return
	end
	
	for k, v in pairs(self.AmmoTypes) do
		if v == am then
			table.remove(self.AmmoTypes, k)
			
			net.Start("SENDAMMOTYPES")
				net.WriteTable(self.AmmoTypes)
			net.Send(self)
			
			break
		end
	end
end

function PLY:RemoveAttachments()
	self.Attachments = {}
	SendUserMessage("NOATTS", self)
end

function PLY:RemoveAmmoTypes()
	self.AmmoTypes = {}
	SendUserMessage("NOAMMO", self)
end