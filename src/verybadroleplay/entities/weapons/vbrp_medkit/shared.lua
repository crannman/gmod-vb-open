SWEP.Spawnable               = true
SWEP.ViewModel               = "models/weapons/c_medkit.mdl"
SWEP.WorldModel              = "models/weapons/w_medkit.mdl"

SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip     = -1
SWEP.Primary.Automatic       = false
SWEP.Primary.Ammo            = "none"

SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo          = "none"

SWEP.Author                  = "VALVe (models and sounds) Azzen (lua)"
SWEP.Contact                 = "https://steamcommunity.com/id/azzen"
SWEP.Purpose                 = ""
SWEP.Instructions            = ""

--[[------------------------
User defined SWEP variables
------------------------]]--

SWEP.HoldType                = "slam"
SWEP.HealSound               = Sound("items/smallmedkit1.wav")
SWEP.MaxHealthSound          = Sound("items/medshotno1.wav")
SWEP.Heal                    = 25

function SWEP:Think()
end