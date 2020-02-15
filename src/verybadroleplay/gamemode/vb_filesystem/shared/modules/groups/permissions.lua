Permission = Permission or {}
Permission.__index = Permission

Permission.INVITE = 0x01
Permission.KICK = 0x02
Permission.BANK = 0x04
Permission.ADMIN = 0xFF

function Permission:Pipe(...)
  return bit.bor(0x00, ...)
end

function Permission:GetPhrase(flag)
  local phrases = {
    [Permission.KICK] = "Kick",
    [Permission.INVITE] = "Inviter",
    [Permission.BANK] = "Banque",
    [Permission.ADMIN] = "Admin"
  }
  return phrases[flag]
end

function Permission:GetFlags(bitMask)
  local flags = {}
  for k,v in pairs(Permission) do
    if isnumber(v) and self:Can(bitMask, v) then
      table.insert(flags, self:GetPhrase(v))
    end
  end
  return flags
end

function Permission:Decompose(bitMask)
  local perms = {}
  for k, v in pairs(Permission) do
    if isnumber(v) and self:Can(bitMask, v) then
      table.insert(perms, self:GetPhrase(v))
    end
  end
  return perms
end

function Permission:Can(currentPermission, what)
  return bit.band(currentPermission, what) == what
end

--[[
  Example:
  Permission:Can(
    Permission:Pipe(Permission.INVITE, Permission.KICK),
    Permission:Pipe(Permission.INVITE, Permission.KICK, Permission.ADMIN),
  )
  -> return false
]]