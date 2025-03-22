local function kamehameha(cid)
    local creature = Creature(cid)
    if not creature then
        return
    end

    local direction = creature:getDirection()
    local creaturePos = creature:getPosition()
    
    local positions = {}
    for i = 1, 13 do
        creaturePos:getNextPosition(direction)
        local tile = creaturePos:getTile()
        if not (tile == nil or tile:getGround() == nil or tile:hasProperty(TILESTATE_NONE) or Item(tile:getThing()) and not isMoveable(tile:getThing()) or tile:hasFlag(TILESTATE_PROTECTIONZONE) or (tile:getTopVisibleThing() and tile:getTopVisibleThing():isTeleport())) then
            table.insert(positions, Position(creaturePos.x, creaturePos.y, creaturePos.z))
            if i ~= 1 then
                if direction == DIRECTION_NORTH or direction == DIRECTION_SOUTH then
                    table.insert(positions, Position(creaturePos.x + 1, creaturePos.y, creaturePos.z))
                    table.insert(positions, Position(creaturePos.x - 1, creaturePos.y, creaturePos.z))
                else
                    table.insert(positions, Position(creaturePos.x, creaturePos.y + 1, creaturePos.z))
                    table.insert(positions, Position(creaturePos.x, creaturePos.y - 1, creaturePos.z))
                end
            end
        else
            break
        end
    end


    creature:getPosition():sendDistanceEffect(creaturePos, 36)
    for _, pos in pairs(positions) do
        addEvent(function ()
            pos:sendMagicEffect(CONST_ME_YELLOWENERGY)
            pos:sendMagicEffect(249)
            local player = Tile(pos):getTopCreature()
            if not player or creature == player then
                return
            end

            doTargetCombatHealth(0, player, COMBAT_PHYSICALDAMAGE, -(player:getMaxHealth() * 0.5), -(player:getMaxHealth() * 0.7), CONST_ME_NONE)
        end, 45 * _)
    end
end

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
    local cid = creature:getId()
    for i = 1, 5 do
        addEvent(function ()
            local creature = Creature(cid)
            if not creature then
                return
            end

            if i == 1 then
                creature:say("Ka")
            elseif i == 2 then
                creature:say("Me")
            elseif i == 3 then
                creature:say("Ha")
            elseif i == 4 then
                creature:say("Me")
            elseif i == 5 then
                creature:say("Haaaaaaaaaaa")
            end
            
            local direction = creature:getDirection()
            local creaturePos = creature:getPosition()
            creaturePos:getNextPosition(direction)
            creaturePos:sendMagicEffect(CONST_ME_TELEPORT)
            if i == 5 then
                addEvent(kamehameha, 100, cid)
            end
        end, 400 * i)
    end
    return false
end

spell:name("kamehameha")
spell:words("###kamehameha")
spell:isAggressive(false)
spell:vocation("god;true")
spell:blockWalls(true)
spell:needLearn(true)
spell:needDirection(false)
spell:register()