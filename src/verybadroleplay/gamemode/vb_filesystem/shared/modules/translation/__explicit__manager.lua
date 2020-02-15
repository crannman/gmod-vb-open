VBLANG = VBLANG or {}
VBLANG.__index = VBLANG
VBLANG.Language = {}
VBLANG.Language.French = {}
VBLANG.Language.English = {}
VBLANG.CurrentLanguage = "French"
function Translate(phrase, ...)
  if not VBLANG.Language[VBLANG.CurrentLanguage][phrase] then
    return "[TranslationManager] Translation not found"
  end
  if ... ~= nil then
    return string.format(VBLANG.Language[VBLANG.CurrentLanguage][phrase], ...)
  end
  return VBLANG.Language[VBLANG.CurrentLanguage][phrase]
end