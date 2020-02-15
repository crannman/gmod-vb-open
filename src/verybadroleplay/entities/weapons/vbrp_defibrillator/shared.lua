SWEP.Spawnable               = true
SWEP.ViewModel               = Model("models/weapons/custom/v_defib.mdl")
SWEP.WorldModel              = Model("models/weapons/custom/w_defib.mdl")

SWEP.Primary.ClipSize        = -1
SWEP.Primary.DefaultClip     = -1
SWEP.Primary.Automatic       = false
SWEP.Primary.Ammo            = "none"

SWEP.Secondary.ClipSize      = -1
SWEP.Secondary.DefaultClip   = -1
SWEP.Secondary.Automatic     = false
SWEP.Secondary.Ammo          = "none"

SWEP.Author                  = "CustomHQ (models) and Azzen (lua)"
SWEP.Contact                 = "https://steamcommunity.com/id/azzen"
SWEP.Purpose                 = ""
SWEP.Instructions            = ""

--[[------------------------
User defined SWEP variables
------------------------]]--

SWEP.HoldType                = "slam"
SWEP.ZapSound                = Sound("weapons/physcannon/superphys_small_zap1.wav")
SWEP.Ready                   = false

function SWEP:Think()
end