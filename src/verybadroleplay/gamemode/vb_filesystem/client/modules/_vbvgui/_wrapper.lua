VBVGUI = VBVGUI or {}
VBVGUI.__index = VBVGUI
VBVGUI.Elements = VBVGUI.Elements or {}


function VBVGUI:Register(name, panel, base)
  
  if not self.Elements[name] then
    self.Elements[name] = true
    VBRP.log(string.format("Registering a new element [%s] based on [%s]", name, base), "VB-Framework::VGUI")
  end
  return vgui.Register("VBRP::VGUIElement::" .. name, panel, base)

end

function VBVGUI:GetCompleteIdentifier(name)

  if self.Elements[name] then
    return "VBRP::VGUIElement::" .. name
  end
  return "PANEL NOT FOUND"
  
end

function VBVGUI:GetElements()

  return self.Elements

end

function VBVGUI:Create(element, parent, name)

  parent = parent or nil
  name = name or nil
  return vgui.Create("VBRP::VGUIElement::" .. element, parent, name)
  
end

