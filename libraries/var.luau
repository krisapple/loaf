return function (thread, arguments)
	if not thread then return end
	
	if #arguments ~= 2 then return end
	
	local newvar = Instance.new("StringValue")
	newvar.Name = arguments[1]
	newvar.Parent = thread.Variables
	newvar.Value = arguments[2]
end
