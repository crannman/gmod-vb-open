VBRP_ChatCommands = {
  ["dropmoney"] = {
    ParseParam = true, -- possède des paramètres
    MinParam = 1, -- nombre min de paramètres (sans compter le caller)
    MaxParam = 1, -- nombre max de paramètres (sans compter le caller)
    ParamType = "int", -- type de param (int, string, float, user)
    Rank = 0, -- rank pour accéder à la commande
    Func = function(Caller, Amount)
      if Caller:CanAfford(Amount) and not Caller:HasClientReachedEntitiesLimit("vbrp_money", 5) then
        local CallerPos = Caller:GetEyeTrace().HitPos
        local MoneyEnt = ents.Create("vbrp_money")
        MoneyEnt:SetDTAmount(Amount)
        MoneyEnt:SetPos(CallerPos)
        MoneyEnt:SetDTOwner(Caller:SteamID())
        Caller:UpdateMoney(Amount, "sub")
        MoneyEnt:Spawn()
        function MoneyEnt:Use(Activator, _Caller)
          self:Remove()
          _Caller:UpdateMoney(self:GetDTAmount(), "add")
        end
      end
    end,
    -- fonction executée lorsqu'on écrit la commande (param si ParseParam)
    ShowInChat = false, -- est-elle réécrite dans le chat ?
    ShouldSendCaller = true -- envoie en premier param le caller 
  },
  ["ooc"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Radius = 0,
    Head = "OOC",
    ColorHead = Color(200, 200, 200)
  },
  ["looc"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Radius = 300,
    Head = "Local OOC",
    ColorHead = Color(100, 100, 100)
  },
  ["admin"] = {
    ParseParam = false,
    Rank = 5,
    ShowInChat = true,
    ShouldSendCaller = true,
    Radius = 0,
    Head = "Admin",
    ColorHead = Color(255, 0, 0)
  },
  ["broadcast"] = {
    ParseParam = false,
    Rank = 5,
    ShowInChat = true,
    ShouldSendCaller = false,
    Radius = 0,
    Head = "Broadcast",
    ColorHead = Color(255,0,255)
  },
  ["me"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Radius = 300,
    CustomLayout = {
      Color(209, 157, 205),
      StringFormat = "* %s %s",
      Parameters = {
        "PlayerName",
        "Text"
      }
    }
  },
  ["do"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Radius = 300,
    CustomLayout = {
      Color(209, 157, 205),
      StringFormat = "* %s (( %s ))",
      Parameters = {
        "Text",
        "PlayerName"
      }
    }
  },
  ["/"] = {
    Alias = "ooc"
  },
  ["r"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Head = "Radio",
    RestrictOnGroup = "Police",
    ColorHead = Color(55, 67, 232)
  },
  ["er"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Head = "Radio",
    RestrictOnGroup = "EmergencyServices",
    ColorHead = Color(0, 255, 138)
  },
  ["u"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Head = "Urgences",
    VisibleTo = "EmergencyServices",
    ColorHead = Color(255, 0, 90)
  },
  ["g"] = {
    ParseParam = false,
    Rank = 0,
    ShowInChat = true,
    ShouldSendCaller = true,
    Head = "Groupe",
    RestrictToOrganization = true,
    ColorHead = Color(255, 255, 0)
  }
}

local groupCheck = {
  ["Police"] = function(ply) return ply:GetJob().Police end,
  ["EmergencyServices"] = function(ply) return ply:GetJob().EmergencyServices end
}

function GenerateChatBuffer(layout, ply, message)
  local buf = {}
  local varargs = {}
  for key, val in pairs(layout) do
    if (type(val) == "table" and key ~= "Parameters") then
      table.insert(buf, val)
    end
    if key == "Parameters" then
      for _, param in pairs(layout[key]) do
        if (param == "PlayerName") then
          table.insert(varargs, ply:GetCompleteName())
        end
        if (param == "Text") then
          table.insert(varargs, message)
        end
      end
      table.insert(buf, string.format(layout["StringFormat"], unpack(varargs)))
    end
  end
  return buf
end



ChatCommandPrefix = "/"
util.AddNetworkString("VBNET_StartChatViewer")
util.AddNetworkString("VBNET_StartChatViewerWithCustomLayout")

