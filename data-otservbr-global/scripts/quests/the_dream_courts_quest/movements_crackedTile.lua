local randomTeleports = {
    Position(32649, 32653, 9),
    Position(32659, 32646, 9)
}

local movements_crackedTile = MoveEvent()

function movements_crackedTile.onStepIn(creature, item, pos, fromPosition)
local player = Player(creature:getId())

    if not creature:isPlayer() then
        return true
    end

    local player = creature:getPlayer()
    local randomPosition = randomTeleports[math.random(#randomTeleports)]
    player:teleportTo(randomPosition, true)
    randomPosition:sendMagicEffect(CONST_ME_GROUNDSHAKER)

local min = player:getMaxHealth() * 0.4
local max = player:getMaxHealth() * 0.5

doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -min, -max)

    return true
end

movements_crackedTile:aid(23106)
movements_crackedTile:register()