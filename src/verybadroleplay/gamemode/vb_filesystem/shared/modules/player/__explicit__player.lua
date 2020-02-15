
DEFINE_BASECLASS( "player_default" )

local PLAYER = {}

function PLAYER:SetupDataTables()
  -- not overriding base data tables
  BaseClass.SetupDataTables(self)

  -- String
  self.Player:NetworkVar("String", 0, "DTFirstName")
  self.Player:NetworkVar("String", 1, "DTLastName")
  self.Player:NetworkVar("String", 2, "DTStatus")
  self.Player:NetworkVar("String", 3, "DTModel")
  -- Integer
  self.Player:NetworkVar("Int", 0, "DTMoney")
  self.Player:NetworkVar("Int", 1, "DTSex")
  self.Player:NetworkVar("Int", 2, "DTRank")
  self.Player:NetworkVar("Int", 3, "DTGroupId")
  self.Player:NetworkVar("Int", 4, "DTGroupPermissionMask")
  self.Player:NetworkVar("Int", 5, "DTDeathRagdollIndex")
  -- Boolean
  self.Player:NetworkVar("Bool", 0, "DTRegistered")
  self.Player:NetworkVar("Bool", 1, "DTArrested")
  self.Player:NetworkVar("Bool", 2, "DTPoliceChief")
  self.Player:NetworkVar("Bool", 3, "DTUnconscious")
  -- Float
  self.Player:NetworkVar("Float", 0, "DTEnergy")
  self.Player:NetworkVar("Float", 1, "DTFoodWeight")

  if SERVER then
    self.Player:SetDTFoodWeight(0)
    self.Player:SetDTEnergy(100)
    self.Player:SetDTArrested(false)
    self.Player:SetDTDeathRagdollIndex(-1)
  end

end

player_manager.RegisterClass("player_verybadroleplay", PLAYER, "player_default")