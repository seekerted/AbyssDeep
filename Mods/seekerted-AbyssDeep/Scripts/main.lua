local Utils = require("utils")

Utils.Log("Starting MiA:BSFD QOL Mod by Ted the Seeker")
Utils.Log(string.format("Version %s", Utils.ModVer))
Utils.Log(_VERSION)

local F_NerfSpawnRaid = require("f_nerf_spawn_raid")
local F_NerfMadokajacks = require("f_nerf_madokajacks")

F_NerfSpawnRaid.SetEnabled(true)
F_NerfMadokajacks.SetEnabled(true)

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
		NotifyOnNewObject("/Script/MadeInAbyss.MIAEnemyBase", function(NewMIAEnemyBase)
			if NewMIAEnemyBase:IsValid() and "PersistentLevel" == NewMIAEnemyBase:GetOuter():GetFName():ToString() then
				HookBP_EnemyCoreLogic_C(NewMIAEnemyBase)
			end
		end)
	end
end
HookBP_EnemyCoreLogic_C(FindObject("BP_EnemyCoreLogic_C", "PersistentLevel"))

-- Called when a level has been successfully loaded and everything (I think)
local function BP_MIAGameInstance_C__OnSuccess_884D(Param_BP_MIAGameInstance_C)
	F_NerfMadokajacks.OnLevelSuccess(Param_BP_MIAGameInstance_C:get())
end

-- Hook into BP_MIAGameInstance_C instance (hot-reload friendly)
local function HookMIAGameInstance(New_MIAGameInstance)
	if New_MIAGameInstance:IsValid() then
		-- MIAGameInstance has been found
		Utils.RegisterHookOnce("/Game/MadeInAbyss/Core/GameModes/BP_MIAGameInstance.BP_MIAGameInstance_C:OnSuccess_884DEFA44E0E3C73A1DE44B096F9A105",
				BP_MIAGameInstance_C__OnSuccess_884D)
	else
		NotifyOnNewObject("/Script/MadeInAbyss.MIAGameInstance", HookMIAGameInstance)
	end
end
HookMIAGameInstance(FindFirstOf("MIAGameInstance"))