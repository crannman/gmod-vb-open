local ts = team.SetUp

--*-- Constant definition --*--
TEAM_CITIZEN = 1
TEAM_COP = 2
TEAM_MEDIC = 3
TEAM_POLICECHIEF = 4
TEAM_SWAT = 5
TEAM_COOK = 6
ts(TEAM_CITIZEN, "Citizen", Color(165, 209, 82), true)
ts(TEAM_COP, "Cop", Color(0, 120, 255))
ts(TEAM_POLICECHIEF, "Police Chief", Color(0, 160, 255))
ts(TEAM_SWAT, "SWAT", Color(0, 79, 112))
ts(TEAM_COOK, "Cook", Color(255, 144, 0))
ts(TEAM_MEDIC, "Medic", Color(30, 214, 190))

VBJOB.Setup()