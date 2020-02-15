local PANEL = {}

PANEL.SetBody = {
  [TEAM_COP] = function(self) 
    self:SetModel(LocalPlayer():GetModel())
    self.Entity:SetSkin(LocalPlayer():GetSkin()) 
  end,
  [TEAM_POLICECHIEF] = function(self)
    self:SetModel(LocalPlayer():GetModel())
    self.Entity:SetSkin(LocalPlayer():GetSkin()) 
  end,
  [TEAM_SWAT] = function(self) 
    self:SetModel(LocalPlayer():GetModel())
  end,
  [TEAM_MEDIC] = function(self)
    local format = Either(LocalPlayer():GetSex() == "M", "models/player/humans/modern/male/shared/male_0%d.mdl", "models/player/humans/modern/female/shared/female_0%d.mdl")
    self.Entity:SetSharedModel(LocalPlayer():GetPlayerModel(), format, LocalPlayer():GetSkin())
  end,
  [TEAM_COOK] = function(self)
    self:SetModel(LocalPlayer():GetModel())
    self.Entity:SetModelWithIdentifier(LocalPlayer():GetPlayerModel())
  end,
  [TEAM_CITIZEN] = function(self)
    self:SetModel(LocalPlayer():GetModel())
    self.Entity:SetModelWithIdentifier(LocalPlayer():GetPlayerModel())
  end,
}

function PANEL:Init()

  self:SetFOV(65)
  
  self.SetBody[LocalPlayer():Team()](self)
  self.Entity:SetAngles(Angle(0, 45, 0))
  self:SetAnimated(true)

end

function PANEL:LayoutEntity()

  self:RunAnimation()

end

VBVGUI:Register("BodyPanel", PANEL, "DModelPanel")