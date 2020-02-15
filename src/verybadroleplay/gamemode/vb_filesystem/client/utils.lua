local VBRP_Entity = FindMetaTable("Entity")

--[[-------------------------------------------------------------------------
thanks facepunch for shit
---------------------------------------------------------------------------]]

-- @desc Génère une vue d'un ModelPanel qui ne dépasse pas les dimensions;
-- @args panel Panel;
-- @realm Client;
function GenerateView(Panel, zoomFactor)
    zoomFactor = zoomFactor or Vector(0.75, 0.75, 0.5)
    local PrevMins, PrevMaxs = Panel.Entity:GetRenderBounds()
    Panel:SetCamPos(PrevMins:Distance(PrevMaxs) * zoomFactor)
    Panel:SetLookAt((PrevMaxs + PrevMins) / 2)
end

-- @desc Obtient une valeur alpha en fonction de la distance d'un joueur et d'une entité;
-- @args [dist];
-- @realm Client;
-- @return int Alpha;
function VBRP_Entity:DistanceToAlpha(dist)
    dist = dist or 1.5
    return 255 - (EyePos():Distance(self:GetPos()) / dist)
end

function splittokens(s)
    local res = {}
    for w in s:gmatch("%S+") do
        res[#res+1] = w
    end
    return res
end

function countChar(base, pattern)
    return select(2, string.gsub(base, pattern, ""))
end

function GetParagraphHeight(haystack, lineHeight)
    local needle = "\r\n"
    if countChar(haystack, needle) == 0 then
        return lineHeight
    end 
    return lineHeight * 1.1 * countChar(haystack, needle)
end

-- credit http://richard.warburton.it

-- @desc Format corectement l'argent;
-- @args int n;
-- @realm Client;
-- @return string FormattedNum;
function FormatMoney(n)
    local left, num, right = string.match(n, "^([^%d]*%d)(%d*)(.-)$")

    return left .. (num:reverse():gsub("(%d%d%d)", "%1 "):reverse()) .. right .. " VB$"
end