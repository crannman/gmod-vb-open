local VBRP_Player = FindMetaTable("Player")

function VBRP_Player:CreateRagdoll()

  self.DeathRagdoll = self.DeathRagdoll or false

  if self.DeathRagdoll and IsValid(self.DeathRagdoll) then
    self.DeathRagdoll:Remove()
    self.DeathRagdoll = nil
  end

  local pos = self:GetPos()
  local ang = self:GetAngles()
  local model = self:GetModel()
  local skin = self:GetSkin()
  
  local ragdoll = ents.Create("prop_ragdoll")
  ragdoll:SetPos(pos + Vector(0, 0, 1))
  ragdoll:SetAngles(ang)
  ragdoll:SetModel(model)
  ragdoll:SetSkin(skin)
  ragdoll:SetCreator(self)
  ragdoll:SetNWBool("VB::NW::Bool::Flag::MapEntity")
  ragdoll:Spawn()
  if self:Team() == TEAM_CITIZEN then
    ragdoll:SetModelWithIdentifier(self:GetPlayerModel())
  end

  local phys = ragdoll:GetPhysicsObject()
  if IsValid(phys) then
    phys:SetMass(phys:GetMass())
  end

  if not IsValid(ragdoll) then return end

  self.DeathRagdoll = ragdoll
  
  local velocity = self:GetVelocity()
  for i = 0, ragdoll:GetPhysicsObjectCount() -  1 do
    local bone = ragdoll:GetPhysicsObjectNum(i)
    if IsValid(bone) then
      local bonePos, boneAng = self:GetBonePosition(ragdoll:TranslatePhysBoneToBone(i))
      bone:SetPos(bonePos)
      bone:SetAngles(boneAng)
      bone:SetVelocity(velocity)
    end
  end
  ragdoll:SetFlexScale(self:GetFlexScale())
  for i = 1, ragdoll:GetFlexNum() do
    ragdoll:SetFlexWeight(i, self:GetFlexWeight(i))
  end
  
  ragdoll:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER)

  self:SetDTDeathRagdollIndex(ragdoll:EntIndex())
end