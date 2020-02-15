-- @desc Wrap d'un text avec une limite;
-- @args string text, int limit;
-- @realm Client;
-- @return string WrapText;
function string.WrapText(text, linewidth)
  if not linewidth then
      linewidth = 75
  end

  local spaceleft = linewidth
  local res = {}
  local line = {}

  for _, word in ipairs(splittokens(text)) do
      if #word + 1 > spaceleft then
          table.insert(res, table.concat(line, ' '))
          line = {word}
          spaceleft = linewidth - #word
      else
          table.insert(line, word)
          spaceleft = spaceleft - (#word + 1)
      end
  end

  table.insert(res, table.concat(line, ' '))
  return table.concat(res, '\r\n')
end

function string.Trim(s)
  return s:gsub("^%s*(.-)%s*$", "%1")
end

