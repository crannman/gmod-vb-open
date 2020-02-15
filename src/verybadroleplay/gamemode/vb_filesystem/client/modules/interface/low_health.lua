--[[-----------------------
functions localization
-----------------------]]--

local dcm = DrawColorModify
local dmb = DrawMotionBlur
local clamp = math.Clamp
function LowHealthEffect()
  local health = LocalPlayer():Health()
  local tab = {
	[ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1 * clamp(2 * health / 100, 0.01, 1),
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
  }
  if health <= 50 then
    dmb(0.4, 0.8, 0.01 * 5 / clamp(health, 0.1, 50))
    dcm(tab)
  end
end


hook.Add("RenderScreenspaceEffects", "VBHOOK::LowHealthEffect", LowHealthEffect)