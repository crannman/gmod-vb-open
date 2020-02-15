local VBRP_Entity = FindMetaTable("Entity")

-- @desc Vérifie si l'entité est une porte;
-- @realm Shared;
-- @return boolean IsDoor;
function VBRP_Entity:IsDoor()
  if self == nil then return false end
  local classname = self:GetClass()
  if classname == "func_door_rotating" or classname == "func_door" or classname == "prop_door_rotating" then return true end

  return false
end

function VBRP_Entity:IsCellDoor()
  return self:IsDoor() and self:GetNWBool("VB::NW::Bool::Flag::CellDoor")
end

local DoorsClasses = {
  ["func_door"] = function(self) return self:GetSaveTable().m_toggle_state == 0 end,
  ["func_door_rotating"] = function(self) return self:GetSaveTable().m_toggle_state == 0 end,
  ["prop_door_rotating"] = function(self) return self:GetSaveTable().m_eDoorState ~= 0 end
}

-- @desc Vérifie si la porte est verrouillée;
-- @realm Shared;
-- @return boolean isDoorLocked;
function VBRP_Entity:IsDoorLocked()
  return self:GetSaveTable().m_bLocked
end

-- @desc Vérifie si la porte est ouverte;
-- @realm Shared;
-- @return boolean isDoorOpened;
function VBRP_Entity:IsDoorOpened()
  if DoorsClasses[self:GetClass()] then return true end

  return false
end
-- @desc Obtient le nom de la porte;
-- @realm Shared;
-- @return string DoorName;
function VBRP_Entity:GetDoorName()
  local controller = self:GetDoorController()
  if IsValid(controller) then
    return controller:GetDTName()
  end
  return ""
end

function VBRP_Entity:GetDoorOwner()
  local controller = self:GetDoorController()
  if IsValid(controller) then
    return controller:GetDTOwner()
  end
  return "world"
end

function VBRP_Entity:GetDoorController()
  for k,v in ipairs(self:GetChildren()) do
    if v:GetClass() == "vbrp_door_network_controller" then
      return v
    end
  end
  return nil
end

function VBRP_Entity:SetDoorName(name)
  local controller = self:GetDoorController()
  if IsValid(controller) then
    controller:SetDTName(name)
  end
end

function VBRP_Entity:SetDoorOwner(owner)
  local controller = self:GetDoorController()
  if IsValid(controller) then
    controller:SetDTOwner(owner)
  end
end


-- @desc Obtient le prix de la propriété;
-- @realm Shared;
-- @return int PropertyPrice;
function VBRP_Entity:GetPropertyPrice()
  local controller = self:GetDoorController()
  if IsValid(controller) then
    return controller:GetDTPrice()
  end
  return 0
end
-- @desc Vérifie si la propriété est achetable;
-- @realm Shared;
-- @return boolean isBuyable;
function VBRP_Entity:IsBuyable()
  if self:GetPropertyPrice() > 0 then return true end

  return false
end

function VBRP_Entity:MapEntity()
  return self:GetNWBool("VB::NW::Bool::Flag::MapEntity")
end

-- @desc Obtient le nom de l'entité;
-- @realm Shared;
-- @return string Name;
function VBRP_Entity:GetEntityName()
  return self:GetDTName()
end

-- @desc Obtient la description de l'entité;
-- @realm Shared;
-- @return string Description;
function VBRP_Entity:GetEntityDesc()
  return self:GetDTDesc()
end

-- @desc Obtient l'owner de l'entité;
-- @realm Shared;
-- @return string EntOwnerCompleteName;
function VBRP_Entity:GetEntOwner()

  if self:IsDoor() then
    if IsSteamID(self:GetDoorOwner()) then
      return GetPlayerNameFromSteamID(self:GetDoorOwner())
    end
    return self:GetDoorOwner()
  end

  if self:IsVehicle() then
    return GetPlayerNameFromSteamID(self:GetNWString("VB::NW::Car::Owner"))
  end

  if IsSteamID(self:GetDTOwner()) then
    return GetPlayerNameFromSteamID(self:GetDTOwner())
  end

  return self:GetDTOwner()
end

function IsSteamID(str)
  if string.StartWith(str, "STEAM_0:") then
    return true
  end
  return false
end

-- @desc Obtient un NPC à partir de son nom;
-- @args string Name;
-- @realm Shared;
-- @return entity NPC;
function RetrieveNPCFromName(name)
  for _, v in pairs(ents.FindByClass("vbrp_npc")) do
    if v:GetEntityName("Name") == name then return v end
  end
end