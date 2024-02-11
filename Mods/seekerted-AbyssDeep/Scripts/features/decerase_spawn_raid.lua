local Utils = require("utils")

Utils.Log("Enabled Feature: Decrease spawn raid")

local SpawnFailRate = 0.85

-- Called every time an enemy is spawned
local function BP_EnemyCoreLogic_C__OnSpawned(Param_BP_EnemyCoreLogic_C, Param_bIsBeginPlay)
	local BP_EnemyCoreLogic_C = Param_BP_EnemyCoreLogic_C:get()

	-- Checks if the enemy was created by a raid spawner. If so, there's a {SpawnFailRate} chance it will be destroyed.
	if BP_EnemyCoreLogic_C.OwnerSpawner:IsA("/Script/MadeInAbyss.MIASpawnRaidEnemy") then
		if math.random() < SpawnFailRate then
			BP_EnemyCoreLogic_C:K2_DestroyActor()
			Utils.Log(string.format("Nerfed enemy raid (%.1f%%)", SpawnFailRate * 100))
		end
	end
end

-- Hook into BP_EnemyCoreLogic_C instance (hot-reload friendly)
local function HookBP_EnemyCoreLogic_C(New_BP_EnemyCoreLogic_C)
	if New_BP_EnemyCoreLogic_C:IsValid() then
		-- BP_EnemyCoreLogic_C found

		RegisterHook("/Game/MadeInAbyss/Core/Characters/Enemy/BP_EnemyCoreLogic.BP_EnemyCoreLogic_C:OnSpawned", BP_EnemyCoreLogic_C__OnSpawned)
	else
		NotifyOnNewObject("/Script/MadeInAbyss.MIAEnemyBase", HookBP_EnemyCoreLogic_C)
	end
end
HookBP_EnemyCoreLogic_C(FindObject("BP_EnemyCoreLogic_C", "PersistentLevel"))