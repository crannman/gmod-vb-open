include("shared.lua")

SWEP.PrintName             = "VBRP Entity Information Finder"
SWEP.Slot                  = 0
SWEP.SlotPos               = 1
SWEP.DrawCrosshair         = true
SWEP.UseHands              = false

function SWEP:DrawHUD()

  draw.RoundedBox(5, ScrW() * .5 - 380 / 2, ScrH() * .84, 380, 110, Color(12, 12, 12, 175))
  local trace = self.Owner:GetEyeTrace()

  if IsValid(trace.Entity) and trace.Entity:GetClass() == "vbrp_vehicle_trunk" then
    trace.Entity = trace.Entity:GetParent()
  end

  local index = ""
  local name = ""
  local position = ""
  local model = ""
  local owner = "world"

  if IsValid(trace.Entity) then

    entity    = trace.Entity
    index     = entity:EntIndex()
    name      = entity:GetClass()
    position  = entity:GetPos():VecToString()
    model     = entity:GetModel()

    if (string.StartWith(name, "vbrp_")
    or string.StartWith(name, "prop_vehicle_jeep") 
    or string.StartWith(name, "func_door") 
    or string.StartWith(name, "prop_door")) then
      owner = Either(entity:GetEntOwner() == "", "world", entity:GetEntOwner())
    end

  end
  draw.DrawText("Class: " .. name .. "\nIndex: " .. index .. "\nPosition: " .. position .. "\nModel: " .. model .. "\nOwner: " .. owner, "VBFONT_HUDNORMAL", ScrW() * .5 - 380 / 2 + 5, ScrH() * .85, Color(255, 255, 255, 255))

end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end
