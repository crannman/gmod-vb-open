local oldPrint = print
function print(...)
  if istable(...) then
    PrintTable(...)
  else
    oldPrint(...)
  end
end