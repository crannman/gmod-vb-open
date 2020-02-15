local Current = "none"
local ply, wep, vm, Mode, alpha, num, amt, nw_wep, nw_num
	
local function ReceiveAlpha(um)
	wep = um:ReadEntity()
	alpha = um:ReadShort()
		
	if IsValid(wep) then
		wep.VElements["silencer"].color.a = alpha
		
		if wep.WElements["silencer"] then
			wep.WElements["silencer"].color.a = alpha
		end
		
		if wep.VElements["silencer2"] then
			wep.VElements["silencer2"].color.a = alpha
			wep.WElements["silencer2"].color.a = alpha
		end
	end
end
	
usermessage.Hook("NWAlpha", ReceiveAlpha)
	
local function DoVMStuff(um)
	ply = LocalPlayer()
	
	if not IsValid(ply) or not ply:Alive() then
		return
	end
	
	wep = ply:GetActiveWeapon()
	vm = ply:GetViewModel()
	
	if not wep.BoneMod then
		wep.BoneMod = {}
	end
	
	if wep.BoneMod then
		wep.BoneMod.cur = {}
		
		for i = 1, vm:GetBoneCount() - 1 do
			wep.BoneMod.cur[vm:GetBoneName(i)] = {curoffset = Vector(0, 0, 0), currotation = Angle(0, 0, 0)}
		end
	end
end

usermessage.Hook("DOVMSTUFF", DoVMStuff)

local GrenadeTypes = {
	[1] = {t = "40MM HE", am = "40MM_HE"}, 
	[2] = {t = "40MM CE", am = "40MM_CE"}, 
	[3] = {t = "40MM SMOKE", am = "40MM_Smoke"}}

local function Receive40MMType(um)
	num = um:ReadShort()
	ply = LocalPlayer()
	
	if not IsValid(ply) or not ply:Alive() then
		return
	end
	
	wep = ply:GetActiveWeapon()
	wep.GrenadeName = GrenadeTypes[num].t
	wep.Secondary.Ammo = GrenadeTypes[num].am
end

usermessage.Hook("40MMTYPE", Receive40MMType)

local nw_num, nw_wep
	
local function DoStuffWithModels(num, ent)
	Current = CWAttachments[CWAttachmentsMeta[num]]
	
	if not Current then
		return
	end
	
	if not ent.VElements or not ent.WElements then
		return
	end
	
	if Current.modelattfunc then
		Current.modelattfunc(ent)
	end
	
	if Current.scope then
		ent.ScopeRenderFunc = Current.scope.renderfunc
		ent.FovMod = Current.scope.fovmod
	end
	
	if Current.clattfunc then
		Current.clattfunc(ent)
	end
	
	if Current.incompability then
		for k, v in pairs(ent.VElements) do
			for k2, v2 in pairs(Current.incompability) do
				if k == v2 then
					v.color.a = 0
				end
			end
		end
		
		ent.VElements[Current.key].color.a = 255
			
		if ent.WElements then
			for k, v in pairs(ent.WElements) do
				for k2, v2 in pairs(Current.incompability) do
					if k == v2 then
						v.color.a = 0
					end
				end
			end
			
			if ent.WElements[Current.key] then
				ent.WElements[Current.key].color.a = 255
			end
		end
	else
		ent.VElements[Current.key].color.a = 255
		
		if ent.WElements[Current.key] then
			ent.WElements[Current.key].color.a = 255
		end
	end

	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	ent.ScaleBonesWhenAttached = true
	
	if ent == wep then
		surface.PlaySound("weapons/cstm/attach.wav")
		
		for k, v in ipairs(wep.Attachments) do
			for k2, v2 in ipairs(v) do
				if v2 == Current.key then
					table.insert(wep.Attachments[k].last, Current.key)
				end
			end
		end
	end
end

local function ReceiveAttachmentNumber2(um)
	nw_wep = um:ReadEntity()
	nw_num = um:ReadShort()
	
	DoStuffWithModels(nw_num, nw_wep)
end

usermessage.Hook("NWATT2", ReceiveAttachmentNumber2)

local function ReceiveInternalPart(um)
	nw_num = um:ReadShort()
	Current = CWInternalParts[CWInternalPartsMeta[nw_num]]
	
	if not Current then
		return
	end
	
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	surface.PlaySound("weapons/cstm/ammo_select.wav")
		
	for k, v in ipairs(wep.InternalParts) do
		for k2, v2 in ipairs(v) do
			if v2.key == Current.key then
				for k3, v3 in pairs(wep.InternalParts[k]) do
					v3.active = false
				end
				
				v2.active = true
				table.insert(wep.InternalParts[k].last, Current.key)
			end
		end
	end
end

usermessage.Hook("INTERNALPART", ReceiveInternalPart)

