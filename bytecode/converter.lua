-- local toolbar = plugin:CreateToolbar("Object To Lua")
-- local button = toolbar:CreateButton("Object To Lua", "Convert an object to Lua code", "rbxassetid://1894847915")

local API = loadstring(game:HttpGet("https://raw.githubusercontent.com/1337-svg/Liquid_Mix_Terminal/gg/oneclan/bytecode/api.lua"))()
local apiFetched = false; local PropertyToString = require(loadstring(game:HttpGet("https://raw.githubusercontent.com/1337-svg/Liquid_Mix_Terminal/gg/oneclan/bytecode/properties.lua"))())
function ConvertToLua(mmXodel)
	local selectedItem = mmXodel
	assert(selectedItem.Parent ~= game, "Selected item cannot be at service-level. Please select item within service (e.g. a model inside Workspace)")
	
	local awaitReference = {}
	
	-- Fetch API if needed:
	if (not apiFetched) then
		apiFetched = true
		local success, returnVal = pcall(function()
			return API:Fetch()
		end)
		if ((not success) or (not returnVal)) then
			apiFetched = false
			return
		end
	end
	
	local defaultObjects = {}
	setmetatable(defaultObjects, {
		__index = function(self, index)
			local obj = Instance.new(index)
			rawset(defaultObjects, index, obj)
			return obj
		end;
	})
	
	local codeBuilder = {}
	codeBuilder[#codeBuilder + 1] = "\local partsWithId = {}\
local awaitRef = {}\
\
local root = "
	
	local ref = {}
	local idCount = 0
	
	local objectIds = {}
	
	local function GetProperties(obj)
		local properties = {}
		local default = defaultObjects[obj.ClassName]
		local class = API.ClassesByName[obj.ClassName]
		for propName,propInfo in pairs(class:GetAllProperties(true)) do
			if ((not propInfo.ReadOnly) and (not propInfo.Hidden) and propName ~= "Parent") then
				local val = obj[propName]
				if (default[propName] ~= val) then
					local valStr, isRef = PropertyToString(propInfo.ValueType, val, propName)
					if (isRef) then
						properties[propName] = ("\"_R:%s_\""):format(objectIds[val] or "E")
					else
						properties[propName] = valStr
					end
				end
			end
		end
		return properties
	end
	
	local function Scan(obj, indentLvl)
		local indent = ("\t"):rep(indentLvl)
		if (indentLvl ~= 0) then
			codeBuilder[#codeBuilder + 1] = "\n" .. indent
		end
		codeBuilder[#codeBuilder + 1] = "{\n" .. indent .. "\tID = " .. objectIds[obj] .. ";\n" .. indent .. "\tType = \"" .. obj.ClassName .. "\";\n" .. indent .. "\tProperties = {"
		local props = GetProperties(obj)
		if (next(props)) then
			for propName,propVal in pairs(props) do
				codeBuilder[#codeBuilder + 1] = "\n" .. indent .. "\t\t" .. propName .. " = " .. propVal .. ";"
			end
			codeBuilder[#codeBuilder + 1] = "\n" .. indent .. "\t};"
		else
			codeBuilder[#codeBuilder + 1] = "};"
		end
		local children = obj:GetChildren()
		if (#children > 0) then
			codeBuilder[#codeBuilder + 1] = "\n" .. indent .. "\tChildren = {"
			for _,child in pairs(children) do
				Scan(child, indentLvl + 2)
			end
			codeBuilder[#codeBuilder + 1] = "\n" .. indent .. "\t};\n" .. indent .. "};"
		else
			codeBuilder[#codeBuilder + 1] = "\n" .. indent .. "\tChildren = {};\n" .. indent .. "};"
		end
	end
	
	objectIds[selectedItem] = idCount
	for _,v in pairs(selectedItem:GetDescendants()) do
		idCount = (idCount + 1)
		objectIds[v] = idCount
	end
	
	Scan(selectedItem, 0)
	
	codeBuilder[#codeBuilder + 1] = "\n\
local function Scan(item, parent)\
	local obj = Instance.new(item.Type)\
	if (item.ID) then\
		local awaiting = awaitRef[item.ID]\
		if (awaiting) then\
			awaiting[1][awaiting[2]] = obj\
			awaitRef[item.ID] = nil\
		else\
			partsWithId[item.ID] = obj\
		end\
	end\
	for p,v in pairs(item.Properties) do\
		if (type(v) == \"string\") then\
			local id = tonumber(v:match(\"^_R:(%w+)_$\"))\
			if (id) then\
				if (partsWithId[id]) then\
					v = partsWithId[id]\
				else\
					awaitRef[id] = {obj, p}\
					v = nil\
				end\
			end\
		end\
		obj[p] = v\
	end\
	for _,c in pairs(item.Children) do\
		Scan(c, obj)\
	end\
	obj.Parent = parent\
	return obj\
end\
\
return function() return Scan(root, nil) end"
	
	local source = table.concat(codeBuilder, "")
	local ms = Instance.new("ModuleScript")
	ms.Name = selectedItem.Name:gsub("%s+", "") .. "ToLua"
	ms.Source = source
	ms.Parent = selectedItem.Parent
	game.Selection:Set{ms}
	
end
