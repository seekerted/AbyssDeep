local Utils = {}

local RegisteredHooks = {}

Utils.ModName = "AbyssDeep"
Utils.ModAuthor = "seekerted"
Utils.ModVer = "0.3.6"

function Utils.Log(Msg)
	print(string.format("[%s-%s] %s\n", Utils.ModAuthor, Utils.ModName, Msg))
end

function Utils.RegisterHookOnce(FunctionName, Function)
	if not RegisteredHooks[FunctionName] then
		RegisteredHooks[FunctionName] = true
		RegisterHook(FunctionName, Function)
	end
end

function Utils.TestFunc(FunctionName)
	Utils.RegisterHookOnce(FunctionName, function()
		Utils.Log(string.format("CALLED: %s", FunctionName))
	end)
end

return Utils