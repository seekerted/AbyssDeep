local Bugfix = {}

-- When you enter the Seeker Camp Interior, the label on the upper-left plate should have the name of your last
-- visited location. When you enter from the outside, the name is null ("???") when it should be "Seeker Camp". This
-- fixes that and displays the name correctly.
function Bugfix.FixSeekerCampLabel(WBP_StageSelectMap_C)
	if "???" == WBP_StageSelectMap_C.Title:ToString() then
		local DFL = StaticFindObject("/Script/MadeInAbyss.Default__MIADatabaseFunctionLibrary")

		local SeekerCampName = DFL:GetMIAMapInfomation(15, 0)

		WBP_StageSelectMap_C.WBP_TitlePlate:SetTitle(FText(SeekerCampName.Name:ToString()))
	end
end

return Bugfix