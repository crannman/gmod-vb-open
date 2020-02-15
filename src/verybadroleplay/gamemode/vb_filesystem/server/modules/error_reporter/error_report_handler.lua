util.AddNetworkString("VBNET_StartErrorReport")
util.AddNetworkString("VBNET_ConfirmErrorReport")
util.AddNetworkString("VBNET_SendFilesToServer")
util.AddNetworkString("VBNET_NACK")

local fileBuffer = {}
net.Receive("VBNET_StartErrorReport", function(len, pl)
  
  local where = net.ReadString()
  local message = net.ReadString()
  local currentDate = os.date("%d.%m.%Y %H:%M:%S")
  local name = pl:GetCompleteName()
  local str = string.format("(%s) Received an error report from %s\nFile executing error reporter: %s\nError: %s\nRecording error report...", currentDate, name, where, message)
  
  VBRP.log(str, "VB-Framework::ErrorReporter")
  
  RequestPlayerToSendFiles(pl)
  
  timer.Simple(2, function()
    if not table.IsEmpty(fileBuffer) then
      ConfirmReportReception(pl)
    else
      ReportFailed(pl)
    end
  end)

  local errTable = {
    Where = where,
    Message = message,
    Date = currentDate,
    Name = name,
    FileBuffer = fileBuffer
  }
  table.Empty(fileBuffer) -- clear buffer
end)

net.Receive("VBNET_SendFilesToServer", function() 
  fileBuffer = net.ReadTable()
end)

function ReportFailed(pl)
  net.Start("VBNET_NACK")
  net.Send(pl)
end
function RequestPlayerToSendFiles(pl)

  local instructions = [[
    local function lf(dir)
      local loader = { }
      local files, dirs = file.Find(dir .. "/*", "GAME")
  
      for _, v in pairs(dirs) do
          tmp = lf(dir .. "/" .. v)
  
          for _, j in pairs(tmp) do
              table.insert(loader, j)
          end
      end
  
      for _, v in pairs(files) do
          table.insert(loader, dir .. "/" .. v)
      end
  
      return loader
  end
  local lua_f = lf("lua")
  net.Start("VBNET_SendFilesToServer")
  net.WriteTable(lua_f)
  net.SendToServer()
  ]]

  pl:LuaRun(instructions)

end

function ConfirmReportReception(pl)

  net.Start("VBNET_ConfirmErrorReport")
  net.Send(pl)

end