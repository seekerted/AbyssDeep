local Utils = require("utils")

Utils.Log("Enabled Feature: Nerf Madokajacks")

-- The Great Fault, Trapped Pirate Ship, Quadruple Pit, and Rock Slide Hall
local MAPS_WITH_MADOKAJACKS = {21, 22, 25, 28}

-- The speed at which the Madokajacks will fly towards you when attacking. Originally at 914.068970
local MADOKAJACK_ATTACK_SPEED = 630

local HasHooked = false

-- Called when the Madokajack AI Behavior Tree switches to attacking the player (BTTask_FlyingRail_C)
local function BTTask_FlyingRail_C__ReceiveExecuteAI(Param_BTTask_FlyingRail_C, Param_OwnerController, Param_ControlledPawn)
	local BTTask_FlyingRail_C = Param_BTTask_FlyingRail_C:get()

	-- Rotation Rate seems to be how much a Madokajack can turn while flying towards you when attacking
	BTTask_FlyingRail_C.RotationRate = 0
	BTTask_FlyingRail_C.Speed = MADOKAJACK_ATTACK_SPEED
end

local function DoesMapHaveMadokajack(MapNo)
	for _, v in ipairs(MAPS_WITH_MADOKAJACKS) do
		if v == MapNo then
			return true
		end
	end

	return false
end

-- Apply hook to the Madokajack's AI only when in a map with Madokajacks and if we haven't hooked yet.
-- This is because the BTTask_FlyingRail_C isn't really available until then.
local function BP_MIAGameInstance_C__OnSuccess_A025(Param_BP_MIAGameInstance_C)
	if not HasHooked and DoesMapHaveMadokajack(Param_BP_MIAGameInstance_C:get().PlayMapNo) then
		Utils.Log("Applying hook to BTTask_FlyingRail_C:ReceiveExecuteAI()")

		RegisterHook("/Game/MadeInAbyss/Enemies/1160Onituchibashi/AI/BTTask_FlyingRail.BTTask_FlyingRail_C:ReceiveExecuteAI",
				BTTask_FlyingRail_C__ReceiveExecuteAI)

		HasHooked = true
	end
end

-- Hook into BP_MIAGameInstance_C instance (hot-reload friendly)
local function HookMIAGameInstance(New_MIAGameInstance)
	if New_MIAGameInstance:IsValid() then
		-- MIAGameInstance has been found

		RegisterHook("/Game/MadeInAbyss/Core/GameModes/BP_MIAGameInstance.BP_MIAGameInstance_C:OnSuccess_A02554634B6C75B4B65022A3C3C5C24D",
				BP_MIAGameInstance_C__OnSuccess_A025)
	else
		NotifyOnNewObject("/Script/MadeInAbyss.MIAGameInstance", HookMIAGameInstance)
	end
end
HookMIAGameInstance(FindFirstOf("BP_MIAGameInstance_C"))