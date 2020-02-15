local td = {}
local tr, headpos, dmgpos, ent, d, speed, wep, p, sp1, sp2, sp3, mul
local No = Vector(0, 0, 0) -- use existing tables instead of creating new ones every time

local PenMul = {
	[MAT_WOOD] = 1.15,
	[MAT_METAL] = 0.75,
	[MAT_VENT] = 0.75,
	[MAT_SAND] = 0.85,
	[MAT_PLASTIC] = 1.25,
	[MAT_TILE] = 0.9 }
	
local PLY = debug.getregistry().Player

function PLY:FireBulletsEx(num, pos, dir, dmg, spread, force, penstr, t, pen, abd, penmod)
	if not t then
		t = CurTime()
	end
	
	if not abd then -- abd stands for "additional bullet drop"
		abd = 0
	end
	
	if not penmod then
		penmod = -0.01 -- set it to -0.01 to prevent penetration strength decrease even if we're firing point-blank
	end
	
	if not util.IsInWorld(pos) then -- Eliminate the bullet if it went outside the map
		return
	end
	
	wep = self:GetActiveWeapon()

	speed = (wep.MuzVel or 512) / 1.7877 -- slightly decrease muzzle velocity to make sure it's identical to real life
	sp1 = math.Rand(-spread, spread) * 0.75
	sp2 = math.Rand(-spread, spread) * 0.75
	sp3 = math.Rand(-spread, 0) * 0.75
	
	dir.x = dir.x + sp1
	dir.y = dir.y + sp2
	dir.z = dir.z + sp3
	spread = 0
	
	timer.Simple(0.0001, function()
		td.start = pos
		td.endpos = td.start + dir * speed
		td.filter = self
		
		tr = util.TraceLine(td)
		abd = abd + 0.05
		penmod = penmod + 0.01
		
		if tr.Hit then
			ent = tr.Entity
			
			if SERVER then
				if tr.HitWorld or ent and ent:GetClass():find("prop_") and not pen then
					mul = PenMul[tr.MatType] or 1
					
					td.start = tr.HitPos + dir * ((penstr - penmod) * mul)
					td.endpos = td.start + dir * 1
					td.filter = self
					
					tr = util.TraceLine(td)
					
					self:FireBullets({Num = num, Src = pos, Dir = dir, Spread = No, Tracer = 0, Force = dmg, Damage = dmg, Callback = function(att, trace, dmg)
						if wep:GetDTInt(2) == 1 then
							if IsValid(trace.Entity) then
								trace.Entity:Ignite(6)
							end
							
							ParticleEffect("cstm_incendiary_hit", trace.HitPos, trace.HitNormal:Angle(), nil)
						end
					end})
					
					if not tr.Hit then
						tr.HitPos.z = tr.HitPos.z - (0.1 + abd)
						self:FireBulletsEx(num, tr.HitPos, dir, dmg, math.Rand(-0.1, 0.1), force, penstr, t, true, abd, penmod)
					end
				else
					self:FireBullets({Num = num, Src = pos, Dir = dir, Spread = No, Tracer = 0, Force = dmg, Damage = dmg, Callback = function(att, trace, dmg)
						if wep:GetDTInt(2) == 1 then
							if IsValid(trace.Entity) then
								trace.Entity:Ignite(6)
							end
							
							ParticleEffect("cstm_incendiary_hit", trace.HitPos, trace.HitNormal:Angle(), nil)
						end
					end})
				end
			end
		else
			tr.HitPos.z = tr.HitPos.z - (0.1 + abd)
			self:FireBulletsEx(num, tr.HitPos, dir, dmg, spread, force, penstr, t, pen, abd, penmod)
		end
	end)
end
