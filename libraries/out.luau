local Localization = require(script.Parent.Parent.main.localization)

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
	
	if str == nil or str == "nil" then
		str = "null"
	end
	
	print(`Loaf {Localization.settings.glm("Runtime")} ` .. math.round(os.clock()) .. " : " .. str)
end
