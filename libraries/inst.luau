_G.GLOBAL_LOAF_URIDS = {}
_G.GLOBAL_LOAF_URIDTOPART = {}
local ids = _G.GLOBAL_LOAF_URIDS
local idtopart = _G.GLOBAL_LOAF_URIDTOPART

idtopart["GAME"] = game
idtopart["ROOT"] = game.Workspace
idtopart["PLRS"] = game.Players
idtopart["LIG"] = game.Lighting
idtopart["MATS"] = game.MaterialService
idtopart["REPF"] = game.ReplicatedFirst
idtopart["REPS"] = game.ReplicatedStorage
idtopart["GUI"] = game.StarterGui
idtopart["PACK"] = game.StarterPack
idtopart["PLR"] = game.StarterPlayer
idtopart["TEAM"] = game.Teams
idtopart["SOUN"] = game.SoundService
idtopart["TEXT"] = game.TextChatService

--178890848948005830000000000000 combinations

function CHECK_URID(urid)
	if table.find(ids, urid) then
		return true
	else
		return false
	end
end

function GENERATE_URID()
	local c = false
	local validchars = string.split("qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM1234567890!@#$%^&*()_+=", "")
	
	local function GenChars()
		local f = ""
		for i = 1, 4 do
			f = f .. validchars[math.random(1, #validchars)]
		end
		return f
	end
	
	local urid = ""
	
	repeat
		task.wait()
		for i = 1, 4 do
			if i ~= 4 then
				urid = urid .. GenChars() .. "-"
			else
				urid = urid .. GenChars()
			end
		end
		c = CHECK_URID(urid)
		
	until c == false
	
	table.insert(ids, urid)
	
	return urid
end

function FindEntryByObject(obj)
	for v, i in pairs(idtopart) do
		if i == obj then
			return v
		end
	end
end

--setup tagggssssssuuuhhhhhh
local Everything = workspace:GetDescendants()

for i = 1, #Everything do
	local URID = GENERATE_URID()
	idtopart[URID] = Everything[i]
end

print(idtopart)

return function (thread, arguments)
	if not thread then return end
	
	local modes = {
		addtag = function(a)
			local part = idtopart[a[1]] :: Instance
			local tagname = a[2]
			
			part:AddTag(tagname)

			return "NONE"
		end,
		
		clearallchildren = function(a)
			local part = idtopart[a[1]] :: Instance
			local chil = part:GetChildren()
			
			for i = 1, #chil do
				chil[i]:Destroy()
				if idtopart[chil[i]] then
					idtopart[chil[i]] = nil
				end
			end

			return "NONE"
		end,
		
		clone = function(a)
			local clone = idtopart[a[1]]:Clone()
			local URID = GENERATE_URID()
			idtopart[URID] = clone

			return `{URID}`
		end,
		
		destroy = function(a)
			idtopart[a[1]]:Destroy()
			return "NONE"
		end,
		
		new = function(a)
			local Part = Instance.new(a[1])
			local URID = GENERATE_URID()
			idtopart[URID] = Part
			
			return `{URID}`
		end,
		
		setprop = function(a)
			local part = idtopart[a[1]]
			local propname = a[2]
			local setto = a[3]
			
			if idtopart[setto] then setto = idtopart[setto] end
			
			part[tostring(propname)] = setto
			
			return "NONE"
		end,
		
		getprop = function(a)
			local part = idtopart[a[1]]
			local propname = a[2]
			local propval = part[tostring(propname)]
			if idtopart[propval] then propval = idtopart[propval] end

			return propval
		end,
	}
	
	local mode = arguments[1]
	local setvar = arguments[2]
	if setvar ~= "null" then setvar = thread.Variables:FindFirstChild(setvar) end
	print(setvar)
	
	if not mode then
		warn(`{script.Name} failed to return value: function or var is not valid`)
		return
	end
	
	for i = 1, 2 do
		table.remove(arguments, 1)
	end
	
	local get = modes[mode](arguments)
	if get == "NONE" then
		get = setvar.Value
	end
	if setvar ~= "null" then setvar.Value = get end
end
