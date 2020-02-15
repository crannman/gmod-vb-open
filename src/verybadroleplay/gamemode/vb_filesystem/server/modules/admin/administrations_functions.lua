VBRP.AdminFunc = {
  ["Noclip"] = {
    Description = "Enable/Disable No Clip",
    Rank = 5,
    Command = "vbrp_noclip",
    State = "client",
    Function = function(ply)
      -- MOVETYPE_NOCLIP 
      if ply:GetMoveType() ~= MOVETYPE_NOCLIP then
        ply:SetMoveType(MOVETYPE_NOCLIP)
        ply:SetRenderMode(RENDERMODE_TRANSALPHA)
        ply:SetColor(Color(255, 255, 255, 0))
      else
        ply:SetMoveType(MOVETYPE_WALK)
        ply:SetRenderMode(RENDERMODE_NORMAL)
        ply:SetColor(Color(255, 255, 255, 255))
      end
    end
  },
  ["God"] = {
    Description = "Enable/Disable God mode",
    Rank = 5,
    Command = "vbrp_godmode",
    State = "client",
    Function = function(ply)
      if ply:HasGodMode() then
        ply:GodDisable()
      else
        ply:GodEnable()
      end
    end
  },
  ["Cloak"] = {
    Description = "Enable/Disable cloaking",
    Rank = 5,
    Command = "vbrp_cloak",
    State = "client",
    Function = function(ply)
      if ply:GetRenderMode() == RENDERMODE_NORMAL then
        ply:SetRenderMode(RENDERMODE_TRANSALPHA)
        ply:SetColor(Color(255, 255, 255, 0))
      else
        ply:SetRenderMode(RENDERMODE_NORMAL)
        ply:SetColor(Color(255, 255, 255, 255))
      end
    end
  },
  ["CreateEntity"] = {
    Description = "Create an entity",
    Rank = 6,
    Command = "createent",
    State = "client",
    Function = function(ply, _, args)
      if (args[1] == nil or args[1] == "") then
        VBRP.log("Failed to create entity", "VB-Framework::AdminFunc::CreateEntity")

        return
      else
        local e = ents.Create(args[1])
        e:Spawn()
        e:SetPos(ply:GetEyeTrace().HitPos + Vector(0, 0, e:OBBMaxs().z + 20))
      end
    end
  },
  ["RespawnNextBots"] = {
    Description = "Respawn NextBots",
    Rank = 6,
    Command = "vbrp_respawn_nextbots",
    State = "client",
    Function = function(ply, _, args)
      RespawnNextBots()
    end
  },
  ["Teleport"] = {
    Description = "Teleport to a player",
    Rank = 5,
    Command = "vbrp_tp",
    State = "client",
    Function = function(ply, _, args)
      local TargetPos = ply:GetPos()

      for _, v in pairs(player.GetAll()) do
        if args[1] == v:SteamID() then
          TargetPos = v:GetPos() + Vector(10, 10, 0) -- a changer
        end

        ply:SetPos(TargetPos)
      end
    end
  },
  ["ServerSay"] = {
    Description = "Server says somethings",
    Command = "ssay",
    State = "server",
    Function = function(ply, _, args)
      ServerSay(args[1])
    end
  },
  ["RegisterProperties"] = {
    Description = "Register new properties",
    Rank = 6,
    Command = "vbrp_registerproperties",
    State = "server",
    Function = function(ply, _, args)
      RegisterProperties()
    end
  },
  ["ReloadItemsTable"] = {
    Description = "Reload Items",
    Rank = 6,
    Command = "vbrp_reloaditems",
    State = "client",
    Function = function(ply, _, args)
      LoadItems()
    end
  },
}

-- @desc Créer les CVARS;
-- @realm Server;
function CreateCVAR()
  for _, func in pairs(VBRP.AdminFunc) do
    local state = FCVAR_NONE

    if func["State"] == "client" then
      state = FCVAR_CLIENTCMD_CAN_EXECUTE
    end

    if func["State"] == "server" then
      state = FCVAR_SERVER_CAN_EXECUTE
    end

    local cvarname = func["Command"]
    local callback
    if state == FCVAR_SERVER_CAN_EXECUTE then
      callback = function(ply, cmd, args)
        func["Function"](ply, cmd, args)
      end
    else
      callback = function(ply, cmd, args)
        if ply:GetRank() >= func["Rank"] then
          func["Function"](ply, cmd, args)
        else
          KickUnauthorized(ply)
        end
      end
    end

    local helptext = func["Description"]
    concommand.Add(cvarname, callback, _, helptext, state)
  end
end

function KickUnauthorized( pl )
  pl:Kick("Wow, looks like you've just found a hidden command, what a hacker!\nOur automatic cheat detection system has recorded this action for security purposes..")
  -- TODO: record this action
end

CreateCVAR()