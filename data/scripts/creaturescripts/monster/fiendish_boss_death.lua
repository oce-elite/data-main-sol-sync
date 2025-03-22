local fiendishDeath = CreatureEvent("FiendishBossDeath")

function fiendishDeath.onDeath(creature, corpse)
    if not creature or not creature:isMonster() then return true end

    print("[Stage 1] Reward function called for boss death")

    local tier = creature:getStorageValue(GlobalStorage.Custom.FiendishBossTier)
    if not tier or tier < 1 or tier > 3 then return true end

    print("[Stage 2] Tier is valid, checking players...")

    local players = creature:getDamageMap()
    for playerId, _ in pairs(players) do
        local player = Player(playerId)
        if player then
            print("[Stage 3] Rewarding player: " .. player:getName())
            grantBossRewards(player, tier, creature)
            print("[Stage 4] Rewards granted for " .. player:getName())
        end
    end

    return true
end

fiendishDeath:register()
