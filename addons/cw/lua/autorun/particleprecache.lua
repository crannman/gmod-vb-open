game.AddParticles("particles/cstm_muzzleflashes.pcf")
game.AddParticles("particles/cstm_muzzleflashes2.pcf")

PrecacheParticleSystem("cstm_child_sparks_small")
PrecacheParticleSystem("cstm_child_sparks_medium")
PrecacheParticleSystem("cstm_child_sparks_large")
PrecacheParticleSystem("cstm_child_sparks_verylarge")
PrecacheParticleSystem("cstm_child_smoke_small")
PrecacheParticleSystem("cstm_child_smoke_medium")
PrecacheParticleSystem("cstm_child_smoke_large")
PrecacheParticleSystem("cstm_child_smoke_verylarge")
PrecacheParticleSystem("cstm_child_muzzle_small")
PrecacheParticleSystem("cstm_child_muzzle_medium")
PrecacheParticleSystem("cstm_child_muzzle_large")
PrecacheParticleSystem("cstm_child_heat")
PrecacheParticleSystem("cstm_muzzle_pistol")
PrecacheParticleSystem("cstm_muzzle_smg")
PrecacheParticleSystem("cstm_muzzle_ar")
PrecacheParticleSystem("cstm_muzzle_br")
PrecacheParticleSystem("cstm_incendiary_hit")
PrecacheParticleSystem("cstm_frag_fly")
PrecacheParticleSystem("cstm_frag_expl")

local pmodel = util.PrecacheModel

pmodel("models/attachments/kascope.mdl")
pmodel("models/attachments/cmore.mdl")
pmodel("models/bunneh/scope01.mdl")
pmodel("models/wystan/cmag.mdl")
pmodel("models/wystan/2cog.mdl")
pmodel("models/wystan/2octorrds.mdl")
pmodel("models/wystan/2otech557sight.mdl")
pmodel("models/wystan/aimpoint.mdl")
pmodel("models/wystan/akrailmount.mdl")
pmodel("models/wystan/bipod.mdl")
pmodel("models/wystan/foregrip1.mdl")
pmodel("models/wystan/m203.mdl")
pmodel("models/wystan/rail.mdl")
pmodel("models/props_c17/oildrum001.mdl")
pmodel("models/props_c17/FurnitureBoiler001a.mdl")

/*timer.Simple(3, function()
	for k, v in pairs(weapons.GetList()) do
		if v.ThisClass and v.ThisClass:find("cstm_") then
			if v.ViewModel then
				pmodel(v.ViewModel)
			end
		end
	end
end)*/

FS = {}
FS["CSTM_SilencedShot"] = "weapons/m4a1/m4a1-1.wav"

local tbl = {channel = CHAN_WEAPON,
	volume = 1,
	soundlevel = 120,
	pitchstart = 100,
	pitchend = 100}
	
for k, v in pairs(FS) do
	tbl.name = k
	tbl.sound = v
		
	sound.Add(tbl)
end	

AttEnum = {
	["acog"] = 2,
	["aimpoint"] = 3,
	["eotech"] = 4,
	["kobra"] = 5,
	["grenadelauncher"] = 6,
	["vertgrip"] = 7,
	["cmag"] = 8,
	["reflex"] = 9,
	["laser"] = 10,
	["bipod"] = 11,
	["riflereflex"] = 12,
	["ballistic"] = 13,
	["elcan"] = 14}
	
CWAttachments = {}
CWAttachmentsMeta = {}
CWInternalParts = {}
CWInternalPartsMeta = {}

local clip, ammo, x, y, old, FT, ply, Lens
local BlackAmt, CamData, Ini = 1, {}, true

if CLIENT then
	Lens = surface.GetTextureID("models/wystan/attachments/acog/lense2")
end

