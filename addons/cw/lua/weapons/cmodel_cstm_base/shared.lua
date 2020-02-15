if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
    SWEP.AcogGlass = Material("models/wystan/attachments/acog/lense")
    SWEP.AcogRT = GetRenderTarget( "acog_glass_rt", 256, 256, false )
    SWEP.AcogGlass:SetTexture("$basetexture", SWEP.AcogRT)
	SWEP.Dist = 0
	SWEP.Strength = 0 
end

function SWEP:Initialize()
    if CLIENT then
        // Create a new table for every weapon instance
        self.VElements = table.FullCopy( self.VElements )
        self.WElements = table.FullCopy( self.WElements )
        self.ViewModelBoneMods = table.FullCopy( self.ViewModelBoneMods )
 
        self:CreateModels(self.VElements) // create viewmodels
        self:CreateModels(self.WElements) // create worldmodels
    end
end
 
 
/*function SWEP:OnRemove()
     
    // other onremove code goes here
     
    if CLIENT then
        self:RemoveModels()
    end
     
end*/
 
if CLIENT then
	local vm, v, model, sprite, pos, ang, drawpos, lt, fw, aim, dir, trace, ply, old, ang, ang2, CamData, m, name, params, tocheck, dist, entry, dir, mdl, mat, size, dt3, dist, scale, EA, delta, FT, mtr, wep, x, y, y2, activity
	local Dot = Material("sprites/aim_reticule")
	local Kobra = Material("sprites/kobra_sight")
	local Ret = Material("sprites/eotech_reddot")
	local Tri = Material("sprites/acog_tri")
	local Scope = Material("gcellmats/scope_rifle")
	local Elcan = Material("sprites/elcan_reticle")
	
	local Laser = Material("effects/laser_cstm")
	local LaserDot = Material("effects/brightglow_y")
	local blur = Material("pp/bokehblur")
	
	local White = Color(255, 255, 255, 255)
	local vec = Vector(0, 0, 0)
	local YOff = Vector(1, 1, 0.5)
	local x, y, n, f
	
    SWEP.vRenderOrder = nil
	local r, u, f
	local td = {}
	
	local rdrawsprite = render.DrawSprite
	local ps2 = render.SupportsPixelShaders_2_0()
	
	function SWEP:PreDrawViewModel(vm, wep)
		if self:GetDTInt(3) == 1 then
			if GetConVarNumber("cstm_ef_blur_depth") > 0 then
				if ps2 then
					render.UpdateScreenEffectTexture()

					pos = self.Owner:GetShootPos()
					trace = util.QuickTrace(pos, self.Owner:GetAimVector() * 4096, self.Owner)
					self.Dist = math.Approach(self.Dist, trace.HitPos:Distance(pos) / 4096, 0.075)
					self.Strength = math.Approach(self.Strength, 5, 0.4)
					blur:SetTexture("$BASETEXTURE", render.GetScreenEffectTexture())
					blur:SetTexture("$DEPTHTEXTURE", render.GetResolvedFullFrameDepth())

					blur:SetFloat("$size", self.Strength)
					blur:SetFloat("$focus", self.Dist)
					blur:SetFloat("$focusradius", 2)

					render.SetMaterial(blur)
					render.DrawScreenQuad()
				end
			else
				DOFModeHack(false)
			end
	
			render.ClearStencil()
			render.SetStencilEnable(true)
				
			render.SetStencilFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilZFailOperation(STENCILOPERATION_KEEP)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_ALWAYS)
			render.SetStencilReferenceValue(1)
		else
			self.Strength = 0
		end
		
		cam.IgnoreZ(true)
	end
	
	local _Material			= Material("pp/toytown-top")
	_Material:SetTexture("$fbtexture", render.GetScreenEffectTexture())

	function SWEP:PostDrawViewModel(vm, wep)
		if self:GetDTInt(3) == 1 then
			render.SetStencilReferenceValue(2)
			render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
			render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
			render.SetStencilReferenceValue(1)
			
			if GetConVarNumber("cstm_ef_blur_viewmodel") > 0 then
				if ps2 then
					x, y = ScrW(), ScrH()
					y2 = y * 0.56
					
					cam.Start2D()
						surface.SetMaterial(_Material)
						surface.SetDrawColor(255, 255, 255, 255)
						
						for i=1, 10 do
							render.UpdateScreenEffectTexture()
							surface.DrawTexturedRectRotated(x * 0.5, y - y2 * 0.5 + 1, x, y2, 180)
						end
					
					cam.End2D()
				end
			end
			
			if self.DrawTable then
				render.SetMaterial(self.DrawTable.mat)
				render.DrawSprite(EyePos() + self.DrawTable.dir * self.DrawTable.dist,  self.DrawTable.size * (self.ReticleSizeMod and self.ReticleSizeMod or 1),  self.DrawTable.size * (self.ReticleSizeMod and self.ReticleSizeMod or 1), Color(255, 255, 255, 255))
			end
		end
		
		render.SetStencilEnable(false)
		cam.IgnoreZ(false)
	end
	
	hook.Add("NeedsDepthPass", "CSTM_NeedsDepthPass", function()
		if not ps2 then
			return false
		end
		
		ply = LocalPlayer()
		
		if ply:Alive() then
			wep = ply:GetActiveWeapon()
			
			if IsValid(wep) and wep.IsCSTMWeapon then
				if GetConVarNumber("cstm_ef_blur_depth") > 0 then
					if wep:GetDTInt(3) == 1 then
						DOFModeHack(true)
						return true
					end
				end
			end
		end
		
		return false
	end)
	
    function SWEP:ViewModelDrawn()
        vm = self.Owner:GetViewModel()
        if !IsValid(vm) then return end
         
        if (!self.VElements) then return end
         
        if vm.BuildBonePositions ~= self.BuildViewModelBones then
            vm.BuildBonePositions = self.BuildViewModelBones
        end
 
        if (self.ShowViewModel == nil or self.ShowViewModel) then
            vm:SetColor(Color(255,255,255,255))
        else
            // we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
            vm:SetColor(Color(255,255,255,1))
        end
		
		if self.OldDelta then
			FT = FrameTime()
			EA = self.Owner:EyeAngles()
			delta = Angle(EA.p, EA.y, 0) - self.OldDelta
				
			self.OldDelta = Angle(EA.p, EA.y, 0)
			self.AngleDelta = LerpAngle(math.Clamp(FT * 15, 0, 1), self.AngleDelta, delta)
			self.AngleDelta.y = math.Clamp(self.AngleDelta.y, -15, 15)
		end
         
        if (!self.vRenderOrder) then
            // we build a render order because sprites need to be drawn after models
            self.vRenderOrder = {}
 
            for k, v in pairs( self.VElements ) do
                if (v.type == "Model") then
                    table.insert(self.vRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.vRenderOrder, k)
                end
            end
             
        end
		
		aim = self.Owner:EyeAngles()
		dt3 = self:GetDTInt(3)
		self.DrawTable = nil
 
        for k, name in ipairs(self.vRenderOrder) do
			v = self.VElements[name]
			
			if !v then self.vRenderOrder = nil break end
			
			if v.color.a == 255 then	
				model = v.modelEnt
				sprite = v.spriteMaterial
				 
				if !v.bone then continue end
				 
				pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
				 
				if !pos then continue end
				 
				if v.type == "Model" and IsValid(model) then
					model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)
	 
					model:SetAngles(ang)
					
					mtr = Matrix()
					mtr:Scale(v.size)
					model:EnableMatrix("RenderMultiply", mtr)
					
					if v.material == "" then
						model:SetMaterial("")
					elseif model:GetMaterial() != v.material then
						model:SetMaterial(v.material)
					end
					 
					if v.skin and v.skin != model:GetSkin() then
						model:SetSkin(v.skin)
					end
					 
					if v.bodygroup then
						for k, v in pairs(v.bodygroup) do
							if model:GetBodygroup(k) != v then
								model:SetBodygroup(k, v)
							end
						end
					end
					 
					if v.surpresslightning then
						render.SuppressEngineLighting(true)
					end
					
					mdl = model:GetModel()
					n = CWAttachments[name]
					
					if n then
						n = CWAttachments[name].scope
					end
					
					if n and n.dist then
						f = false
						
						if n.pos then
							if self.AimPos != self[n.pos] then
								f = true
							end
						end
						
						if not f and dt3 == 1 then
							if self[n.dist] then
								dist = self[n.dist] * (dt3 == 1 and 1 or 2)
							elseif n.distno then
								dist = n.distno * (dt3 == 1 and 1 or 2)
							else
								dist = 10 * (dt3 == 1 and 1 or 2)
							end
							
							if mdl == "models/wystan/attachments/2cog.mdl" then
								dist = dist - 2.5
							end
							
							size = n.size
							dir = self.Owner:EyeAngles() + self.Owner:GetPunchAngle()
							
							if n.aimmove then
								dir.y = dir.y + self.AngleDelta.y * 0.1
								dir.p = dir.p - self.AngleDelta.p * 0.1
							end
							
							dir = dir:Forward()
							dist = dist - self.RecoilAmt
							scale = 10 / dist
							size = size / scale
							self.DrawTable = {dist = dist - self.RecoilAmt, scale = scale, size = size, dir = dir, mat = n.mat}
						end
						
						render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
						render.SetBlend(v.color.a/255)
						model:DrawModel()
						render.SetBlend(1)
						render.SetColorModulation(1, 1, 1)
						 
						if (v.surpresslightning) then
							render.SuppressEngineLighting(false)
						end
					else
						render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
						render.SetBlend(v.color.a/255)
						model:DrawModel()
						render.SetBlend(1)
						render.SetColorModulation(1, 1, 1)
						 
						if (v.surpresslightning) then
							render.SuppressEngineLighting(false)
						end
					end
					 
				elseif (v.type == "Sprite" and sprite) then
					 
					drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					render.SetMaterial(sprite)
					rdrawsprite(drawpos, v.size.x, v.size.y, v.color)
					 
				elseif (v.type == "Quad" and v.draw_func) then
					
					drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
					ang:RotateAroundAxis(ang:Up(), v.angle.y)
					ang:RotateAroundAxis(ang:Right(), v.angle.p)
					ang:RotateAroundAxis(ang:Forward(), v.angle.r)
					 
					cam.Start3D2D(drawpos, ang, v.size)
						v.draw_func( self )
					cam.End3D2D()
	 
				end
            end
        end
		
		if self.VElements then
			entry = self.VElements["laser"]
				
			if entry and entry.color.a == 255 and IsValid(entry.modelEnt) then
				lt = self.LaserTune
				fw = entry.modelEnt:GetAngles()
				pos = entry.modelEnt:GetPos()
				pos = pos + aim:Right() * lt.PosRight + aim:Up() * lt.PosUp + aim:Forward() * lt.PosForward
				fw:RotateAroundAxis(fw:Right(), lt.AngUp)
				fw:RotateAroundAxis(fw:Up(), lt.AngRight)
				fw:RotateAroundAxis(fw:Forward(), lt.AngForward)
				fw = fw:Forward()
					
				if dt3 == 1 then
					if self.MoveWithFiringAnim then
						activity = vm:GetSequenceActivityName(vm:GetSequence())
						
						if activity == "ACT_VM_PRIMARYATTACK" and vm:GetCycle() < 0.99 then
							dir = fw
						else
							dir = (aim + Angle(self.AngleDelta.p / -9, self.AngleDelta.y / 9, 0) + self.Owner:GetPunchAngle()):Forward()
						end
					else
						dir = (aim + Angle(self.AngleDelta.p / -9, self.AngleDelta.y / 9, 0) + self.Owner:GetPunchAngle()):Forward()
					end
				else
					dir = fw
				end
					
				td.start = pos
				td.endpos = td.start + dir * 8192
				td.filter = self.Owner
					
				trace = util.TraceLine(td)
					
				if util.PointContents(trace.HitPos) != CONTENTS_SOLID then
					dist = td.start:Distance(trace.HitPos)
					
					render.SetMaterial(Laser)
					render.DrawBeam(pos + dir, pos + dir * math.Clamp(dist, 0, 75), 0.1, 0, 0.99, Color(255, 0, 0, 200))
					
					render.SetMaterial(LaserDot)
					
					if GetConVarNumber("cstm_ef_laserblur") > 0 then
						if self.LastLaserPos then
							render.DrawBeam(trace.HitPos + YOff, self.LastLaserPos - YOff, 2, 0, 1, Color(255, 0, 0, 255))
						end
						
						self.LastLaserPos = trace.HitPos
					else
						rdrawsprite(trace.HitPos, 2, 2, Color(255, 0, 0, 255))
						self.LastLaserPos = nil
					end
				end
			end
		end
		
		if IsValid(self.Owner.CSTM_Nade) then
			wep = self.Owner.CSTM_Nade
			
			if wep:GetCycle() < 0.98 then
				FT = FrameTime()
				EP = EyePos()
				EA = EyeAngles()
				EP = EP - EA:Up() * wep.Lower
				wep:SetRenderOrigin(EP + EA:Forward() * 8)
				wep:SetRenderAngles(EA)
				wep:FrameAdvance(FT)
				wep:SetupBones()
				wep:DrawModel()
					
				wep.Lower = Lerp(FT * 5, wep.Lower, 2)
			end
		end
		
		TWeps_BBP()
    end
 
    SWEP.wRenderOrder = nil
	
    function SWEP:DrawWorldModel()
        if (self.ShowWorldModel == nil or self.ShowWorldModel) then
            self:DrawModel()
		else
			self:DrawShadow(false)
        end
         
        if (!self.WElements) then return end
         
        if (!self.wRenderOrder) then
 
            self.wRenderOrder = {}
 
            for k, v in pairs( self.WElements ) do
                if (v.type == "Model") then
                    table.insert(self.wRenderOrder, 1, k)
                elseif (v.type == "Sprite" or v.type == "Quad") then
                    table.insert(self.wRenderOrder, k)
                end
            end
 
        end
         
        if (IsValid(self.Owner)) then
            bone_ent = self.Owner
        else
            // when the weapon is dropped
            bone_ent = self
        end
         
        for k, name in pairs( self.wRenderOrder ) do
         
            entry = self.WElements[name]
			
			if entry.color.a == 255 then
				if (!entry) then self.wRenderOrder = nil break end
				 
				pos, ang = nil, nil
				 
				if (entry.bone) then
					pos, ang = self:GetBoneOrientation( self.WElements, entry, bone_ent )
				else
					pos, ang = self:GetBoneOrientation( self.WElements, entry, bone_ent, "ValveBiped.Bip01_R_Hand" )
				end
				 
				if (!pos) then continue end
				 
				model = entry.modelEnt
				sprite = entry.spriteMaterial
				 
				if (entry.type == "Model" and IsValid(model)) then
					mtr = Matrix()
					mtr:Scale(entry.size)
					model:EnableMatrix("RenderMultiply", mtr)
					model:SetPos(pos + ang:Forward() * entry.pos.x + ang:Right() * entry.pos.y + ang:Up() * entry.pos.z )
					ang:RotateAroundAxis(ang:Up(), entry.angle.y)
					ang:RotateAroundAxis(ang:Right(), entry.angle.p)
					ang:RotateAroundAxis(ang:Forward(), entry.angle.r)
	 
					model:SetAngles(ang)
					//model:SetModelScale(entry.size)
					 
					if (entry.material == "") then
						model:SetMaterial("")
					elseif (model:GetMaterial() != entry.material) then
						model:SetMaterial( entry.material )
					end
					 
					if (entry.skin and entry.skin != model:GetSkin()) then
						model:SetSkin(entry.skin)
					end
					 
					if (entry.bodygroup) then
						for k, entry in pairs( entry.bodygroup ) do
							if (model:GetBodygroup(k) != entry) then
								model:SetBodygroup(k, entry)
							end
						end
					end
					 
					if (entry.surpresslightning) then
						render.SuppressEngineLighting(true)
					end
					 
					render.SetColorModulation(entry.color.r/255, entry.color.g/255, entry.color.b/255)
					render.SetBlend(entry.color.a/255)
					model:DrawModel()
					render.SetBlend(1)
					render.SetColorModulation(1, 1, 1)
					 
					if (entry.surpresslightning) then
						render.SuppressEngineLighting(false)
					end
					 
				elseif (entry.type == "Sprite" and sprite) then
					 
					drawpos = pos + ang:Forward() * entry.pos.x + ang:Right() * entry.pos.y + ang:Up() * entry.pos.z
					render.SetMaterial(sprite)
					render.DrawSprite(drawpos, entry.size.x, entry.size.y, entry.color)
					 
				elseif (entry.type == "Quad" and entry.draw_func) then
					 
					drawpos = pos + ang:Forward() * entry.pos.x + ang:Right() * entry.pos.y + ang:Up() * entry.pos.z
					ang:RotateAroundAxis(ang:Up(), entry.angle.y)
					ang:RotateAroundAxis(ang:Right(), entry.angle.p)
					ang:RotateAroundAxis(ang:Forward(), entry.angle.r)
					 
					cam.Start3D2D(drawpos, ang, entry.size)
						entry.draw_func( self )
					cam.End3D2D()
	 
				end
            end
        end
         
    end
	
    function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
         
        bone, pos, ang = nil, nil, nil
        if (tab.rel and tab.rel != "") then
             
            v = basetab[tab.rel]
             
            if (!v) then return end
             
            // Technically, if there exists an element with the same name as a bone
            // you can get in an infinite loop. Let's just hope nobody's that stupid.
            pos, ang = self:GetBoneOrientation( basetab, v, ent )
             
            if (!pos) then return end
            
            pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
            ang:RotateAroundAxis(ang:Up(), v.angle.y)
            ang:RotateAroundAxis(ang:Right(), v.angle.p)
            ang:RotateAroundAxis(ang:Forward(), v.angle.r)
                 
        else
         
            bone = ent:LookupBone(bone_override or tab.bone)
 
            if (!bone) then return end
             
            pos, ang = Vector(0,0,0), Angle(0,0,0)
            m = ent:GetBoneMatrix(bone)
            if (m) then
                pos, ang = m:GetTranslation(), m:GetAngles()
            end
             
            if (IsValid(self.Owner) and self.Owner:IsPlayer() and
                ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
                ang.r = -ang.r // Fixes mirrored models
            end
         
        end
         
        return pos, ang
    end
 
    function SWEP:CreateModels( tab )
 
        if (!tab) then return end
 
        // Create the clientside models here because Garry says we can't do it in the render hook
        for k, v in pairs( tab ) do
            if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and file.Exists(v.model, "GAME")) then
                v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
                if (IsValid(v.modelEnt)) then
                    v.modelEnt:SetPos(self:GetPos())
                    v.modelEnt:SetAngles(self:GetAngles())
                    v.modelEnt:SetParent(self)
                    v.modelEnt:SetNoDraw(true)
                    v.createdModel = v.model
                else
                    v.modelEnt = nil
                end
                 
            elseif (v.type == "Sprite" and v.sprite and v.sprite != "" and (!v.spriteMaterial or v.createdSprite != v.sprite) and file.Exists(v.sprite .. ".vmt", "GAME")) then
                name = v.sprite.."-"
                params = { ["$basetexture"] = v.sprite }
                // make sure we create a unique name based on the selected options
                tocheck = { "nocull", "additive", "vertexalpha", "vertexcolor", "ignorez" }
                for i, j in pairs( tocheck ) do
                    if (v[j]) then
                        params["$"..j] = 1
                        name = name.."1"
                    else
                        name = name.."0"
                    end
                end
 
                v.createdSprite = v.sprite
                v.spriteMaterial = CreateMaterial(name,"UnlitGeneric",params)
                 
            end
        end
         
    end
 
   // function SWEP:OnRemove()
    //    self:RemoveModels()
   // end
 
    function SWEP:RemoveModels()
        if (self.VElements) then
            for k, v in pairs( self.VElements ) do
                if (IsValid( v.modelEnt )) then v.modelEnt:Remove() end
            end
        end
        if (self.WElements) then
            for k, v in pairs( self.WElements ) do
                if (IsValid( v.modelEnt )) then v.modelEnt:Remove() end
            end
        end
		
        self.VElements = nil
        self.WElements = nil
    end
	
    function table.FullCopy( tab )
 
        if (!tab) then return nil end
         
        local res = {}
        for k, v in pairs( tab ) do
            if (type(v) == "table") then
                res[k] = table.FullCopy(v) // recursion ho!
            elseif (type(v) == "Vector") then
                res[k] = Vector(v.x, v.y, v.z)
            elseif (type(v) == "Angle") then
                res[k] = Angle(v.p, v.y, v.r)
            else
                res[k] = v
            end
        end
         
        return res
         
    end
 
end