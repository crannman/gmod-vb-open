AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function SWEP:Initialize()

  self:SetWeaponHoldType(self.HoldType)
end

function SWEP:PrimaryAttack()

  if not IsFirstTimePredicted() then return false end
  if not self.Ready then return false end
  local target = self.Owner:GetEyeTrace().Entity
  if IsValid(target) and target:GetClass() == "prop_ragdoll" and not (self.Owner:EyePos():DistToSqr(target:GetPos()) > 120 * 120) then
      local pl = target:GetCreator()
      local pos = target:GetPos()
      local random = math.random(1, 4)
      if pl.CannotBeRevived then return false end
      self:SetNextPrimaryFire(CurTime() + 1.5)
      self:SetNextSecondaryFire(CurTime() + 1.5)
      self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
      if random == 4 then
        NotifyPlayer(string.format("La réanimation de %s a échoué", pl:GetCompleteName()), self.Owner)
        pl.CannotBeRevived = true
      else
        NotifyPlayer(string.format("La réanimation de %s a été effectuée avec succès, amenez la victime au plus vite dans votre ambulance !", pl:GetCompleteName()), self.Owner)
        NotifyPlayer("Appuyez sur la touche UTILISER pour placer la victime dans une ambulance", self.Owner)
        target.CanBeSentToAmbulance = true
      end
      timer.Simple(0.1, function()
        self:EmitSound(self.ZapSound, 50)
      end)
  end
  self.Ready = false

end

function SWEP:SecondaryAttack()

  self:SetNextPrimaryFire(CurTime() + 1.5)
  self:SetNextSecondaryFire(CurTime() + 1.5)
  self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
  timer.Simple(0.1, function()
    self:EmitSound(self.ZapSound, 50)
  end)
  timer.Simple( self:SequenceDuration(), function() if ( !IsValid( self ) ) then return end self:SendWeaponAnim( ACT_VM_IDLE ) end )
  self.Ready = true
  
end