--[[
The following function allows you to register a weapon attachment for use with Customizable Weaponry weapons.
The first argument (key) should be a string. This argument has to be what you're going to call the attachment's VElement and WElement name.
The second argument (name) should be a string. The name should NOT match any other attachment names.
The third argument (num) should be the attachment's number. This number should NOT match any other attachment numbers.
The fourth argument (displaytexture) should be the attachment's texture it's going to use in the customization menu. It needs to be set on the client.
The fifth argument (scope) should be a table. If it's going to be a scope attachment - here is where shit gets tricky; if it's not going to be a scope - set it to false or nil.

== == == == == == == == == == == ==
The first variable within the scope table you're going to set is the aiming texture, this variable is called mat.

The second variable is going to be the size of the texture, this variable is called size. The size should lower as texture resolution rises.
So if you are going to draw a 64x64 texture, set size to 0.1, if you're going to draw a 128x128 texture, set size to 0.05, if you're going to draw a 256x256 texture, set size to 0.025 and so on.
Regardless, you should still pick the size you think looks best.

The third variable is going to be a string, this variable is called dist. This variable is going to tell the difference between his aiming position and the reticle that you can set on a SWEP. 
So if you set it to "MyAttachmentDist", then in the SWEP's lua file you'll have to set SWEP.MyAttachmentDist to a number.
This is primarily used for render target scopes when the texture clips with the model, making it invisible/partially visible.

The fourth variable is going to be a number, this variable is called distno.
This variable will be used the same way as the variable 'dist', but it'll be used when the weapon's 'dist' variable is not defined.

The fifth variable is going to be a string, this variable is called pos. This variable is needed if the attachment you're going to add has back-up sights.
The variable should be named after the aiming position.
This prevents the code from drawing the aiming reticle when you're using the sight's back-up sights.

The sixth variable is going to be a boolean, this boolean is called aimmove. If you set it to true, then the aiming reticle will move along with the weapon when you take aim and move your mouse around.

The seventh variable is going to be how much we're going to zoom in when taking aim, this variable is called fovmod.
Usually for reflex sights I use 15.

(OPTIONAL) The eighth variable is going to be the rendering function, and it should be called renderfunc. This can be used if you're going to make a render target based scope. (in other words, a scope that magnifies)
== == == == == == == == == == == ==

The sixth argument (incompability) should be a table. This table has to contain the attachments it's not compatible with, AKA attachments it should hide when attaching this attachment.
The seventh argument (description) should be a table. This table will contain the attachment's description when opening the customization menu and attaching it to a weapon.
The eighth argument (attfunc) is going to be a function. This function will be called when you attach the attachment to a weapon. So if you need to modify the weapon's stats - use this function.
The ninth argument (deattfunc) is going to be a function. This function will be called when you detach the attachmen from a weapon. So if you need to revert a weapon's stats to what it was - use this function.
The tenth argument (modelattfunc) is going to be a function. This function will be called on the CLIENT when you attach the attachment. 
This function will tell the client what to do with other models when attaching the attachment. You can also use this function to update certain variables without having to network additional stuff.
The argument you're going to provide it with is the weapon entity.
]]--

AutoAtt, AutoPart = {}, {}

