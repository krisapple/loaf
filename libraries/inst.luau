return function(thread, arguments)
	if not thread then return end
	
	local modes = {
		--loaf required methods
		["set"] = function(a)
			local Part = a[1] :: Part
			local PropertyName = a[2]
			local SetValue = a[3]
			Part[PropertyName] = SetValue
		end,
		["get"] = function(a)
			local Part = a[1] :: Part
			local PropertyName = a[2]
			return Part[PropertyName]
		end,
		
		--main roblox methods
		["addtag"] = function(a)
			local Part = a[1] :: Part
			local TagName = a[2] :: string
			Part:AddTag(TagName)
		end,
		["clearallchildren"] = function(a)
			local Part = a[1] :: Part
			Part:ClearAllChildren()
		end,
		["clone"] = function(a)
			local Part = a[1] :: Part
			local Part2 = Part:Clone()
			return Part2
		end,
		["destroy"] = function(a)
			local Part = a[1] :: Part
			Part:Destroy()
		end,
		["findfirstancestor"] = function(a)
			local Part = a[1] :: Part
			local AncestorName = a[2] :: Part
			return Part:FindFirstAncestor(AncestorName)
		end,
		["findfirstancestorofclass"] = function(a)
			local Part = a[1] :: Part
			local AncestorName = a[2] :: Part
			return Part:FindFirstAncestorOfClass(AncestorName)
		end,
		["findfirstancestorwhichisa"] = function(a)
			local Part = a[1] :: Part
			local AncestorName = a[2] :: Part
			return Part:FindFirstAncestorWhichIsA(AncestorName)
		end,
		["findfirstchild"] = function(a)
			local Part = a[1] :: Part
			local ChildName = a[2] :: Part
			return Part:FindFirstChild(ChildName)
		end,
		["findfirstchildofclass"] = function(a)
			local Part = a[1] :: Part
			local ChildName = a[2] :: Part
			return Part:FindFirstChildOfClass(ChildName)
		end,
		["findfirstchildwhichisa"] = function(a)
			local Part = a[1] :: Part
			local ChildName = a[2] :: Part
			return Part:FindFirstChildWhichIsA(ChildName)
		end,
		["findfirstdescendant"] = function(a)
			local Part = a[1] :: Part
			local DescendantName = a[2] :: Part
			return Part:FindFirstDescendant(DescendantName)
		end,
		--getactor
		["getattribute"] = function(a)
			local Part = a[1] :: Part
			local Attribute = a[2] :: string
			return Part:GetAttribute(Attribute)
		end,
		--getattributechangedsignal
		--getattributes
		--getchildren
		--getdebugid
		--getdescendants
		["getfullname"] = function(a)
			local Part = a[1] :: Part
			return Part:GetFullName()
		end,
		--getstyled
		--getstyledpropertychangedsignal
		--gettags
		["hastag"] = function(a)
			local Part = a[1] :: Part
			local TagName = a[2]
			return Part:HasTag(TagName)
		end,
		["isancestorof"] = function(a)
			local Part = a[1] :: Part
			local Descendant = a[2]
			return Part:IsAncestorOf(Descendant)
		end,
		["isdescendantof"] = function(a)
			local Part = a[1] :: Part
			local Ancestor = a[2]
			return Part:IsDescendantOf(Ancestor)
		end,
		["ispropertymodified"] = function(a)
			local Part = a[1] :: Part
			local Property = a[2]
			return Part:IsPropertyModified(Property)
		end,
		--querydescendants
		["removetag"] = function(a)
			local Part = a[1] :: Part
			local TagName = a[2]
			return Part:RemoveTag(TagName)
		end,
		["resetpropertytodefault"] = function(a)
			local Part = a[1] :: Part
			local Property = a[2]
			return Part:ResetPropertyToDefault(Property)
		end,
		["setattribute"] = function(a)
			local Part = a[1] :: Part
			local AttributeName = a[2]
			local AttributeValue = a[3]
			return Part:SetAttribute(AttributeName, AttributeValue)
		end,
		["waitforchild"] = function(a)
			local Part = a[1] :: Part
			local ChildName = a[2]
			local TimeOut = a[3]
			return Part:WaitForChild(ChildName, TimeOut)
		end,
	}
	
	local func = modes[arguments[1]]
	
	if func then
		table.remove(arguments, 1)
		local returnval = func(arguments)
		return returnval or nil
	end
	
	return nil
end
