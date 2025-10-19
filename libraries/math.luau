--This library is a RDL (Roblox-Derived Library.)
--okeaoss
--10/6/25

function ReformString(t)
	local f = ""
	for i = 1, #t do
		f = `{f}{t[i]}`
	end
	return f
end

return function(thread, arguments)
	if not thread then return end
	
	local modes = {
		abs = function(a)
			if a[1] < 0 then
				return a[1]*-1
			else
				return a[1]
			end
		end,
		
		add = function(a)
			return a[1]+a[2]
		end,
		
		ceil = function(a)
			return math.ceil(a[1])
		end,
		
		clamp = function(a)
			local x = a[1]
			local min = a[2]
			local max = a[3]
			
			if x > max then return max end
			if x < min then return min end
			return x
		end,
		
		deg = function(a)
			local pi = math.pi
			return a[1] * 180/pi
		end,
		
		div = function(a)
			return a[1]/a[2]
		end,
		
		exp = function(a)
			return a[1]^a[2]
		end,
		
		floor = function(a)
			return math.floor(a[1])
		end,
		
		huge = function(a)
			return math.huge
		end,
		
		ldexp = function(a)
			return a[1]*2^a[2]
		end,
		
		lerp = function(a)
			local x = a[1]
			local y = a[2]
			local time_ = a[3]
			
			return x+(y-x)*time_
		end,
		
		log = function(a)
			return math.log(a[1], a[2])
		end,
		
		log10 = function(a)
			return math.log10(a[1])
		end,
		
		max = function(a)
			for i = 1, #a do
				a[i] = tonumber(a[i])
			end
			
			table.sort(a, function(a, b)
				return a > b
			end)

			return a[1]
		end,
		
		min = function(a)
			for i = 1, #a do
				a[i] = tonumber(a[i])
			end

			table.sort(a, function(a, b)
				return a > b
			end)

			return a[#a]
		end,
		
		mul = function(a)
			return a[1]*a[2]
		end,
		
		pi = function(a)
			return math.pi
		end,
		
		pow = function(a)
			return a[1]^a[2]
		end,
		
		rad = function(a)
			return math.rad(a[1])
		end,
		
		random = function(a)
			return math.random(a[1], a[2])
		end,
		
		randomseed = function(a)
			return math.randomseed(a[1])
		end,
		
		round = function(a)
			return math.round(a[1])
		end,
		
		sign = function(a)
			return math.sign(a[1])
		end,
		
		sub = function(a)
			return a[1]-a[2]
		end,
		
		sqrt = function(a)
			return math.sqrt(a[1])
		end,
	}
	
	local Mode = arguments[1]
	local VarSet = arguments[2]
	VarSet = thread.Variables:FindFirstChild(VarSet)
	for i = 1, 2 do table.remove(arguments, 1) end
	
	local MathFunc = modes[Mode]
	if not MathFunc then
		warn(`{Mode} is not a valid math function.`)
		return
	end
	if not VarSet then
		warn(`{VarSet} is not a valid variable.`)
		return
	end
	
	for i = 1, #arguments do
		arguments[i] = tonumber(arguments[i])
	end
	
	local result = MathFunc(arguments)
	VarSet.Value = tostring(result)
end