function CSTM_AddAttachment(tbl) //name, num, scope, incompability, description, svattfunc, svdeattfunc, clattfunc, cldeattfunc)
	CWAttachments[tbl.key] = {key = tbl.key, name = tbl.name, num = tbl.num, displaytexture = tbl.displaytexture, scope = tbl.scope, incompability = tbl.incompability, description = tbl.description, canattach = tbl.canattach, svattfunc = tbl.svattfunc, svdeattfunc = tbl.svdeattfunc, clattfunc = tbl.clattfunc, cldeattfunc = tbl.cldeattfunc}
	CWAttachmentsMeta[tbl.num] = tbl.key
	
	if SERVER then
		CreateConVar("cstm_att_" .. tbl.key, "0",  {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
		AutoAtt["cstm_att_" .. tbl.key] = tbl.key
	else
		CreateClientConVar("cstm_att_" .. tbl.key .. "_cl", "0", true, true)
	end
end

----
-- WEAPON ATTACHMENTS
----

local NA = {}

NA.key = "reflex"
NA.name = "Docter"
NA.num = 1

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_reflexsight")
end

NA.scope = {mat = Material("sprites/aim_reticule"), size = 0.04, dist = "DocterDist", distno = 15, aimmove = true, fovmod = 5}
NA.incompability = {"acog", "aimpoint", "eotech", "riflereflex", "kobra", "ballistic", "elcan"}
NA.description = {[1] = {t = "Provides a bright red reticle to enhance aiming.", c = Color(150, 255, 150, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.ReflexPos
	wep.AimAng = wep.ReflexAng
	wep.HasInstalledScope = true
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 255
	end
			
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 255
		end
	end
			
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 1)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 1)
	end
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA.key = "kobra"
NA.name = "Kobra"
NA.num = 2

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_kobra")
end

NA.scope = {mat = Material("sprites/kobra_sight"), size = 0.3, dist = "KobraDist", distno = 15, aimmove = true, fovmod = 18}
NA.incompability = {"acog", "eotech", "reflex", "aimpoint", "riflereflex", "ballistic"}
NA.description = {[1] = {t = "Provides a bright red three-part reticle to enhance aiming.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Slightly increases aim zoom.", c = Color(150, 255, 150, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.KobraPos
	wep.AimAng = wep.KobraAng
	wep.HasInstalledScope = true
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 255
	end
			
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 255
		end
	end
			
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 1)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 1)
	end
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "riflereflex"
NA.name = "Reflex sight"
NA.num = 3

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_riflereflex")
end

NA.scope = {mat = Material("sprites/aim_reticule"), size = 0.04, dist = "RReflexDist", distno = 15, aimmove = true, fovmod = 18}
NA.incompability = {"acog", "eotech", "reflex", "aimpoint", "kobra", "ballistic", "elcan"}
NA.description = {[1] = {t = "Provides a bright red reticle to enhance aiming.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Slightly increases aim zoom.", c = Color(150, 255, 150, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.RReflexPos
	wep.AimAng = wep.RReflexAng
	wep.HasInstalledScope = true
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 255
	end
			
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 255
		end
	end
			
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 1)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 1)
	end
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "eotech"
NA.name = "EoTech 557"
NA.num = 4

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_eotech557")
end

NA.scope = {mat = Material("sprites/eotech_reddot"), size = 0.375, dist = "EoTechDist", distno = 15, aimmove = true, fovmod = 18}
NA.incompability = {"acog", "aimpoint", "reflex", "riflereflex", "kobra", "ballistic", "elcan"}
NA.description = {[1] = {t = "Provides a bright red sphere-like reticle to enhance aiming.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Slightly increases aim zoom.", c = Color(150, 255, 150, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.ReflexPos
	wep.AimAng = wep.ReflexAng
	wep.HasInstalledScope = true
	
	if wep.NoRail != true and wep.EoTechWithRail != true then
		wep.VElements["rail"].color.a = 0
				
		if wep.WElements and wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	elseif wep.EoTechWithRail then
		if wep.VElements["rail"] then
			wep.VElements["rail"].color.a = 255
		end
				
		if wep.WElements then
			if wep.WElements and wep.WElements["rail"] then
				wep.WElements["rail"].color.a = 255
			end
		end
	end
			
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 1)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 1)
	end
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "aimpoint"
NA.name = "Aimpoint"
NA.num = 5

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_aimpoint")
end

NA.scope = {mat = Material("sprites/aim_reticule"), size = 0.04, dist = "AimpointDist", distno = 15, aimmove = true, fovmod = 21}
NA.incompability = {"acog", "eotech", "reflex", "riflereflex", "kobra", "ballistic", "elcan"}
NA.description = {[1] = {t = "Provides a bright red reticle to enhance aiming.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Moderately increases aim zoom.", c = Color(150, 255, 150, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.ScopePos
	wep.AimAng = wep.ScopeAng
	wep.HasInstalledScope = true
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 255
	end
			
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 255
		end
	end
			
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 1)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 1)
	end
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "elcan"
NA.name = "ELCAN C79"
NA.num = 6

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_elcan")
end

NA.scope = {mat = Material("sprites/elcan_reticle"), size = 1, dist = "ELCANDist", distno = 4, pos = "ELCANPos", fovmod = 21, renderfunc = function(wep)
	ply = LocalPlayer()
	FT = FrameTime()
	
	if wep:GetDTInt(3) != 1 or not wep.DrawTable then
		BlackAmt = math.Approach(BlackAmt, 1, FT * 6)
	else
		BlackAmt = math.Approach(BlackAmt, 0, FT * 6)
	end
	
	x, y = ScrW(), ScrH()
	old = render.GetRenderTarget()
	
	CamData.angles = ply:EyeAngles() + ply:GetPunchAngle()
	CamData.origin = ply:GetShootPos()
	CamData.x = 0
	CamData.y = 0
	CamData.w = 256
	CamData.h = 256
	CamData.fov = 6.5
	CamData.drawviewmodel = false
	CamData.drawhud = false
	render.SetRenderTarget(wep.AcogRT)
	render.SetViewPort(0, 0, 256, 256)
	
	if not Ini then
		render.RenderView(CamData)
		
		cam.Start2D()
			surface.SetDrawColor(150, 150, 150, 245 * BlackAmt)
			surface.SetTexture(Lens)
			surface.DrawTexturedRect(0, 0, 256, 256)
		cam.End2D()
	end
	
	render.SetViewPort(0, 0, x, y)
	render.SetRenderTarget(old)
	Ini = false
	
	if wep.AcogGlass then
		wep.AcogGlass:SetTexture("$basetexture", wep.AcogRT)
	end
end}
NA.incompability = {"acog", "aimpoint", "eotech", "reflex", "riflereflex", "kobra", "ballistic"}
NA.description = {[1] = {t = "Provides 3.4x magnification.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Has back up sights that can be used by double tapping your USE KEY while aiming.", c = Color(150, 255, 150, 255)},
	[3] = {t = "Can be disorienting when engaging targets at close range.", c = Color(255, 110, 96, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.ELCANPos
	wep.AimAng = wep.ELCANAng
	wep.HasInstalledScope = true
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 255
	end
			
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 255
		end
	end
			
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 1)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 1)
	end
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "acog"
NA.name = "ACOG 4x"
NA.num = 7

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_acog")
end

NA.scope = {mat = Material("sprites/acog_tri"), size = 0.2, dist = "ACOGDist", pos = "ACOGPos", fovmod = 21, renderfunc = function(wep)
	ply = LocalPlayer()
	FT = FrameTime()
	
	if wep:GetDTInt(3) != 1 or not wep.DrawTable then
		BlackAmt = math.Approach(BlackAmt, 1, FT * 6)
	else
		BlackAmt = math.Approach(BlackAmt, 0, FT * 6)
	end
	
	x, y = ScrW(), ScrH()
	old = render.GetRenderTarget()
	
	CamData.angles = ply:EyeAngles() + ply:GetPunchAngle()
	CamData.origin = ply:GetShootPos()
	CamData.x = 0
	CamData.y = 0
	CamData.w = 256
	CamData.h = 256
	CamData.fov = 4
	CamData.drawviewmodel = false
	CamData.drawhud = false
	render.SetRenderTarget(wep.AcogRT)
	render.SetViewPort(0, 0, 256, 256)
	
	if not Ini then
		render.RenderView(CamData)
		
		cam.Start2D()
			surface.SetDrawColor(150, 150, 150, 245 * BlackAmt)
			surface.SetTexture(Lens)
			surface.DrawTexturedRect(0, 0, 256, 256)
		cam.End2D()
	end
	
	render.SetViewPort(0, 0, x, y)
	render.SetRenderTarget(old)
	Ini = false
	
	if wep.AcogGlass then
		wep.AcogGlass:SetTexture("$basetexture", wep.AcogRT)
	end
end}

NA.incompability =  {"aimpoint", "eotech", "reflex", "riflereflex", "kobra", "ballistic", "elcan"}
NA.description = {[1] = {t = "Provides 4x magnification.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Provides a chevron upside-down 'V' reticle to enhance aiming.", c = Color(150, 255, 150, 255)},
	[3] = {t = "Has back up sights that can be used by double tapping your USE KEY while aiming.", c = Color(150, 255, 150, 255)},
	[4] = {t = "Can be disorienting when engaging targets at close range.", c = Color(255, 110, 96, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.ACOGPos
	wep.AimAng = wep.ACOGAng
	wep.HasInstalledScope = true
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 255
	end
			
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 255
		end
	end
			
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 1)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 1)
	end
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "ballistic"
NA.name = "Ballistic 12x"
NA.num = 8

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_ballistic")
end

NA.scope = {mat = Material("gcellmats/scope_rifle"), size = 4, dist = "BallisticDist", fovmod = 21, renderfunc = function(wep)
	ply = LocalPlayer()
	FT = FrameTime()
	
	if wep:GetDTInt(3) != 1 or not wep.DrawTable then
		BlackAmt = math.Approach(BlackAmt, 1, FT * 6)
	else
		BlackAmt = math.Approach(BlackAmt, 0, FT * 6)
	end
	
	x, y = ScrW(), ScrH()
	old = render.GetRenderTarget()
	wep.CurFOV = math.Approach(wep.CurFOV, wep.TargetFOV, FT * 10)
	
	CamData.angles = ply:EyeAngles() + ply:GetPunchAngle()
	CamData.origin = ply:GetShootPos()
	CamData.x = 0
	CamData.y = 0
	CamData.w = 256
	CamData.h = 256
	CamData.fov = wep.CurFOV
	CamData.drawviewmodel = false
	CamData.drawhud = false
	render.SetRenderTarget(wep.AcogRT)
	render.SetViewPort(0, 0, 256, 256)
	
	if not Ini then
		render.RenderView(CamData)
		
		cam.Start2D()
			surface.SetDrawColor(150, 150, 150, 245 * BlackAmt)
			surface.SetTexture(Lens)
			surface.DrawTexturedRect(0, 0, 256, 256)
		cam.End2D()
	end
	
	render.SetViewPort(0, 0, x, y)
	render.SetRenderTarget(old)
	Ini = false
	
	if wep.AcogGlass then
		wep.AcogGlass:SetTexture("$basetexture", wep.AcogRT)
	end
end}

NA.incompability =  {"aimpoint", "acog", "eotech", "reflex", "riflereflex", "kobra", "elcan"}
NA.description = {[1] = {t = "Greatly increases aim zoom.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Magnification levels can be adjusted with the mouse wheel.", c = Color(150, 255, 150, 255)},
	[3] = {t = "Is very disorienting when engaging targets at close range.", c = Color(255, 110, 96, 255)}}
	
NA.clattfunc = function(wep)
	wep.AimPos = wep.BallisticPos
	wep.AimAng = wep.BallisticAng
	wep.HasInstalledScope = true
end

NA.cldeattfunc = function(wep)
	wep.AimPos = wep.AimPos_Orig
	wep.AimAng = wep.AimAng_Orig
	wep.HasInstalledScope = false
	
	if wep.VElements["rail"] then
		wep.VElements["rail"].color.a = 0
	end
				
	if wep.WElements then
		if wep.WElements["rail"] then
			wep.WElements["rail"].color.a = 0
		end
	end
	
	if wep.VElements["front"] and wep.VElements["rear"] then
		wep.VElements["front"].modelEnt:SetBodygroup(1, 0)
		wep.VElements["rear"].modelEnt:SetBodygroup(1, 0)
	end
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "vertgrip"
NA.name = "Foregrip"
NA.num = 9
NA.scope = nil

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_vertgrip")
end

NA.incompability =  {"grenadelauncher", "bipod"}
NA.description = {[1] = {t = "Decreases maximum spread from continuous fire by 50%", c = Color(150, 255, 150, 255)},
	[2] = {t = "Decreases spread increase from movement by 35%", c = Color(150, 255, 150, 255)},
	[3] = {t = "Decreases recoil by 20%", c = Color(150, 255, 150, 255)}}
	
NA.svattfunc = function(wep)
	if not wep.InstalledGrip then
		wep.RecoilMods.vertgrip = 0.8
		wep.VelocitySensivity = wep.VelocitySensivity * 0.65
		wep.InstalledGrip = true
		wep.OtherMods.vertgrip = {mod = "ConeInaccuracyAff1", value = 0.5}
		//wep.ConeInaccuracyAff1 = wep.ConeInaccuracyAff1 * 0.5
	end
end

NA.svdeattfunc = function(wep)
	wep.VelocitySensivity = wep.VelocitySensivity / 0.65
	wep.RecoilMods.vertgrip = 1
	wep.InstalledGrip = false
	//wep.ConeInaccuracyAff1 = wep.ConeInaccuracyAff1 / 0.5
	wep.OtherMods.vertgrip = {mod = "ConeInaccuracyAff1", value = 1}
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "grenadelauncher"
NA.name = "M203"
NA.num = 10
NA.scope = nil

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_m203")
end

NA.incompability = {"vertgrip", "bipod"}
NA.description = {[1] = {t = "Allows the use of an underslung grenade launcher.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Cannot aim down sights while M203 mode is enabled.", c = Color(255, 110, 96, 255)},
	[3] = {t = "To use - hold USE KEY, press SECONDARY ATTACK KEY and then take aim.", c = Color(255, 255, 255, 255)},
	[4] = {t = "To switch back to rifle mode - hold USE KEY, press SECONDARY ATTACK KEY.", c = Color(255, 255, 255, 255)}}
	
NA.svattfunc = function(wep)
	SendUserMessage("M203_OFF", wep.Owner)
	wep.SecondaryAtt = 1
end

NA.svdeattfunc = function(wep)
	SendUserMessage("M203_OFF", wep.Owner)
	wep.Grenade = false
	wep.SecondaryAtt = 0
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "bipod"
NA.name = "Bipod"
NA.num = 11
NA.scope = nil

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_bipod")
end

NA.incompability = {"vertgrip", "grenadelauncher"}
NA.description = {[1] = {t = "When deployed:", c = Color(255, 255, 255, 255)},
	[2] = {t = "Decreases recoil by 70% when firing while aiming.", c = Color(150, 255, 150, 255)},
	[3] = {t = "Decreases recoil by 60% when hip-firing.", c = Color(150, 255, 150, 255)},
	[4] = {t = "Increases hip-fire accuracy greatly.", c = Color(150, 255, 150, 255)},
	[5] = {t = "Decreases mouse sensitivity by 25%", c = Color(255, 110, 96, 255)}}
	
NA.svattfunc = function(wep)
	wep.InstalledBipod = true
end

NA.svdeattfunc = function(wep)
	wep.InstalledBipod = false
	wep:SetDTBool(1, false)
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "cmag"
NA.name = "C-Mag"
NA.num = 12
NA.scope = nil

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_cmag")
end

NA.description = {[1] = {t = "Increases magazine size to 100 rounds.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Decreases reload speed by 20%", c = Color(255, 110, 96, 255)}}
	
NA.svattfunc = function(wep)
	clip = wep:Clip1()
	ammo = wep.Owner:GetAmmoCount(wep.Primary.Ammo)
				
	wep:SetClip1(0)
	wep.Owner:SetAmmo(ammo + clip, wep:GetPrimaryAmmoType())
	wep.Primary.ClipSize = 100
	wep.ReloadSpeed = wep.ReloadSpeed * 0.8
	wep.CMagInstalled = true
			
	umsg.Start("NWSPD")
		umsg.Entity(wep)
		umsg.Float(0.8)
	umsg.End()
end

NA.svdeattfunc = function(wep)
	clip = wep:Clip1()
	ammo = wep.Owner:GetAmmoCount(wep.Primary.Ammo)
				
	wep:SetClip1(0)
	wep.Owner:SetAmmo(ammo + clip, wep:GetPrimaryAmmoType())
	wep.Primary.ClipSize = wep.Primary.ClipSize_Orig
	wep.ReloadSpeed = wep.ReloadSpeed / 0.8
	wep.CMagInstalled = false
			
	umsg.Start("NWSPD")
		umsg.Entity(wep)
		umsg.Float(1)
	umsg.End()
end

NA.clattfunc = function(wep)
	wep.Primary.ClipSize = 100
end

NA.cldeattfunc = function(wep)
	wep.Primary.ClipSize = wep.Primary.ClipSize_Orig
end

CSTM_AddAttachment(NA)

NA = {}

NA.key = "laser"
NA.name = "Laser sight"
NA.num = 13
NA.scope = nil

if CLIENT then
	NA.displaytexture = surface.GetTextureID("VGUI/entities/upgr_lasersight")
end

NA.description = {[1] = {t = "Decreases hip-fire spread by 60%", c = Color(150, 255, 150, 255)},
	[2] = {t = "Decreases spread increase from movement by 30%", c = Color(150, 255, 150, 255)},
	[3] = {t = "Decreases spread increase speed from continuous fire by 15%", c = Color(150, 255, 150, 255)}}
	
NA.svattfunc = function(wep)
	wep.VelocitySensivity = wep.VelocitySensivity * 0.7
	wep.InaccAff1 = wep.InaccAff1 * 0.85
	wep.InstalledLaser = true
end

NA.svdeattfunc = function(wep)
	wep.VelocitySensivity = wep.VelocitySensivity / 0.7
	wep.InaccAff1 = wep.InaccAff1 / 0.85
	wep.InstalledLaser = false
end

CSTM_AddAttachment(NA) 

function CSTM_AddInternalPartMod(tbl)
	CWInternalParts[tbl.key] = {key = tbl.key, name = tbl.name, num = tbl.num, description = tbl.description, displaytexture = tbl.displaytexture, svattfunc = tbl.svattfunc, svdeattfunc = tbl.svdeattfunc}
	CWInternalPartsMeta[tbl.num] = tbl.key
	
	if SERVER then
		CreateConVar("cstm_part_" .. tbl.key, "0",  {FCVAR_REPLICATED, FCVAR_ARCHIVE, FCVAR_NOTIFY})
		AutoPart["cstm_part_" .. tbl.key] = tbl.key
	else
		CreateClientConVar("cstm_part_" .. tbl.key .. "_cl", "0", true, true)
	end
end

----
-- INTERNAL WEAPON PARTS
----

local NIP = {}

NIP.key = "hbar"
NIP.name = "Heavy barrel"
NIP.num = 1
NIP.description = {[1] = {t = "Increases damage by 10%", c = Color(150, 255, 150, 255)},
	[2] = {t = "Slightly increases aimed accuracy.", c = Color(150, 255, 150, 255)},
	[3] = {t = "Increases recoil by 15%", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_hbar")
end

NIP.svattfunc = function(wep)
	wep.DamageMods.hbar = 1.1
	wep.RecoilMods.hbar = 1.15
	wep.AimConeMods.hbar = 0.95
end

NIP.svdeattfunc = function(wep)
	wep.DamageMods.hbar = 1
	wep.RecoilMods.hbar = 1
	wep.AimConeMods.hbar = 1
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "lbar"
NIP.name = "Light barrel"
NIP.num = 2
NIP.description = {[1] = {t = "Decreases recoil by 15%", c = Color(150, 255, 150, 255)},
	[2] = {t = "Decreases damage by 10%", c = Color(255, 110, 96, 255)},
	[3] = {t = "Slightly decreases aimed accuracy.", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_lbar")
end

NIP.svattfunc = function(wep)
	wep.DamageMods.lbar = 0.9
	wep.RecoilMods.lbar = 0.85
	wep.AimConeMods.lbar = 1.1
end

NIP.svdeattfunc = function(wep)
	wep.DamageMods.lbar = 1
	wep.RecoilMods.lbar = 1
	wep.AimConeMods.lbar = 1
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "hframe"
NIP.name = "Heavy frame"
NIP.num = 3
NIP.description = {[1] = {t = "Decreases recoil by 10%", c = Color(150, 255, 150, 255)},
	[2] = {t = "Decreases mouse sensitivity by 20%", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_hframe")
end

NIP.svattfunc = function(wep)
	wep.RecoilMods.hframe = 0.9
	
	umsg.Start("MOUSESENS", wep.Owner)
		umsg.Float(0.8)
	umsg.End()
end

NIP.svdeattfunc = function(wep)
	wep.RecoilMods.hframe = 1
	
	umsg.Start("MOUSESENS", wep.Owner)
		umsg.Float(1)
	umsg.End()
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "burstconvert"
NIP.num = 4
NIP.name = "Burst-fire conversion"
NIP.description = {[1] = {t = "Converts the weapon to fire in 3-round bursts.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Increases rate of fire by 40%", c = Color(150, 255, 150, 255)},
	[3] = {t = "Semi-automatic not usable.", c = Color(255, 110, 96, 255)},
	[4] = {t = "Increases recoil by 15%", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_burstfire")
end

NIP.svattfunc = function(wep)
	wep.FirerateMods.burstconvert = 0.6
	wep.RecoilMods.burstconvert = 1.15
	wep.FireModes_old = wep.FireModes
	wep.FireModes = {"3burst", "safe"}
	wep.FireMode = "3burst"
	wep.OtherMods.burstconvert = {mod = "BurstAccMod", value = 2}
	wep.Primary.Automatic = true
	
	net.Start("SENDFIREMODES")
		net.WriteTable({"3burst", "safe"})
	net.Send(wep.Owner)
end

NIP.svdeattfunc = function(wep)
	wep.FirerateMods.burstconvert = 1
	wep.RecoilMods.burstconvert = 1
	wep.FireModes = wep.FireModes_old
	wep.FireMode = wep.FireModes[1]
	wep.OtherMods.burstconvert = {mod = "BurstAccMod", value = 1}
	wep.Primary.Automatic = wep.FireModeNames[wep.FireModes[1]].auto
	
	net.Start("SENDFIREMODES")
		net.WriteTable(wep.FireModes)
	net.Send(wep.Owner)
end

CSTM_AddInternalPartMod(NIP)
	
NIP = {}

NIP.key = "autoconvert"
NIP.num = 5
NIP.name = "Full-auto conversion"
NIP.description = {[1] = {t = "Converts the weapon to fire in full-auto.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Increases rate of fire by 20%", c = Color(150, 255, 150, 255)},
	[3] = {t = "Semi-automatic not usable.", c = Color(255, 110, 96, 255)},
	[4] = {t = "Increases recoil by 15%", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_fullauto")
end

NIP.svattfunc = function(wep)
	wep.FirerateMods.autoconvert = 0.8
	wep.RecoilMods.autoconvert = 1.15
	wep.FireModes_old = wep.FireModes
	wep.FireModes = {"auto", "safe"}
	wep.FireMode = "auto"
	wep.Primary.Automatic = true
	
	net.Start("SENDFIREMODES")
		net.WriteTable({"auto", "safe"})
	net.Send(wep.Owner)
end

NIP.svdeattfunc = function(wep)
	wep.FirerateMods.autoconvert = 1
	wep.RecoilMods.autoconvert = 1
	wep.FireModes = wep.FireModes_old
	wep.FireMode = wep.FireModes[1]
	wep.Primary.Automatic = wep.FireModeNames[wep.FireModes[1]].auto
	
	net.Start("SENDFIREMODES")
		net.WriteTable(wep.FireModes)
	net.Send(wep.Owner)
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "ergonomichandle"
NIP.num = 6
NIP.name = "Ergonomic grip"
NIP.description = {[1] = {t = "Decreases maximum spread from continuous fire by 15%", c = Color(150, 255, 150, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_ergonomichandle")
end

NIP.svattfunc = function(wep)
	wep.OtherMods.ergonomichandle = {mod = "ConeInaccuracyAff1", value = 0.85}
end

NIP.svdeattfunc = function(wep)
	wep.OtherMods.ergonomichandle = {mod = "ConeInaccuracyAff1", value = 1}
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "gasdir"
NIP.num = 7
NIP.name = "Forced gas direction"
NIP.description = {[1] = {t = "Increases damage by 10%.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Slightly increases aimed accuracy.", c = Color(150, 255, 150, 255)},
	[3] = {t = "Increases recoil by 15%.", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_gasdir")
end

NIP.svattfunc = function(wep)
	wep.DamageMods.gasdir = 1.1
	wep.AimConeMods.gasdir = 0.95
	wep.RecoilMods.gasdir = 1.15
end

NIP.svdeattfunc = function(wep)
	wep.DamageMods.gasdir = 1
	wep.AimConeMods.gasdir = 1
	wep.RecoilMods.gasdir = 1
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "customstock"
NIP.num = 8
NIP.name = "Custom-fit stock"
NIP.description = {[1] = {t = "Decreases maximum spread from continuous fire by 15%", c = Color(150, 255, 150, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_customstock")
end

NIP.svattfunc = function(wep)
	wep.OtherMods.customstock = {mod = "ConeInaccuracyAff1", value = 0.85}
end

NIP.svdeattfunc = function(wep)
	wep.OtherMods.customstock = {mod = "ConeInaccuracyAff1", value = 1}
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "lightbolt"
NIP.num = 9
NIP.name = "Light bolt"
NIP.description = {[1] = {t = "Decreases recoil by 10%", c = Color(150, 255, 150, 255)},
	[2] = {t = "Increases rate of fire by 5%", c = Color(150, 255, 150, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_lightbolt")
end

NIP.svattfunc = function(wep)
	wep.RecoilMods.lightbolt = 0.9
	wep.FirerateMods.lightbolt = 0.95
end

NIP.svdeattfunc = function(wep)
	wep.RecoilMods.lightbolt = 1
	wep.FirerateMods.lightbolt = 1
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "heavybolt"
NIP.num = 10
NIP.name = "Heavy bolt"
NIP.description = {[1] = {t = "Slightly increases aimed accuracy.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Decreases rate of fire by 10%.", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_heavybolt")
end

NIP.svattfunc = function(wep)
	wep.AimConeMods.heavybolt = 0.85
	wep.FirerateMods.heavybolt = 1.1
end

NIP.svdeattfunc = function(wep)
	wep.AimConeMods.heavybolt = 1
	wep.FirerateMods.heavybolt = 1
end

CSTM_AddInternalPartMod(NIP)

NIP = {}

NIP.key = "autoconvertv2"
NIP.num = 11
NIP.name = "Full-auto conversion"
NIP.description = {[1] = {t = "Converts the weapon to fire in full-auto.", c = Color(150, 255, 150, 255)},
	[2] = {t = "Semi-automatic not usable.", c = Color(255, 110, 96, 255)},
	[3] = {t = "Increases recoil by 15%", c = Color(255, 110, 96, 255)}}
	
if CLIENT then
	NIP.displaytexture = surface.GetTextureID("VGUI/entities/cstm_part_fullauto")
end

NIP.svattfunc = function(wep)
	wep.RecoilMods.autoconvert = 1.15
	wep.FireModes_old = wep.FireModes
	wep.FireModes = {"auto", "safe"}
	wep.FireMode = "auto"
	wep.Primary.Automatic = true
	
	net.Start("SENDFIREMODES")
		net.WriteTable({"auto", "safe"})
	net.Send(wep.Owner)
end

NIP.svdeattfunc = function(wep)
	wep.RecoilMods.autoconvert = 1
	wep.FireModes = wep.FireModes_old
	wep.FireMode = wep.FireModes[1]
	wep.Primary.Automatic = wep.FireModeNames[wep.FireModes[1]].auto
	
	net.Start("SENDFIREMODES")
		net.WriteTable(wep.FireModes)
	net.Send(wep.Owner)
end

CSTM_AddInternalPartMod(NIP)

----
-- AMMO TYPES
----
	
AmmoTypes = {
	["incendiary"] = {name = "Incendiary", num = 1, penmod = 0.75, func = function(ply, wep)
		wep.DamageMods.incendiary = 0.7
		wep.LastDamageMods.Ammo = "incendiary"
	end},
		
	["ap"] = {name = "Armor Piercing", num = 2, penmod = 1.15},
	["hp"] = {name = "Hollow Point", num = 3, penmod = 0.85},
	
	["magnum"] = {name = "Magnum", num = 4, penmod = 1.1, selfunc = function(ply, wep)
		wep.DamageMods.magnum = 1.2
		
		wep.RecoilMods.magnum = 1.25
	end,
	
	deselfunc = function(ply, wep)
		wep.DamageMods.magnum = 1
		wep.RecoilMods.magnum = 1
	end},
	
	["slug"] = {name = "Slug", num = 6, penmod = 5, selfunc = function(ply, wep)
		wep.PrevStats = {shot = wep.Primary.NumShots, velsens = wep.VelocitySensivity, clumpspread = wep.ClumpSpread, damdec = wep.DamageDecayMod}
		
		wep.DamageMods.slug = 10
		wep.AimConeMods.slug = 0.05
		
		wep.Primary.NumShots = 1
		wep.ClumpSpread = 0
		wep.VelocitySensivity = 1.6
		wep.DamageDecayMod = 1
		wep:CalculateDamageDecay()
			
		umsg.Start("NBUL", ply)
			umsg.Short(1)
		umsg.End()
	end,
	
	deselfunc = function(ply, wep)
		wep.DamageMods.slug = 1
		wep.AimConeMods.slug = 1
	end},
	
	["birdshot"] = {name = "Birdshot", num = 7, penmod = 0.5, selfunc = function(ply, wep)
		wep.PrevStats = {shot = wep.Primary.NumShots, velsens = wep.VelocitySensivity, clumpspread = 0, damdec = wep.DamageDecayMod}
		
		wep.DamageMods.birdshot = 0.07692
		wep.RecoilMods.birdshot = 0.5
		wep.HipConeMods.birdshot = 0.6
		
		wep.Primary.NumShots = 20
		wep.ClumpSpread = wep.IronsightsCone
		wep.VelocitySensivity = 0.2
		wep.DamageDecayMod = 2.5
		wep:CalculateDamageDecay()
		
		umsg.Start("NBUL", ply)
			umsg.Short(20)
		umsg.End()
	end,
	
	deselfunc = function(ply, wep)
		wep.DamageMods.birdshot = 1
		wep.RecoilMods.birdshot = 1
		wep.HipConeMods.birdshot = 1
	end},
	
	["frag"] = {name = "Frag", num = 10, penmod = 1},
	["smoke"] = {name = "Smoke", num = 11, penmod = 1}}
	
local mag, wep

function TWeps_LowAmmo(w, p)
	if tonumber(p:GetInfo("cstm_lowammo")) <= 0 then
		return
	end
	
	mag = w:Clip1()
	
	if mag < w.Primary.ClipSize * 0.33 then
		w:EmitSound("weapons/ClipEmpty_Rifle.wav", 100 - (mag * 4), 100)
	end
end

function TWeps_Move(p, m)
	if p:Alive() then
		wep = p:GetActiveWeapon()
		
		if IsValid(wep) then
			if wep.IsCSTMWeapon then
				if not p:KeyDown(IN_SPEED) then
					if wep:GetDTInt(3) == 1 then
						if p:Crouching() then
							m:SetMaxSpeed(p:GetWalkSpeed() * p:GetCrouchedWalkSpeed())
						else
							m:SetMaxSpeed(p:GetWalkSpeed() * 0.7)
						end
					end
				end
			end
		end
	end
end

hook.Add("Move", "TWeps_Move", TWeps_Move)

Calibers = {}

function AddAmmoType(name, text)
	game.AddAmmoType({name = name,
	dmgtype = DMG_BULLET,
	force = 10,
	maxsplash = 0,
	minsplash = 0,
	npcdmg = 18,
	plydmg = 18,
	tracer = 3})
	
	if CLIENT then
		language.Add(name .. "_ammo", text)
	end
	
	table.insert(Calibers, {ammo = name, name = text})
end

AddAmmoType("9x18MM", "9x18MM Ammo")
AddAmmoType("9x19MM 7N21", "9x19MM 7N21 Ammo")
AddAmmoType("9x19MM", "9x19MM Ammo")
AddAmmoType("7.65x17MM", "7.65x17MM Ammo")
AddAmmoType("4.6x30MM", "4.6x30MM Ammo")
AddAmmoType("5.7x28MM", "5.7x28MM Ammo")
AddAmmoType("5.45x39MM", "5.45x39MM Ammo")
AddAmmoType("9x39MM", "9x39MM Ammo")
AddAmmoType("5.56x45MM", "5.56x45MM Ammo")
AddAmmoType("6x35MM", "6x35MM Ammo")
AddAmmoType("7.62x39MM", "7.62x39MM Ammo")
AddAmmoType("7.62x51MM", "7.62x51MM Ammo")
AddAmmoType("7.62x54MMR", "7.62x54MMR Ammo")
AddAmmoType("7.92x57MM", "7.92x57MM Ammo")
AddAmmoType(".45ACP", ".45 ACP Ammo")
AddAmmoType(".50AE", ".50 AE Ammo")
AddAmmoType(".30-30", ".30-30 Ammo")
AddAmmoType(".338", ".338 Ammo")
AddAmmoType(".50BMG", ".50 BMG Ammo")
AddAmmoType("12G", "12 Gauge Ammo")
AddAmmoType("6G", "6 Gauge Ammo")
AddAmmoType(".357", ".357 Magnum Ammo")
AddAmmoType(".44", ".44 Magnum Ammo")
AddAmmoType("40MM_HE", "40MM High Explosive")
AddAmmoType("40MM_CE", "40MM Centered Explosion")
AddAmmoType("40MM_Smoke", "40MM Smoke")