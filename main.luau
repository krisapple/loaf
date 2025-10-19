local Compression = script.Parent.compression
local Formatting = script.Parent.formatting

local c_ASCII85 = require(Compression.Ascii85)
local c_LZW = require(Compression.LZW)
local f_BLF = require(Formatting.BLF)

function ReformString(t)
	local f = ""
	for i = 1, #t do
		f = `{f}{t[i]}`
	end
	return f
end

function DebugPrint(msg)
	if _ENABLE_DEBUG_ then
		warn(`LOAF DEBUG : {msg}`)
	end
end

--SETTINGS
_ENABLE_DEBUG_ = false --Enables printing and debug features.

--INIT
warn("Initializing libraries.")
local Libs = script.Parent.libraries:GetChildren()
for i = 1, #Libs do
	warn(`Initializing library "{Libs[i].Name}"`)
	local l = require(Libs[i])
	l()
end
warn("Finished")

local main = {}

main.compression = {}

main.compression.compress = function(str)
	str = c_LZW:Compress(str)
	
	DebugPrint("Compression finished.")
	DebugPrint(str)
	
	return str
end
	
main.compression.decompress = function(str)
	str = c_LZW:Decompress(str)
	
	DebugPrint("Decompression finished.")
	DebugPrint(str)
	
	return str
end

main.formatting = {}

main.formatting.format = function(str)
	str = f_BLF:Format(str)
	
	DebugPrint("Formatting finished.")
	DebugPrint(str)
	
	return str
end

main.execution = {}

main.execution.new_thread = function()
	DebugPrint("Creating new thread.")

	local thread = Instance.new("Folder")
	thread.Name = "LoafThread"
	thread.Parent = script.Parent.runtime.threads
	
	local variables = Instance.new("Folder")
	variables.Name = "Variables"
	variables.Parent = thread
	
	return thread
end

local LuauTypeConversions = {
	bool = function(a)
		if a[1] == "true" then return true end
		if a[1] == "false" then return false end
		return "null"
	end,
	
	cf = function(a)
		if not a[1] or not a[2] or not a[3] then return "null" end
		return CFrame.new(a[1], a[2], a[3])
	end,
	
	vec3 = function(a)
		if not a[1] or not a[2] or not a[3] then return "null" end
		return Vector3.new(a[1], a[2], a[3])
	end,
	
	vec2 = function(a)
		if not a[1] or not a[2] then return "null" end
		return Vector2.new(a[1], a[2])
	end,
	
	udim2 = function(a)
		if not a[1] or not a[2] or not a[3] or not a[4] then return "null" end
		return UDim2.new(a[1], a[2], a[3], a[4])
	end,
	
	udim = function(a)
		if not a[1] or not a[2] then return "null" end
		return UDim.new(a[1], a[2])
	end,
	
	col3 = function(a)
		if not a[1] or not a[2] or not a[3] then return "null" end
		return Color3.new(a[1], a[2], a[3])
	end,
}

main.run = function(str, thread: Folder)
	DebugPrint("Running thread.")
	
	--Check if the given string is formatted
	local FormatCheck = string.split(str, "")
	if FormatCheck[#FormatCheck] ~= "#" then
		DebugPrint("Performing decompression format tag check.")
		
		--If no format tag, check if the string is compiled
		local Success, FailMessage = pcall(main.compression.decompress, str)
		if not Success then
			error("Given string is not formatted, please format and try again.")
		end
		
		local Decomp = main.compression.decompress(str)
		local DecompFormatCheck = string.split(Decomp, "")
		
		if DecompFormatCheck[#DecompFormatCheck] ~= "#" then
			error("Given string is not formatted, please format and try again.")
		else
			str = Decomp
		end
	end
	
	--Begin running process
	local Lines = string.split(str, "&")
	table.remove(Lines, #Lines)
	
	for v = 1, #Lines do
		local FixParenthesis = string.split(Lines[v], "")
		table.remove(FixParenthesis, 1)
		table.remove(FixParenthesis, #FixParenthesis)
		FixParenthesis = ReformString(FixParenthesis)
		
		local Words = string.split(FixParenthesis, "/")
		
		for i = 1, #Words do
			local split = string.split(Words[i], "")
			
			--Check for declarations
			if split[1] == "<" then
				local double = `{split[2]}{split[3]}`
				local declarable = ""
				
				for k = 1, #split do
					if k <= 4 then continue end
					declarable = `{declarable}{split[k]}`
				end
				
				if double == "vv" then
					local var = thread.Variables:FindFirstChild(declarable)
					if var then
						Words[i] = var.Value
					else
						warn(declarable .. " is not a valid variable for declarable.")
						Words[i] = "nil"
					end
				end
			end
			
			--Check for luau type conversions
			if split[1] == "?" then
				local Full = Words[i]
				local GetLuauTypeConvert = ""
				local index = 1
				
				repeat
					index+=1
					if split[index] == "?" then continue end
					GetLuauTypeConvert = `{GetLuauTypeConvert}{split[index]}`
				until split[index] == "?"
				
				for i = 1, 2+string.len(GetLuauTypeConvert) do
					table.remove(split, 1)
				end
				
				local Val = ReformString(split)
				local Vals = string.split(Val, ";")
				Val = LuauTypeConversions[GetLuauTypeConvert](Vals)
				
				Words[i] = Val
			end
		end
		
		local Command = Words[1]
		local Arguments = {}
		
		for i = 1, #Words do
			if i == 1 then continue end
			table.insert(Arguments, Words[i])
		end
		
		local Library = script.Parent.libraries:FindFirstChild(Command)
		if not Library then
			warn(Command .. " is not a valid library. Skipping line.")
			continue
		end
		
		Library = require(Library)
		Library(thread, Arguments)
	end
end

return main
