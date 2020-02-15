AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local isvalid, ipairs = IsValid, ipairs
local l2w = util.LocalToWorld
local findInSphere = ents.FindInSphere
local fmt = string.format



ENT.Positions = {
  { 
    Vector(-10, -11.5, 19), 
    ["vbrp_frying_pan"] = { Vector(-10, -15, 18), Angle(0, 90, 0), Scale = 0.75 },
    ["vbrp_cooking_pot"] = { Vector(-10, -17, 18), Angle(0, 0, 0), Scale = 1 } 
  },
  { 
    Vector(-10, 11, 19),
    ["vbrp_frying_pan"] = { Vector(-10, 14.7, 18), Angle(0, -90, 0), Scale = 0.75 },
    ["vbrp_cooking_pot"] = { Vector(-10, 16.7, 18), Angle(0, 180, 0), Scale = 1 } 
  },
  {
    Vector(3, -11.5, 19),   
    ["vbrp_frying_pan"] = { Vector(3, -15, 18), Angle(0, 90, 0), Scale = 0.75 }, 
    ["vbrp_cooking_pot"] = { Vector(3, -17, 18), Angle(0, 0, 0), Scale = 1 }
  },
  {
    Vector(3, 11, 19),
    ["vbrp_frying_pan"] = { Vector(3, 14.7, 18), Angle(0, -90, 0), Scale = 0.75 },
    ["vbrp_cooking_pot"] = { Vector(3, 16.7, 18), Angle(0, 180, 0), Scale = 1 } 
  },
}

function ENT:Initialize()

  self:SetModel("models/props_c17/furniturestove001a.mdl")
  self:PhysicsInit(SOLID_VPHYSICS)
  self:SetMoveType(MOVETYPE_VPHYSICS)
  self:SetSolid(SOLID_VPHYSICS)
  self:SetUseType(SIMPLE_USE)
  self:SetTrigger(true)
  local phys = self:GetPhysicsObject()
  if (IsValid(phys)) then
    phys:Wake()
  end

end


function ENT:StartTouch(ent)


  local wl = {
    ["vbrp_frying_pan"] = true,
    ["vbrp_cooking_pot"] = true
  }


  if wl[ent:GetClass()] then
    for k,v in ipairs(self.Positions) do
      if table.HasValue(findInSphere(l2w(self, v[1]), 5), ent) and self:GetDTBool(tonumber(k - 1)) then
        DropEntityIfHeld(ent)
        ent:SetParent(self)
        ent:SetModelScale(ent:GetModelScale() * v[ent:GetClass()]["Scale"])
        ent:SetPos(v[ent:GetClass()][1] + Vector(0, 0, ent:OBBMaxs().z - ent:OBBMins().z))
        ent:SetAngles(v[ent:GetClass()][2])
        ent:SetMoveType(MOVETYPE_NONE)
        ent:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
        self:SetDTBool(tonumber(k - 1), false)
        self:SetDTAvailablePlates(self:GetDTAvailablePlates() - 1)
        break
      end
    end
  end

end

function ENT:Use(activator, caller, useType, value)
  if caller:IsArrested() then return false end
  
  if caller:Team() == TEAM_COOK then
    OpenRecipesMenu(self, caller)
  end
end

function ENT:UpdateActiveRecipe(food, pl)

  self.ActiveRecipe = food
  local payload = {
    PrettyName = food.PrettyName,
    Recipe = food.Recipe,
  }
  net.Start("VBNET::Jobs::Cook::Recipes::UpdateStoveRecipe")
  net.WriteTable(payload)
  net.WriteEntity(self)
  net.Send(pl)

end