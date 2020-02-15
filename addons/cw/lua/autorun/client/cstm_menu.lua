cstmmenu = {}
cstmmenu.PanelB = nil

-- These convars are used to communicate between the client and the server when the player presses "apply changes"

CreateClientConVar("cstm_accuracymod_aim_cl", "1", true, true)
CreateClientConVar("cstm_accuracymod_hip_cl", "1", true, true)
CreateClientConVar("cstm_recoilmod_cl", "1", true, true)
CreateClientConVar("cstm_damagemod_cl", "1", true, true)

CreateClientConVar("cstm_ammo_incendiary_cl", "0", true, true)
CreateClientConVar("cstm_ammo_ap_cl", "0", true, true)
CreateClientConVar("cstm_ammo_hp_cl", "0", true, true)
CreateClientConVar("cstm_ammo_magnum_cl", "0", true, true)
CreateClientConVar("cstm_ammo_slug_cl", "0", true, true)
CreateClientConVar("cstm_ammo_birdshot_cl", "0", true, true)
CreateClientConVar("cstm_ammo_frag_cl", "0", true, true)
CreateClientConVar("cstm_ammo_smoke_cl", "0", true, true)


local smtext = draw.SimpleText

function draw.ShadowedText(text, font, x, y, color, shadowcolor, shadowdist, al, ar, dynamic)
	if dynamic then
		HP = LocalPlayer():Health() / 100
		color = Color(200, 255 * HP, 150 * HP, 255)
	end
	
	smtext(text, font, x + shadowdist, y + shadowdist, shadowcolor, (al or TEXT_ALIGN_LEFT), (ar or TEXT_ALIGN_CENTER))
	smtext(text, font, x, y, color, (al or TEXT_ALIGN_LEFT), (ar or TEXT_ALIGN_CENTER))
end

local stext, rbox, rboxex, clr, rect, orect, vcret, tid, tex, trect = draw.ShadowedText, draw.RoundedBox, draw.RoundedBoxEx, surface.SetDrawColor, surface.DrawRect, surface.DrawOutlinedRect, vgui.Create, surface.GetTextureID, surface.SetTexture, surface.DrawTexturedRect
local ply, wep, w, h, f, a, att, vm, f2

local AmmoDesc = {
	["Incendiary"] = {
		[1] = {t = "Ignites hit target for 6 seconds.", c = Color(150, 255, 150, 255)},
		[2] = {t = "Only ignites targets that are within the weapon's 50% effective range.", c = Color(255, 110, 96, 255)},
		[3] = {t = "Loses ignitive ability after penetrating or ricocheting off a surface.", c = Color(255, 110, 96, 255)},
		[4] = {t = "Deals 70% damage.", c = Color(255, 110, 96, 255)},
		[5] = {t = "Decreases penetrative effectiveness by 25%", c = Color(255, 110, 96, 255)}},
		
	["Armor Piercing"] = {
		[1] = {t = "Deals 130% damage to armored NPCs, players and props.", c = Color(150, 255, 150, 255)},
		[2] = {t = "Increases penetrative effectiveness by 15%", c = Color(150, 255, 150, 255)},
		[3] = {t = "Deals 70% damage to unarmored NPCs or players.", c = Color(255, 110, 96, 255)},},
		
	["Hollow Point"] = {
		[1] = {t = "Deals 130% damage to unarmored NPCs, players.", c = Color(150, 255, 150, 255)},
		[2] = {t = "Deals 70% damage to armored NPCs or players and props.", c = Color(255, 110, 96, 255)},
		[3] = {t = "Decreases penetrative effectiveness by 15%", c = Color(255, 110, 96, 255)}},
		
	["Magnum"] = {
		[1] = {t = "Increases damage by 25%", c = Color(150, 255, 150, 255)},
		[2] = {t = "Increases penetrative effectiveness by 10%", c = Color(150, 255, 150, 255)},
		[3] = {t = "Increases recoil by 25%", c = Color(255, 110, 96, 255)}},
		
	["Slug"] = {
		[1] = {t = "Fires out a single very accurate slug round.", c = Color(150, 255, 150, 255)}},
		
	["Birdshot"] = {
		[1] = {t = "Fires out 20 pellets.", c = Color(150, 255, 150, 255)},
		[2] = {t = "Decreases recoil by 50%.", c = Color(150, 255, 150, 255)},
		[3] = {t = "Greatly decreases accuracy.", c = Color(255, 110, 96, 255)},
		[4] = {t = "Decreases penetrative effectiveness by 50%", c = Color(255, 110, 96, 255)}},
		
	["Frag"] = {
		[1] = {t = "Fires out a single very accurate explosive round.", c = Color(150, 255, 150, 255)},
		[2] = {t = "Greatly affected by gravity.", c = Color(255, 110, 96, 255)},
		[3] = {t = "Much slower than regular bullets.", c = Color(255, 110, 96, 255)}},
		
	["Smoke"] = {
		[1] = {t = "Fires out a single very accurate smoke grenade.", c = Color(150, 255, 150, 255)},
		[2] = {t = "Greatly affected by gravity.", c = Color(255, 110, 96, 255)},
		[3] = {t = "Much slower than regular bullets.", c = Color(255, 110, 96, 255)}}}

