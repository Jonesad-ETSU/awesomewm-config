local lighter = function (c,d)
	local result = "#"
	for s in c:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
		local bg = tonumber("0x"..s) + d
		if bg < 0 then bg = 0 
		elseif bg > 255 then bg = 255 end
		result = result .. string.format("%2.2x",bg)
	end
	return result
end

local darker = function(c,d)
	local result = "#"
	for s in c:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
		local bg = tonumber("0x"..s) - d
		if bg < 0 then bg = 0 
		elseif bg > 255 then bg = 255 end
		result = result .. string.format("%2.2x",bg)
	end
	return result
end

return {
	lighter = lighter,
	darker = darker
}
