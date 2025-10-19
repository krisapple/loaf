return function (thread, arguments)
	if not thread then return end
	task.wait(arguments[1])
end
