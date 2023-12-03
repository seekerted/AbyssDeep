local Utils = require("utils")

local Mod = {}
local IsEnabled = false

local SpawnFailRate = 0.85

function Mod.SetEnabled(Enabled)
	IsEnabled = Enabled
end

function Mod.OnEnemySpawn(BP_EnemyCoreLogic_C)
	if not IsEnabled then return end

	-- Checks if the enemy was created by a raid spawner. If so, there's a {SpawnFailRate} chance it will be destroyed.
	if BP_EnemyCoreLogic_C.OwnerSpawner:IsA("/Script/MadeInAbyss.MIASpawnRaidEnemy") then
		if math.random() < SpawnFailRate then
			BP_EnemyCoreLogic_C:K2_DestroyActor()
			Utils.Log(string.format("Nerfed enemy raid (%.1f%%)", SpawnFailRate * 100))
		end
	end
end

return Mod