local function RemoveInternalPart(um)
	nw_num = um:ReadShort()
	Current = CWInternalParts[CWInternalPartsMeta[nw_num]]
	
	if not Current then
		return
	end
	
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	surface.PlaySound("weapons/cstm/ammo_deselect.wav")
	
	for k, v in ipairs(wep.InternalParts) do
		for k2, v2 in ipairs(v) do
			if v2.key == Current.key then
				v2.active = false
				wep.InternalParts[k].last = {}
			end
		end
	end
end

usermessage.Hook("INTERNALPARTREM", RemoveInternalPart)

local function ReceiveAmmoType(um)
	num = um:ReadString()
	
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	wep.LastAmmo = AmmoTypes[num].name
	wep.PenMod = AmmoTypes[num].penmod
	table.insert(wep.AmmoCycle, num)
	surface.PlaySound("weapons/cstm/ammo_select.wav")
end

usermessage.Hook("NWAMMO", ReceiveAmmoType)

local function DeselectAmmoType(um)
	num = um:ReadString()
	
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	wep.LastAmmo = "Normal"
	wep.PenMod = 1
	wep.AmmoCycle = {}
	surface.PlaySound("weapons/cstm/ammo_deselect.wav")
end

usermessage.Hook("DESELECTAMMO", DeselectAmmoType)

local function RemoveAttachment(um)
	nw_wep = um:ReadEntity()
	nw_num = um:ReadShort()
	
	if IsValid(nw_wep) and nw_wep.VElements then
		Current = CWAttachments[CWAttachmentsMeta[nw_num]]
	
		if Current.cldeattfunc then
			Current.cldeattfunc(nw_wep)
		end
		
		if Current.scope then
			nw_wep.ScopeRenderFunc = nil
		end
			nw_wep.VElements[Current.key].color.a = 0
		
		if nw_wep.WElements then
			if nw_wep.WElements[Current.key] then
				nw_wep.WElements[Current.key].color.a = 0
			end
		end
		
		nw_wep.ScaleBonesWhenAttached = false
		
		ply = LocalPlayer()
		wep = ply:GetActiveWeapon()
		
		if nw_wep == wep then
			surface.PlaySound("weapons/cstm/detach.wav")
			
			for k, v in ipairs(wep.Attachments) do
				for k2, v2 in ipairs(v) do
					if v2 == Current.key then
						wep.Attachments[k].last = {}
					end
				end
			end
		end
	end
end

usermessage.Hook("NWRATT", RemoveAttachment)

local function ReceiveReloadSpeed(um)
	wep = um:ReadEntity()
	amt = um:ReadFloat()
	
	if IsValid(wep) then
		wep.ReloadSpeed = amt
	end
end

usermessage.Hook("NWSPD", ReceiveReloadSpeed)

local function ReceiveHT(um)
	wep = um:ReadEntity()
	
	if IsValid(wep) and wep.SetWeaponHoldType then
		wep:SetWeaponHoldType(um:ReadString())
	end
end

usermessage.Hook("NWHT", ReceiveHT)

local function ReceiveNumBul(um)
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	
	if IsValid(ply) and IsValid(wep) then
		wep.Primary.NumShots = um:ReadShort()
	end
end

usermessage.Hook("NBUL", ReceiveNumBul)

local function ReceiveFireMode(um)
	ply = um:ReadEntity()
	Mode = um:ReadString()
	wep = ply:GetActiveWeapon()
	wep.FireMode = Mode
	
	if IsValid(ply) and IsValid(wep) then
		if wep.FireModeNames then
			t = wep.FireModeNames[Mode]
			
			wep.Primary.Automatic = t.auto
			wep.Bullets = t.bul
			wep.Safe = t.safe
			
			if wep.Safe then
				if wep.HoldType == "pistol" then
					wep:SetWeaponHoldType("normal")
				else
					wep:SetWeaponHoldType("passive")
				end
			else
				wep:SetWeaponHoldType(wep.HoldType)
			end
			
			if ply == LocalPlayer() then
				surface.PlaySound("weapons/cstm/firemode" .. math.random(1, 2) .. ".wav")
			end
		end
	end
end

usermessage.Hook("FRMD", ReceiveFireMode)

local function CSTM_Recoil()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	vm = ply:GetViewModel()
	
	wep.RecoilAmt = wep.DefRecoil * wep:GetDTFloat(1)
	wep.RecoilTime = CurTime() + 0.5
	wep:MuzzleFlosh()
end

usermessage.Hook("RECOIL", CSTM_Recoil)

local function M203_On()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	wep.Grenade = true
end

usermessage.Hook("M203_ON", M203_On)

local function M203_Off()
	ply = LocalPlayer()
	wep = ply:GetActiveWeapon()
	wep.Grenade = false
end

usermessage.Hook("M203_OFF", M203_Off)