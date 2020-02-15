AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("VBNET::Car::Trunk::Open")
util.AddNetworkString("VBNET::Car::Trunk::Lock")
util.AddNetworkString("VBNET::Car::Trunk::Unlock")
util.AddNetworkString("VBNET::Car::Trunk::RemoveItem")

local whitelist = {
  ["vbrp_item"] = true,
  ["vbrp_lamp"] = true,
  ["vbrp_weed"] = true,
  ["vbrp_weed_pot"] = true,
  ["vbrp_weed_pot_dirt"] = true,
  ["vbrp_weed_seed"] = true,
  ["vbrp_dropped_weapon"] = true
}

function ENT:Initialize()

  self:SetModel("models/combine_helicopter/helicopter_bomb01.mdl")
  self:PhysicsInit(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self:DrawShadow(false)
  self:SetUseType(SIMPLE_USE)
  self:SetTrigger(true)
  self.TrunkLimit = 0
  self.Items = {}
  -- Flag as map entity to prevent physgun pickup
  self:GetNWBool("VB::NW::Bool::Flag::MapEntity")
end

function ENT:Use(activator, caller, useType, value)
  if caller:IsArrested() then return false end
  local tbl = {}
  if activator:IsPlayer() and not self:GetDTLocked() then
    for k,v in ipairs(self.Items) do 
      tbl[k] = {
        Class = v.Class,
        Name = v.Name,
        Model = v.Model,
        Desc = v.Desc,
        Owner = v.Owner,
      }
    end
    net.Start("VBNET::Car::Trunk::Open")
    net.WriteEntity(self)
    net.WriteTable(tbl)
    net.Send(caller)
  else
    activator:LuaRun("ClientsideNotify('This trunk is locked...')")
  end
end

function ENT:StartTouch(entity)
  if entity and IsValid(entity) and whitelist[entity:GetClass()] and entity:IsPlayerHolding() and #self.Items < self.TrunkLimit and not self:GetDTLocked() then
    table.insert(self.Items, {
      Class = entity:GetClass(),
      Model = entity:GetModel(),
      Name = entity:GetDTName(),
      Owner = entity:GetDTOwner(),
      Desc = entity:GetDTDesc()
    })
    entity:Remove()
  end
end


net.Receive("VBNET::Car::Trunk::RemoveItem", function(len, pl)

  local trunk = net.ReadEntity()
  local idx = net.ReadInt(8)
  if not trunk:GetDTLocked() and trunk.Items[idx] then
    local item = trunk.Items[idx]
    local ent = ents.Create(item.Class)
    ent:SetDTOwner(item.Owner)
    ent:SetDTName(item.Name)
    ent:SetDTDesc(item.Desc)
    ent:SetModel(item.Model)
    ent:SetPos(trunk:LocalToWorld(Vector(ent:OBBMaxs().x / 2, 30 + ent:OBBMaxs().y, 10 + ent:OBBMaxs().z)))
    ent:Spawn()
    table.remove(trunk.Items, idx)
  end

end)