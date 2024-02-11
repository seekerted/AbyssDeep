local Utils = require("utils")
local Bugfix = require("bugfix")

Utils.Init("seekerted", "AbyssDeep", "0.5.1")

local F_NerfSpawnRaid = require("f_nerf_spawn_raid")

F_NerfSpawnRaid.SetEnabled(true)

local GI = nil

local MAP_NO_SEEKER_CAMP = 16

-- Called every time an enemy is spawned
local function BP_EnemyCoreLogic_C__OnSpawned(Param_BP_EnemyCoreLogic_C, Param_bIsBeginPlay)
	F_NerfSpawnRaid.OnEnemySpawn(Param_BP_EnemyCoreLogic_C:get())
end

-- Hook into BP_EnemyCoreLogic_C instance (hot-reload friendly)
local function HookBP_EnemyCoreLogic_C(New_BP_EnemyCoreLogic_C)
	if New_BP_EnemyCoreLogic_C:IsValid() then
		-- BP_EnemyCoreLogic_C found
		Utils.RegisterHookOnce("/Game/MadeInAbyss/Core/Characters/Enemy/BP_EnemyCoreLogic.BP_EnemyCoreLogic_C:OnSpawned",
				BP_EnemyCoreLogic_C__OnSpawned)
	else
		-- When new MIAEnemyBase objects are created, only fire if its outer class is PersistentLevel
		NotifyOnNewObject("/Script/MadeInAbyss.MIAEnemyBase", function(New_MIAEnemyBase)
			if New_MIAEnemyBase:IsValid() and "PersistentLevel" == New_MIAEnemyBase:GetOuter():GetFName():ToString() then
				HookBP_EnemyCoreLogic_C(New_MIAEnemyBase)
			end
		end)
	end
end
HookBP_EnemyCoreLogic_C(FindObject("BP_EnemyCoreLogic_C", "PersistentLevel"))

-- Hook into BP_MIAGameInstance_C instance (hot-reload friendly)
local function HookMIAGameInstance(New_MIAGameInstance)
	if New_MIAGameInstance:IsValid() then
		-- MIAGameInstance has been found
		GI = New_MIAGameInstance

		Utils.RegisterHookOnce("/Game/MadeInAbyss/UI/StageSelect/WBP_StageSelectMap.WBP_StageSelectMap_C:SetEventMark",
				function(Param_WBP_StageSelectMap_C)
			if MAP_NO_SEEKER_CAMP == GI.PlayMapNo then
				Bugfix.FixSeekerCampLabel(Param_WBP_StageSelectMap_C:get())
			end
		end)
	else
		NotifyOnNewObject("/Script/MadeInAbyss.MIAGameInstance", HookMIAGameInstance)
	end
end
HookMIAGameInstance(FindFirstOf("MIAGameInstance"))

require("features.nerf_madokajacks")