local Utils = require("utils")

Utils.Init("seekerted", "AbyssDeep", "0.5.2")

local F_NerfSpawnRaid = require("f_nerf_spawn_raid")

F_NerfSpawnRaid.SetEnabled(true)

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

require("features.nerf_madokajacks")

require("bugfixes.seeker_camp_interior_nameplate")