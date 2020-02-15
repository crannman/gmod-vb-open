--[[-------------------------------------------------------------------------
Colors used in menus
---------------------------------------------------------------------------]]
local clr = Color
-- Frame colors
COLOR_MENU_BAR                          = clr(47, 49, 54)
COLOR_MENU_BACK                         = clr(57, 59, 64)
COLOR_MENU_BACK_ALT1                    = clr(67, 69, 74)
COLOR_MENU_BORDER                       = clr(18, 13, 22)
-- Base colors
COLOR_GREYBLUE                          = clr(68, 78, 96)
COLOR_BLACK                             = clr(0, 0, 0)
COLOR_WHITE                             = clr(255, 255, 255)
COLOR_GREY                              = clr(150, 150, 150)
COLOR_SLIGHTLYGREY                      = clr(220, 220, 220)
COLOR_GREEN                             = clr(0, 255, 0)
COLOR_RED                               = clr(255, 0, 0)
COLOR_YELLOW                            = clr(255, 255, 0)
COLOR_ORANGE                            = clr(255, 144, 0)
-- Property sheet
COLOR_SHEET_BACK                        = clr(68, 78, 96)
COLOR_SHEET_TAB_FOCUS                   = clr(48, 58, 76)
-- Buttons
COLOR_BUTTON_NORMAL                     = COLOR_MENU_BACK
COLOR_BUTTON_HOVER                      = clr(67, 69, 74)
COLOR_BUTTON_CLICKED                    = COLOR_MENU_BAR
COLOR_BUTTON_NORMAL_ALT                 = COLOR_GREYBLUE
COLOR_BUTTON_HOVER_ALT                  = clr(78, 88, 106)
COLOR_BUTTON_CLICKED_ALT                = clr(58, 68, 76)
COLOR_BUTTON_DISABLED_ALT               = clr(118, 112, 122)
-- Progress bar (deprecated)
COLOR_BACKPROGRESS                      = clr(47, 79, 79)
COLOR_FOREPROGRESS                      = clr(58, 242, 75)
-- Text Entry
COLOR_TEXTENTRY_NOFOCUS                 = clr(98, 102, 112) 
COLOR_TEXTENTRY_FOCUS                   = clr(88, 92, 102) 
COLOR_TEXTENTRY_BORDER                  = clr(120, 120, 120)
-- ListView
COLOR_LIST_BACKGROUND                   = clr(48, 58, 76)
COLOR_LIST_COL_NORMAL                   = clr(78, 88, 106)
COLOR_LIST_COL_BORDER                   = clr(88, 98, 116)
COLOR_LIST_LINE_EVEN                    = clr(68, 78, 96)
COLOR_LIST_LINE_ODD                     = clr(58, 68, 86)
COLOR_LIST_LINE_SELECTED                = clr(98, 108, 126)
COLOR_LIST_LINE_HOVER                   = clr(38, 48, 66)
COLOR_LIST_PANEL                        = clr(48, 58, 76)
-- ListView alt
COLOR_LIST_BACKGROUND_ALT               = clr(47, 49, 54)
COLOR_LIST_COL_NORMAL_ALT               = clr(77, 79, 84)
COLOR_LIST_COL_BORDER_ALT               = clr(88, 98, 116)
COLOR_LIST_LINE_EVEN_ALT                = clr(57, 59, 64)
COLOR_LIST_LINE_ODD_ALT                 = clr(67, 69, 74)
COLOR_LIST_LINE_SELECTED_ALT            = clr(87, 89, 94)
COLOR_LIST_LINE_HOVER_ALT               = clr(37, 39, 44)
COLOR_LIST_PANEL_ALT                    = clr(48, 58, 76)
-- Customization menu
COLOR_CUST_ACTIVE_SECTION               = clr(63, 217, 140)
COLOR_CUST_INACTIVE_SECTION             = clr(219, 44, 96)
-- Panel
COLOR_BACK_PANEL                        = clr(67, 69, 74)
-- RGBA
COLOR_RGBA_SEMI_BLACK                   = clr(0, 0, 0, 120)
COLOR_RGBA_FULL_WHITE                   = clr(255, 255, 255, 255)
COLOR_RGBA_FULL_BLACK                   = clr(0, 0, 0, 255)
COLOR_RGBA_PICKUP_MAIN                  = clr(47, 49, 54, 255)
COLOR_RGBA_PICKUP_SECONDARY             = clr(37, 39, 44, 255)
COLOR_RGBA_WEPSELECT_MAIN               = clr(47, 49, 54, 255)
COLOR_RGBA_WEPSELECT_SECONDARY          = clr(37, 39, 44, 255)
COLOR_RGBA_WEPSELECT_SELECTED           = clr(50, 134, 70, 255)
COLOR_RGBA_WEPSELECT_SELECTED_BORDER    = clr(200, 200, 200, 40)
-- Speedometer
COLOR_VEH_MAX_SPEED                     = clr(120, 217, 82)
COLOR_VEH_MIN_SPEED                     = clr(82, 206, 217)