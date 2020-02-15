local char, bxor, byte, append = string.char, bit.bxor, string.byte, file.Append
function string.xor(word, key)
 	local ret = ""
	for i = 1, #word do
		ret = ret .. char(bxor(byte(word, i, i), byte(key, i, i)))
	end
	return ret
end