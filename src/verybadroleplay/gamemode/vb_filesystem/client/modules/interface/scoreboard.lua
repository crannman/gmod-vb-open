local VBScoreboard = VBScoreboard or {}
local create = vgui.Create
local sW, sH = ScrW(), ScrH()

local function getRankStringColor(rank)
  if rank == 0 then return {Color(0, 0, 0), "BOT"} end
  local tbl = {
    [1] = {
      Color(255, 255, 255),
      "Player",
    },
    [2] = {
      Color(0, 0, 120),
      "VIP"
    },
    [3] = {
      Color(120, 120, 120),
      "VIP+"
    },
    [4] = {
      Color(255, 255, 0),
      "Premium"
    },
    [5] = {
      Color(245, 152, 66),
      "Moderator"
    },
    [6] = {
      Color(247, 30, 73),
      "Administrator"
    },
    [7] = {
      Color(217, 65, 212),
      "Superadmin"
    }
  }
  return tbl[rank]
end

function VBScoreboard:Show()

  local scorePanel = create("DScrollPanel")
  scorePanel:SetSize(1280, 580)
  scorePanel:SetPos(sW / 2 - 640, sH / 2 - 300)
  function scorePanel:Paint()
    draw.BlurPanel(self, 7)
    draw.RoundedBox(0, 0, 0, self:GetWide(), self:GetTall(), Color(0, 0, 0, 120))
  end

  for k, v in pairs(player.GetAll()) do
    local playerPanel = create("DPanel")
    playerPanel:SetSize(1250, 40)
    playerPanel:SetPos(15, 20 + 50 * (k - 1))
    function playerPanel:Paint()
      draw.RoundedBoxEx(8, 0, 0, self:GetWide(), self:GetTall(), COLOR_GREYBLUE, true, false, true, false)
      draw.RoundedBoxEx(8, 0, 0, 16, self:GetTall(), team.GetColor(v:Team()), true, false, true, false)
    end
    scorePanel:Add(playerPanel)
    surface.SetFont("VBFONT_SCOREBOARD")
    local _, h = surface.GetTextSize("AAA")
    local richText = create("RichText", playerPanel)
    richText:SetSize(600, h)
    richText:SetPos(25, 25 - h)
    richText:SetVerticalScrollbarEnabled(false)
    function richText:Paint()
      richText:SetFontInternal("VBFONT_SCOREBOARD")
      richText:SetFGColor(COLOR_WHITE)
    end
    richText:InsertColorChange(255, 255, 255, 255)
    richText:AppendText(v:GetCompleteName() .. " ~ ")
    local info = getRankStringColor(v:GetRank())
    richText:InsertColorChange(info[1].r, info[1].g, info[1].b, 255)
    richText:AppendText(info[2])
  end

  scorePanel:GetVBar():SetWidth(0)

  function VBScoreboard:Hide()
    scorePanel:Remove()
  end

end

function GM:ScoreboardShow()

  VBScoreboard:Show()

end

function GM:ScoreboardHide()

  VBScoreboard:Hide()

end