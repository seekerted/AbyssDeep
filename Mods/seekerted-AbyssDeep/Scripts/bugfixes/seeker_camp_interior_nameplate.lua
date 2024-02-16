local Utils = require("utils")

Utils.Log("Applying Bugfix: Seeker Camp Interior nameplate now shows Seeker Camp")

local MAP_NO_SEEKER_CAMP_INTERIOR = 16
local SeekerCampName = nil

-- When you enter the Seeker Camp Interior, the label on the upper-left plate now displays "Seeker Camp", much like the
-- behavior for Orth and Belchero Orphanage.
local function WBP_StageSelectMap_C__AnimeIn(Param_WBP_StageSelectMap_C)
	if Utils.GI.PlayMapNo ~= MAP_NO_SEEKER_CAMP_INTERIOR or not SeekerCampName then return end

	Param_WBP_StageSelectMap_C:get().WBP_TitlePlate:SetTitle(FText(SeekerCampName))
end

-- Earliest we can hook where we can get the Seeker Camp name
RegisterInitGameStatePreHook(function(Param_AGameStateBase)
	if SeekerCampName then return end

	local DFL = StaticFindObject("/Script/MadeInAbyss.Default__MIADatabaseFunctionLibrary")
	if not DFL:IsValid() then
		Utils.Log("Could not find MIADatabaseFunctionLibrary")
		return
	end

	-- Reusing FTexts as-is is very tricky. So get the FText as the string, then recreate the FText
	SeekerCampName = DFL:GetMIAMapInfomation(15, 0).Name:ToString()

	RegisterHook("/Game/MadeInAbyss/UI/StageSelect/WBP_StageSelectMap.WBP_StageSelectMap_C:AnimeIn", WBP_StageSelectMap_C__AnimeIn)
end)