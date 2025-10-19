return function (thread, arguments)
	if not thread then return end
	
	local str = ""
	for i = 1, #arguments do
		if i ~= 1 then
			str = `{str} {arguments[i]}`
		else
			str = `{str}{arguments[i]}`
		end
	end
	
	print("Loaf Runtime " .. math.round(os.clock()) .. " : " .. str)
end
