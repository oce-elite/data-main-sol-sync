local onBossDeath = CreatureEvent("BossLeverOnDeath")

function onBossDeath.onDeath(creature)
    if not creature then return true end

    local name = creature:getName()
    local key = "boss." .. toKey(name)
    local zone = Zone(key)

    if not zone then return true end

    local bossLever = BossLever[name:lower()]
    if not bossLever then return true end

    -- Stop any existing timer
    if bossLever.timeoutEvent then
        stopEvent(bossLever.timeoutEvent)
        bossLever.timeoutEvent = nil
    end

    -- Send leave warning and start room cleanup timer
    if bossLever.timeAfterKill > 0 then
        zone:sendTextMessage(MESSAGE_EVENT_ADVANCE,
            "The " .. name .. " has been defeated. You have " .. bossLever.timeAfterKill .. " seconds to leave the room.")

        local tier = Game.getStorageValue(GlobalStorage.Custom.FiendishBossTier)
        if tier and tier > 0 then
            onDeathForDamagingPlayers(creature, function(_, player)
                grantBossRewards(player, tier)
                player:takeScreenshot(SCREENSHOT_TYPE_BOSSDEFEATED)
            end)
        else
            onDeathForDamagingPlayers(creature, function(_, player)
                player:takeScreenshot(SCREENSHOT_TYPE_BOSSDEFEATED)
            end)
        end

        bossLever.timeoutEvent = addEvent(function(zn)
            zn:refresh()
            zn:removePlayers()
        end, bossLever.timeAfterKill * 1000, zone)
    end

    -- Reward all damaging players with loot
    onDeathForDamagingPlayers(creature, function(_, player)
        player:takeScreenshot(SCREENSHOT_TYPE_BOSSDEFEATED)

        local tier = creature:getStorageValue(GlobalStorage.Custom.FiendishBossTier)
        if tier and tier > 0 then
            grantBossRewards(player, tier, creature)
        end
    end)

    return true
end

onBossDeath:register()
