function string.Sanitise(str, maxChar)
  maxChar = maxChar or #str
  return str:gsub("[^%w-]", ""):sub(1, maxChar)
end

function string.ToMultiLines(text, font, mWidth)

	surface.SetFont(font)
	local buffer = { }
	local nLines = { }
	for word in string.gmatch(text, "%S+") do
		local w,h = surface.GetTextSize(table.concat(buffer, " ").." "..word)
		if w > mWidth then
			table.insert(nLines, table.concat(buffer, " "))
			buffer = { }
		end
		table.insert(buffer, word)
	end
	if #buffer > 0 then
		table.insert(nLines, table.concat(buffer, " "))
	end
	return nLines

end