hook.Add("PlayerSay", "VBHOOK_PlayerSay", function(ply, text)
  if string.StartWith(text, ChatCommandPrefix) then
    for k, v in pairs(VBRP_ChatCommands) do
      if v["Alias"] ~= nil then
        v = VBRP_ChatCommands[v["Alias"]]
      end
      if string.StartWith(string.lower(text:sub(2)), k) then
        if v["ParseParam"] then
          text = string.Trim(text:sub(#k + #ChatCommandPrefix + 1))
          debugf(text)
          if text == "" and v["MinParam"] > 0 then
            Error("Missing parameters !\n")
            return ""
          end
          local Parameters = string.Explode(" ", text) 
          if #Parameters > v["MaxParam"] then
            Error("Too much parameters !\n")
          else
            if v["ShouldSendCaller"] then
              v["Func"](ply, unpack(Parameters, 1))
            else
              v["Func"](unpack(Parameters, 1))
            end
          end
        else
          if v["ShouldSendCaller"] and v["Func"] ~= nil then
          v["Func"](ply)
          elseif v["Func"] ~= nil then
            v["Func"]()
          end
        end
        if v["ShowInChat"] and not v["CustomLayout"] and not v["RestrictOnGroup"] and not v["VisibleTo"] and not v["RestrictToOrganization"]  then
          local message = string.Trim(text:sub(#ChatCommandPrefix + #k + 1))
          if v["Radius"] ~= 0 and #message > 0 then
            for i, j in pairs(ents.FindInSphere(ply:GetPos(), v["Radius"])) do
              if j:IsPlayer() then
                net.Start("VBNET_StartChatViewer")
                  net.WriteString(ply:GetCompleteName())
                  net.WriteColor(team.GetColor(ply:Team()))
                  net.WriteString(v["Head"])
                  net.WriteString(message)
                  net.WriteColor(v["ColorHead"])
                  net.WriteBool(v["ShouldSendCaller"])
                  net.WriteBool(true)
                net.Send(j)
              end
            end
          elseif #message > 0 and not v["CustomLayout"] then                    
            net.Start("VBNET_StartChatViewer")
              net.WriteString(ply:GetCompleteName())
              net.WriteColor(team.GetColor(ply:Team()))
              net.WriteString(v["Head"])
              net.WriteString(message)
              net.WriteColor(v["ColorHead"])
              net.WriteBool(v["ShouldSendCaller"])
              net.WriteBool(true)
            net.Broadcast()
          end
        end
        if v["CustomLayout"] then
          local message = string.Trim(text:sub(#ChatCommandPrefix + #k + 1))
          if v["Radius"] then
            local buf = GenerateChatBuffer(v["CustomLayout"], ply, message)
            for _, pl in pairs(ents.FindInSphere(ply:GetPos(), v["Radius"])) do
              if pl:IsPlayer() then
                table.insert(buf, CurTime() + 10)
                net.Start("VBNET_StartChatViewerWithCustomLayout")
                net.WriteTable(buf)
                net.Send(pl)
              end
            end
          end
        end
        if v["RestrictOnGroup"] then
          local message = string.Trim(text:sub(#ChatCommandPrefix + #k + 1))
          local group = v["RestrictOnGroup"]
          if #message > 0 and groupCheck[v["RestrictOnGroup"]](ply) then
            for i, j in ipairs(player.GetHumans()) do
              if groupCheck[v["RestrictOnGroup"]](j) then
                net.Start("VBNET_StartChatViewer")
                net.WriteString(ply:GetCompleteName())
                net.WriteColor(team.GetColor(ply:Team()))
                net.WriteString(v["Head"])
                net.WriteString(message)
                net.WriteColor(v["ColorHead"])
                net.WriteBool(v["ShouldSendCaller"])
                net.WriteBool(true)
                net.Send(j)
              end
            end
          end
        end
        if v["RestrictToOrganization"] then
        local message = string.Trim(text:sub(#ChatCommandPrefix + #k + 1))
          if #message > 0 and ply:GetGroupName() ~= "VB-Default-Organization" then
            for i, j in ipairs(player.GetHumans()) do
              if ply:SameGroupAs(j) then
                  net.Start("VBNET_StartChatViewer")
                  net.WriteString(ply:GetCompleteName())
                  net.WriteColor(team.GetColor(ply:Team()))
                  net.WriteString(v["Head"])
                  net.WriteString(message)
                  net.WriteColor(v["ColorHead"])
                  net.WriteBool(v["ShouldSendCaller"])
                  net.WriteBool(true)
                  net.Send(j)
              end
            end
          end
        end
        if v["VisibleTo"] then
          local message = string.Trim(text:sub(#ChatCommandPrefix + #k + 1))
          local group = v["VisibleTo"]
          if #message > 0 then
            for i, j in ipairs(player.GetHumans()) do
              if groupCheck[v["VisibleTo"]](j) or j == ply then
                net.Start("VBNET_StartChatViewer")
                net.WriteString(ply:GetCompleteName())
                net.WriteColor(team.GetColor(ply:Team()))
                net.WriteString(v["Head"])
                net.WriteString(message)
                net.WriteColor(v["ColorHead"])
                net.WriteBool(v["ShouldSendCaller"])
                net.WriteBool(true)
                net.Send(j)
              end
            end
          end
        end
      end
    end
  elseif #string.Trim(text) > 0 then
    local message = string.Trim(text)
    for i, j in pairs(ents.FindInSphere(ply:GetPos(), 300)) do
      if j:IsPlayer() then
        net.Start("VBNET_StartChatViewer")
          net.WriteString(ply:GetCompleteName())
          net.WriteColor(team.GetColor(ply:Team()))

          net.WriteString("")
          net.WriteString(message)

          net.WriteColor(Color(0,0,0))
          net.WriteBool(true)
          net.WriteBool(false)
        net.Send(j)
      end
    end
  end
  return ""
end)