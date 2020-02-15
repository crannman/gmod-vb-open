function CreateNewClientsideError(where, error)
  VBRP.log("An error occurred... Generating an error report and sending it to the server.", "VB-Framework::ErrorReporter")
  net.Start("VBNET_StartErrorReport")
  net.WriteString(where)
  net.WriteString(error)
  net.SendToServer()
end

net.Receive("VBNET_ConfirmErrorReport", function()
  VBRP.log("Server successfully received error report. If the error persists contact an administrator.", "VB-Framework::ErrorReporter")
end)

net.Receive("VBNET_NACK", function()
VBRP.log("Failed to acknowledge the message. Error report won't be recorded.", "VB-Framework::ErrorReporter")
end)