local P = {}
local c, desc, entry
local Gradient = surface.GetTextureID("VGUI/gradient")

function P:Init()
	self.Alpha = 0
	self.White = Color(255, 255, 255, 0)
	self.Black = Color(0, 0, 0, 0)
	self.Grey = Color(50, 50, 50, 0)
	self.Blue = Color(68, 78, 96)
end

function P:Paint()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	if not wep.IsCSTMWeapon then
		self:Remove()
		return
	end
	
	if not self.DontRepos then
		vm = ply:GetViewModel()
		
		if IsValid(vm) then
			att = vm:GetAttachment("1").Pos:ToScreen()
			self:SetPos(math.max(50, att.x - 100), att.y + self.Off - 50)
		end
	end
	
	w, h = self:GetSize()
	rbox(6, 0, 0, w, h, self.Grey)
	rboxex(6, 2, 2, w - 4, 15, self.Blue, true, true, false, false)
	stext("[" .. self.Key .. "]", "VBFONT_DERMANORMAL", 15, 9, self.White, self.Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	f = false
	desc = GetConVarNumber("cstm_attdesc")
	
	 if wep.Attachments[self.Key] then
	 	for k, v in pairs(wep.Attachments[self.Key]) do
	 		entry = wep.VElements[v]
		
	 		if entry and entry.color.a == 255 then
	 			entry = CWAttachments[v]
	 			stext(entry.name, "VBFONT_DERMANORMAL", 30, 9, self.White, self.Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	 			f = true
			end
		end
	end
				
	-- 			if desc > 0 then
	-- 				if not self.DescSize or self.DescSize.last != v then -- don't run the size calculations every time
	-- 					surface.SetFont("VBFONT_DERMANORMAL")
	-- 					AddX, AddY = 10, 4
						
	-- 					for k2, v2 in pairs(entry.description) do
	-- 						x, y = surface.GetTextSize(v2.t)
							
	-- 						if x + 10 > AddX then
	-- 							AddX = x + 10
	-- 						end
							
	-- 						AddY = AddY + 13
	-- 					end
						
	-- 					self.DescSize = {x = AddX, y = AddY, last = v}
	-- 				end
					
	-- 				if self.DescSize then
	-- 					DisableClipping(true)
	-- 						t = self.DescSize
	-- 						clr(84, 141, 255, self.Alpha)
	-- 						orect(w + 5, 0, t.x, t.y)
							
	-- 						clr(50, 50, 50, self.Alpha * 0.8)
	-- 						rect(w + 6, 1, t.x - 2, t.y - 2)
							
	-- 						for k2, v2 in pairs(entry.description) do
	-- 							v2.c.a = self.Alpha
	-- 							stext(v2.t, "VBFONT_DERMANORMAL", w + 10, (k2 - 1) * 13 + 8, v2.c, self.Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 						end
	-- 					DisableClipping(false)
	-- 				end
	-- 			end
	-- 		end
	-- 	end
	-- end
	
	if not f then
		stext("None", "VBFONT_DERMANORMAL", 30, 9, self.White, self.Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		self.DescSize = nil
	end
	
	if wep.WeaponOverview then
		self.Alpha = Lerp(FrameTime() * 20, self.Alpha, 0)
	else
		self.Alpha = Lerp(FrameTime() * 20, self.Alpha, 255)
	end
	
	self.White.a = self.Alpha / 1.275
	self.Black.a = self.Alpha
	self.Grey.a = self.Alpha / 1.7
	self.Blue.a = self.Alpha
end

vgui.Register("AttachmentSelectionPanel", P, "DPanel")

P = {}

local AddX, AddY, x, y, t, pw, p, pp

function P:Init()
	self.Alpha = 0
	self.White = Color(255, 255, 255, 0)
	self.Black = Color(0, 0, 0, 0)
	self.Grey = Color(50, 50, 50, 0)
	self.Blue = Color(68, 78, 96)
end

function P:Paint()
	if not wep.IsCSTMWeapon then
		self:Remove()
		return
	end
	
	f, f2 = false, false
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	p = self:GetParent()
	a = p.Alpha
	
	if table.HasValue(AttOnMe, self.Att) then
		entry = wep.VElements[self.Att]
		
		if entry and entry.color.a == 255 then
			clr(163, 255, 84, a)
		else
			clr(84, 141, 255, a)
		end
		
		f = true
	else
		clr(255, 95, 10, a)
	end
	
	rect(0, 0, 50, 50)
	
	if not f then
		clr(150, 150, 150, a)
	else
		clr(255, 255, 255, a)
	end
	
	tex(self.Texture)
	trect(1, 1, 48, 48)
end

vgui.Register("AttachmentIcon", P, "DPanel")

-- INTERNAL PART SELECTION PANELS

P = {}

function P:Init()
	self.Alpha = 0
	self.White = Color(255, 255, 255, 0)
	self.Black = Color(0, 0, 0, 0)
	self.Grey = Color(50, 50, 50, 0)
	self.Blue = Color(68, 78, 96)
end

function P:Paint()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	if not wep.IsCSTMWeapon then
		self:Remove()
		return
	end
	
	if not self.DontRepos then
		vm = ply:GetViewModel()
		
		if IsValid(vm) then
			att = vm:GetAttachment("1").Pos:ToScreen()
			self:SetPos(math.max(50, att.x - 100), att.y + self.Off - 50)
		end
	end
	
	w, h = self:GetSize()
	rbox(6, 0, 0, w, h, self.Grey)
	rboxex(6, 2, 2, w - 4, 15, self.Blue, true, true, false, false)
	stext("[" .. self.Key .. "]", "VBFONT_DERMANORMAL", 15, 9, self.White, self.Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	f = false
	desc = GetConVarNumber("cstm_attdesc")
	
	if not f then
		stext("None", "VBFONT_DERMANORMAL", 30, 9, self.White, self.Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		self.DescSize = nil
	end
	
	if wep.WeaponOverview then
		self.Alpha = Lerp(FrameTime() * 20, self.Alpha, 0)
	else
		self.Alpha = Lerp(FrameTime() * 20, self.Alpha, 255)
	end
	
	self.White.a = self.Alpha / 1.275
	self.Black.a = self.Alpha
	self.Grey.a = self.Alpha / 1.7
	self.Blue.a = self.Alpha
end

vgui.Register("IPSelectionPanel", P, "DPanel")

P = {}

function P:Init()
	self.Alpha = 0
	self.White = Color(255, 255, 255, 0)
	self.Black = Color(0, 0, 0, 0)
	self.Grey = Color(50, 50, 50, 0)
	self.Blue = Color(68, 78, 96)
end

function P:Paint()
	if not wep.IsCSTMWeapon then
		self:Remove()
		return
	end
	
	f, f2 = false, false
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	p = self:GetParent()
	a = p.Alpha
	
	if table.HasValue(PartOnMe, self.Part) then
		entry = wep.InternalParts[self.PartKey][self.PartKey2].active
		
		if entry then
			clr(163, 255, 84, a)
		else
			clr(84, 141, 255, a)
		end
		
		f = true
	else
		clr(255, 95, 10, a)
	end
	
	rect(0, 0, 50, 50)
	
	if not f then
		clr(150, 150, 150, a)
	else
		clr(255, 255, 255, a)
	end
	
	tex(self.Texture)
	trect(1, 1, 48, 48)
end

vgui.Register("IPIcon", P, "DPanel")

-- AMMO SELECTION PANELS

P = {}

function P:Init()
	self.Alpha = 0
	self.White = Color(255, 255, 255, 0)
	self.Black = Color(0, 0, 0, 0)
	self.Grey = Color(50, 50, 50, 0)
	self.Blue = Color(68, 78, 96)
end

function P:Paint()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	if not wep.IsCSTMWeapon then
		self:Remove()
		return
	end
	
	if not self.DontRepos then
		vm = ply:GetViewModel()
		
		if IsValid(vm) then
			att = vm:GetAttachment("1").Pos:ToScreen()
			
			self:SetPos(math.max(50, att.x - 100), att.y + self.Off - 50)
		end
	end
	
	w, h = self:GetSize()
	rbox(6, 0, 0, w, h, self.Grey)
	rboxex(6, 2, 2, w - 4, 15, self.Blue, true, true, false, false)
	stext("[R]", "VBFONT_DERMANORMAL", 15, 9, self.White, self.Black, 1, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	f = false
	desc = GetConVarNumber("cstm_attdesc")
	
	if wep.AmmoTypes then
		for k, v in pairs(wep.AmmoTypes) do
			if wep.LastAmmo != "Normal" then
				stext(wep.LastAmmo .. " Ammo", "VBFONT_DERMANORMAL", 30, 9, self.White, self.Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				f = true
				break
			end
		end
		
	-- 	if f then
	-- 		if desc > 0 then
	-- 			entry = AmmoDesc[wep.LastAmmo]
				
	-- 			if not self.DescSize or self.DescSize.last != wep.LastAmmo then -- don't run the size calculations every time
	-- 				surface.SetFont("VBFONT_DERMANORMAL")
	-- 				AddX, AddY = 10, 4
					
	-- 				if entry then
	-- 					for k2, v2 in pairs(entry) do
	-- 						x, y = surface.GetTextSize(v2.t)
							
	-- 						if x + 10 > AddX then
	-- 							AddX = x + 10
	-- 						end
							
	-- 						AddY = AddY + 13
	-- 					end
						
	-- 					self.DescSize = {x = AddX, y = AddY, last = wep.LastAmmo}
	-- 				end
	-- 			end
				
	-- 			if self.DescSize then
	-- 				DisableClipping(true)
	-- 					t = self.DescSize
	-- 					clr(84, 141, 255, self.Alpha)
	-- 					orect(w + 5, 0, t.x, t.y)
						
	-- 					clr(50, 50, 50, self.Alpha * 0.8)
	-- 					rect(w + 6, 1, t.x - 2, t.y - 2)
						
	-- 					for k2, v2 in pairs(entry) do
	-- 						v2.c.a = self.Alpha
	-- 						stext(v2.t, "VBFONT_DERMANORMAL", w + 10, (k2 - 1) * 13 + 8, v2.c, self.Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	-- 					end
	-- 				DisableClipping(false)
	-- 			end
	-- 		end
	-- 	end
	 end
	
	if not f then
		stext("Standard Ammo", "VBFONT_DERMANORMAL", 30, 9, self.White, self.Black, 1, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		self.DescSize = nil
	end
	
	if wep.WeaponOverview then
		self.Alpha = Lerp(FrameTime() * 20, self.Alpha, 0)
	else
		self.Alpha = Lerp(FrameTime() * 20, self.Alpha, 255)
	end
	
	self.White.a = self.Alpha / 1.275
	self.Black.a = self.Alpha
	self.Grey.a = self.Alpha / 1.7
	self.Blue.a = self.Alpha
end

vgui.Register("AmmoSelectionPanel", P, "DPanel")

P = {}
local Ammo = surface.GetTextureID("VGUI/entities/upgr_lasersight")

function P:Init()
	self.Alpha = 0
	self.White = Color(255, 255, 255, 0)
	self.Black = Color(0, 0, 0, 0)
	self.Grey = Color(50, 50, 50, 0)
	self.Blue = Color(68, 78, 96)
end

function P:Paint()
	if not wep.IsCSTMWeapon then
		self:Remove()
		return
	end
	
	f, f2 = false, false
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	p = self:GetParent()
	a = p.Alpha
	
	if table.HasValue(AmmoOnMe, self.Ammo) then
		if wep.LastAmmo == AmmoTypes[self.Ammo].name then
			clr(163, 255, 84, a)
		else
			clr(84, 141, 255, a)
		end
		
		f = true
	else
		clr(255, 95, 10, a)
	end
	
	rect(0, 0, 50, 50)
	
	if not f then
		clr(150, 150, 150, a)
	else
		clr(255, 255, 255, a)
	end
	
	tex(Ammo)
	trect(1, 1, 48, 48)
end

vgui.Register("AmmoIcon", P, "DPanel")