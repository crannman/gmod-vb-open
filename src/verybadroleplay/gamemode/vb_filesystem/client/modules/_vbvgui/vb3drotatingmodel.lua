
local BASE = baseclass.Get("DModelPanel")

local PANEL = {}

function PANEL:Init()

  self.Name = "Label"
  self.Description = "NULL Description"
  self:SetModel(Model("models/props_borealis/bluebarrel001.mdl"))
  self:SetTooltip(self.Description)
  self:SetSize(80, 80)

  self.NameLabel = vgui.Create("DLabel", self)
  self.NameLabel:SetText(self.Name)
  self.NameLabel:SetFont("VBFONT_InventoryTiny")
  self.NameLabel:SetSize(75, 10)
  self.NameLabel:SetPos(5, 5)

end

function PANEL:SetModel(modelName)

  BASE.SetModel(self, modelName)
  GenerateView(self)

end

function PANEL:Paint(w, h)

  draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 150))
  draw.RoundedBoxEx(0, 0, 0, 80, 20, Color(0, 0, 0, 100), false, false, true, true)
  BASE.Paint(self, w, h)

end

function PANEL:SetDescription(desc)

  self.Description = desc
  self:SetTooltip(self:GetName() .. "\r\n" .. "Description: " .. desc)

end

function PANEL:GetDescription()

  return self.Description

end

function PANEL:SetName(name)
  
  self.Name = name
  self.NameLabel:SetText(name)

end

function PANEL:GetName()

  return self.Name

end

VBVGUI:Register("3DRotatingModel", PANEL, "DModelPanel")