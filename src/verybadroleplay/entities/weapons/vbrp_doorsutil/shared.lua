if SERVER then
  AddCSLuaFile()
  util.AddNetworkString("RequestMapCreationID")
  util.AddNetworkString("SendMapCreationID")
  net.Receive("RequestMapCreationID", function(len, ply) 
    local tbl = net.ReadTable()
    local tbl_ret = {}
    for k, v in pairs(tbl) do
      table.insert(tbl_ret, v:MapCreationID())
    end
    net.Start('SendMapCreationID')
    net.WriteTable(tbl_ret)
    net.Send(ply)
  end)
end

if CLIENT then
    SWEP.Slot = 0
    SWEP.SlotPos = 1
    SWEP.DrawAmmo = false
    SWEP.PrintName = "VBRP Doors utility"
    SWEP.DrawCrosshair = true
end

SWEP.PrintName = "VBRP Doors utility"
SWEP.AdminSpawnable = true
SWEP.Spawnable = true
SWEP.Author = "Azzen"
SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/v_pistol.mdl"
SWEP.Instructions = "Left click (primary): Select a door\nRight click (secondary): Create a doors group and send it in console."
SWEP.Primary.Delay = 1
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.Delay = 1
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

function SWEP:Initialize()
    self:SetWeaponHoldType("normal")
end

local doorsGroup = {}

function SWEP:PrimaryAttack()
    if CLIENT and IsFirstTimePredicted() then
      local client = self.Owner
      local door = client:GetEyeTrace().Entity
      if(door:GetClass() == "prop_door_rotating" or door:GetClass() == "func_door"  or door:GetClass() == "func_door_rotating") and not (table.HasValue(doorsGroup, door)) then
        table.insert(doorsGroup, door)
        door:SetMaterial("models/wireframe")
        door:SetColor(Color(0, 255, 0, 255))
      end
    end
end

function SWEP:SecondaryAttack()
  if CLIENT and IsFirstTimePredicted() and #doorsGroup > 0 then
    for k, v in pairs(doorsGroup) do
      v:SetMaterial("")
      v:SetColor(Color(255, 255, 255, 255))
    end
    net.Start("RequestMapCreationID")
    net.WriteTable(doorsGroup)
    net.SendToServer()
    net.Receive("SendMapCreationID", function()
      local tbl = net.ReadTable()
      local s = "Doors group: { "
      for k, v in pairs(tbl) do
        s = s .. v .. Either(k ~= #tbl, ", ", " }" )
      end
      print(s)
    end)
    doorsGroup = {}
  end
end

function SWEP:DrawHUD()
end

function SWEP:Think()
end

function SWEP:Deploy()
    return true
end

function SWEP:Holster()
    return true
end

function SWEP:OnRemove()
end

function SWEP:OnRestore()
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
end