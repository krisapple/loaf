--!strict

--Basic Loaf Format
--okeaoss 10/4/25

local blf = {}

function ReformString(t)
	local f = ""
	for i = 1, #t do
		f = `{f}{t[i]}`
	end
	return f
end

function blf:Format(str)
	--Line split fix
	local LineSplitFix = string.split(str)
	if LineSplitFix[#LineSplitFix] ~= "%" then
		table.insert(LineSplitFix, " %")
	end
	str = ReformString(LineSplitFix)
	
	local List = string.split(str, "%")
	local Final = ""
	
	for v = 1, #List do
		local words = string.split(List[v], " ")
		local FinalList = "("
		
		for i = 1, #words do
			local word = words[i]
			
			if word == "" then continue end
			string.gsub(word, " ", "")
			
			FinalList = `{FinalList}{word}/`
		end
		
		--check for blank lines
		if FinalList == "(" then continue end
		
		--check end of list for an accidental slash
		local SlashCheck = string.split(FinalList, "")
		
		if SlashCheck[#SlashCheck] == "/" then
			table.remove(SlashCheck, #SlashCheck)
		end
		
		FinalList = ReformString(SlashCheck)
		FinalList = `{FinalList})`
		
		if v ~= #List then
			FinalList = `{FinalList}&`
		end
		
		Final = `{Final}{FinalList}`
	end
	
	--Add version and system data
	local Data = "dat:["
	Data = `{Data}BLF;`
	Data = `{Data}loaf;`
	Data = `{Data}2`
	Data = `{Data}]`
	
	Final = `{Final}{Data}`
	
	--Add format tag
	Final = `{Final}#`
	
	return Final
end

return blf
