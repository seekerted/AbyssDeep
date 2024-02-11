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

-- Hook into BP_MIAGameInstance_C instance (hot-reload friendly)
local function HookMIAGameInstance(New_MIAGameInstance)
	if New_MIAGameInstance:IsValid() then
		-- MIAGameInstance has been found

		if not HasHooked and DoesMapHaveMadokajack(New_MIAGameInstance.PlayMapNo) then
			RegisterHook("/Game/MadeInAbyss/Enemies/1160Onituchibashi/AI/BTTask_FlyingRail.BTTask_FlyingRail_C:ReceiveExecuteAI",
					BTTask_FlyingRail_C__ReceiveExecuteAI)

			HasHooked = true
		end
	else
		NotifyOnNewObject("/Script/MadeInAbyss.MIAGameInstance", HookMIAGameInstance)
	end
end
HookMIAGameInstance(FindFirstOf("BP_MIAGameInstance_C"))