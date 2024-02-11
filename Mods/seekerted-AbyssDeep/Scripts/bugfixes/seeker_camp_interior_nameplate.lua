local Utils = require("utils")

Utils.Log("Applying Bugfix: Seeker Camp Interior nameplate no longer shows ??? when entering from the outside")

local MAP_NO_SEEKER_CAMP_INTERIOR = 16

-- When you enter the Seeker Camp Interior, the label on the upper-left plate should have the name of your last
-- visited location. When you enter from the outside, the name is null ("???") when it should be "Seeker Camp". This
-- fixes that and displays the name correctly
local function BP_MIAGameInstance_C__OnSuccess_084D(Param_BP_MIAGameInstance_C)
	if MAP_NO_SEEKER_CAMP_INTERIOR ~= Param_BP_MIAGameInstance_C:get().PlayMapNo then return end

	local WBP_StageSelectMap_C = FindFirstOf("WBP_StageSelectMap_C")
	if WBP_StageSelectMap_C:IsValid() then
		if "???" == WBP_StageSelectMap_C.Title:ToString() then
			local DFL = StaticFindObject("/Script/MadeInAbyss.Default__MIADatabaseFunctionLibrary")
			if not DFL:IsValid() then
				Utils.Log("Could not find MIADatabaseFunctionLibrary")
				return
			end

			local SeekerCampName = DFL:GetMIAMapInfomation(15, 0)

			-- Reusing FTexts as-is is very tricky. So get the FText as the string, then recreate the FText
			WBP_StageSelectMap_C.WBP_TitlePlate:SetTitle(FText(SeekerCampName.Name:ToString()))
		end
	end
end

-- Hook into BP_MIAGameInstance_C instance (hot-reload friendly)
local function HookMIAGameInstance(New_MIAGameInstance)
	if New_MIAGameInstance:IsValid() then
		-- MIAGameInstance has been found

		RegisterHook("/Game/MadeInAbyss/Core/GameModes/BP_MIAGameInstance.BP_MIAGameInstance_C:OnSuccess_084D74CC438019371E505798B67750BF",
				BP_MIAGameInstance_C__OnSuccess_084D)
	else
		NotifyOnNewObject("/Script/MadeInAbyss.MIAGameInstance", HookMIAGameInstance)
	end
end
HookMIAGameInstance(FindFirstOf("MIAGameInstance"))