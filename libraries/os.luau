--This library is a RDL (Roblox-Derived Library.)
--okeaoss
--10/11/25

return function (thread, arguments)
	if not thread then return end
	
	local modes = {
		clock = function(a)
			return os.clock()
		end,
	}
	
	local mode = arguments[1]
	local setvar = arguments[2]
	setvar = thread.Variables:FindFirstChild(setvar)
	
	if not mode or not setvar then
		warn("os failed to return value: function or var is not valid")
		return
	end
	
	for i = 1, 2 do
		table.remove(arguments, 1)
	end
	
	setvar.Value = modes[mode](arguments)
end
