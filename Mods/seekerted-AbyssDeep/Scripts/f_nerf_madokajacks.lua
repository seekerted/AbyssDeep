local Utils = require("utils")

local Mod = {}
local IsEnabled = false

local AP_Madokajaku = "AP_Madokajaku_"

function Mod.SetEnabled(Enabled)
	IsEnabled = Enabled
end

function Mod.OnLevelSuccess(BP_MIAGameInstance_C)
	if not IsEnabled then return end

	-- Get all TP_AttackPoint_C's related to Madokajacks, and disable collision.
	local TP_AttackPoint_Cs = FindAllOf("TP_AttackPoint_C")
	if TP_AttackPoint_Cs then
		for _, TP_AttackPoint_C in pairs(TP_AttackPoint_Cs) do
			if TP_AttackPoint_C:GetFName():ToString():sub(1, #AP_Madokajaku) == AP_Madokajaku then
				TP_AttackPoint_C.SetActorEnableCollision(false)
			end
		end
	end
end

return Mod