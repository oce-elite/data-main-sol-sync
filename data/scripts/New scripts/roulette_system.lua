local config = {
    actionId = 18562, -- on lever

    lever = {
        left = 2772,
        right = 2773
    },

    playItem = {
        itemId = 19082,
        count = 1
    },

    rouletteOptions = {
        ignoredItems = {}, -- if you have tables/counters/other items on the roulette tiles, add them here
        winEffects = {CONST_ANI_FIRE, CONST_ME_SOUND_YELLOW, CONST_ME_SOUND_PURPLE, CONST_ME_SOUND_BLUE, CONST_ME_SOUND_WHITE}, -- first effect needs to be distance effect
        effectDelay = 333,
        spinTime = {min = 8, max = 12}, -- seconds
        spinSlowdownRamping = 5,
        rouletteStorage = "roulette-finishes" -- required storage to avoid player abuse (if they logout/die before roulette finishes.. they can spin again for free)
    },

    prizePool = {
        {itemId = 43875, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Battleaxe
        {itemId = 43865, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Blade
        {itemId = 43873, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Bludgeon
        {itemId = 43878, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Bow
        {itemId = 43883, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Coil
        {itemId = 43880, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Crossbow
        {itemId = 43867, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Cudgel
        {itemId = 43869, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Hatchet
        {itemId = 43871, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Razor
        {itemId = 43886, count = {1, 1},    chance = 1000 }, -- Grand Sanguine Rod
        {itemId = 43874, count = {1, 1},    chance = 2000 }, -- Sanguine Battleaxe
        {itemId = 43864, count = {1, 1},    chance = 2000 }, -- Sanguine Blade
        {itemId = 43872, count = {1, 1},    chance = 2000 }, -- Sanguine Bludgeon
        {itemId = 43884, count = {1, 1},    chance = 2000 }, -- Sanguine Boots
        {itemId = 43877, count = {1, 1},    chance = 2000 }, -- Sanguine Bow
        {itemId = 43882, count = {1, 1},    chance = 2000 }, -- Sanguine Coil
        {itemId = 43879, count = {1, 1},    chance = 2000 }, -- Sanguine Crossbow
        {itemId = 43866, count = {1, 1},    chance = 2000 }, -- Sanguine Cudgel
        {itemId = 43887, count = {1, 1},    chance = 2000 }, -- Sanguine Galoshes
        {itemId = 43881, count = {1, 1},    chance = 2000 }, -- Sanguine Greaves
        {itemId = 43868, count = {1, 1},    chance = 2000 }, -- Sanguine Hatchet
        {itemId = 43876, count = {1, 1},    chance = 2000 }, -- Sanguine Legs
        {itemId = 43870, count = {1, 1},    chance = 2000 }, -- Sanguine Razor
        {itemId = 43885, count = {1, 1},    chance = 2000 }, -- Sanguine Rod
        {itemId = 34091, count = {1, 1},    chance = 5000 }, -- Soulhexer
        {itemId = 34087, count = {1, 1},    chance = 5000 }, -- Soulmaimer
        {itemId = 34095, count = {1, 1},    chance = 5000 }, -- Soulmantle
        {itemId = 34089, count = {1, 1},    chance = 5000 }, -- Soulpiercer
        {itemId = 34092, count = {1, 1},    chance = 5000 }, -- Soulshanks
        {itemId = 34094, count = {1, 1},    chance = 5000 }, -- Soulshell
        {itemId = 34083, count = {1, 1},    chance = 5000 }, -- Soulshredder
        {itemId = 34096, count = {1, 1},    chance = 5000 }, -- Soulshroud
        {itemId = 34093, count = {1, 1},    chance = 5000 }, -- Soulstrider
        {itemId = 34090, count = {1, 1},    chance = 5000 }, -- Soultainter
        {itemId = 34099, count = {1, 1},    chance = 5000 }, -- Soulbastion
        {itemId = 34084, count = {1, 1},    chance = 5000 }, -- Soulbiter
        {itemId = 34088, count = {1, 1},    chance = 5000 }, -- Soulbleeder
        {itemId = 34086, count = {1, 1},    chance = 5000 }, -- Soulcrusher
        {itemId = 34082, count = {1, 1},    chance = 5000 }, -- Soulcutter
        {itemId = 34085, count = {1, 1},    chance = 5000 }, -- Souleater (Axe)
        {itemId = 34097, count = {1, 1},    chance = 5000 }, -- Pair of Soulstalkers
        {itemId = 34098, count = {1, 1},    chance = 5000 }, -- Pair of Soulwalkers
        {itemId = 39147, count = {1, 1},    chance = 2000 }, -- Spiritthorn Armor
        {itemId = 39148, count = {1, 1},    chance = 2000 }, -- Spiritthorn Helmet
        {itemId = 39179, count = {1, 1},    chance = 2000 }, -- Spiritthorn Ring
        {itemId = 39149, count = {1, 1},    chance = 2000 }, -- Alicorn Headguard
        {itemId = 39150, count = {1, 1},    chance = 2000 }, -- Alicorn Quiver
        {itemId = 39182, count = {1, 1},    chance = 2000 }, -- Alicorn Ring
        {itemId = 39152, count = {1, 1},    chance = 2000 }, -- Arcanomancer Folio
        {itemId = 39151, count = {1, 1},    chance = 2000 }, -- Arcanomancer Regalia
        {itemId = 39185, count = {1, 1},    chance = 2000 }, -- Arcanomancer Sigil
        {itemId = 39153, count = {1, 1},    chance = 2000 }, -- Arboreal Crown
        {itemId = 39188, count = {1, 1},    chance = 2000 }, -- Arboreal Ring
        {itemId = 39154, count = {1, 1},    chance = 2000 }, -- Arboreal Tome
        {itemId = 34109, count = {1, 1},    chance = 10000 }, -- Bag You Desire
        {itemId = 43895, count = {1, 1},    chance = 5000 }, -- Bag You Covet
        {itemId = 39546, count = {1, 1},    chance = 5000 }  -- Primal Bag
        
    },

    roulettePositions = {
        Position({x = 32353, y = 32218, z = 6}),
        Position({x = 32354, y = 32218, z = 6}),
        Position({x = 32355, y = 32218, z = 6}),
        Position({x = 32356, y = 32218, z = 6}),
        Position({x = 32357, y = 32218, z = 6}), -- position 11 in this list is hard-coded to be the reward location, which is the item given to the player
        Position({x = 32358, y = 32218, z = 6}),
        Position({x = 32359, y = 32218, z = 6}),
        Position({x = 32360, y = 32218, z = 6}),
        Position({x = 32361, y = 32218, z = 6}),
    }
}

local chancedItems = {}

local function resetLever(position)
    local lever = Tile(position):getItemById(config.lever.right)
    lever:transform(config.lever.left)
end

local function updateRoulette(newItemInfo)
    local positions = config.roulettePositions
    for i = #positions, 1, -1 do
        local item = Tile(positions[i]):getTopVisibleThing()
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then
            if i ~= 9 then
                item:moveTo(positions[i + 1])
            else
                item:remove()
            end
        end
    end

    if ItemType(newItemInfo.itemId):getCharges() then
        local item = Game.createItem(newItemInfo.itemId, 1, positions[1])
    --    item:setAttribute(ITEM_ATTRIBUTE_CHARGES, newItemInfo.count)
    else
        Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[1])
    end
end

local function clearRoulette(newItemInfo)
    local positions = config.roulettePositions
    for i = #positions, 1, -1 do
        local item = Tile(positions[i]):getTopVisibleThing()
        if item and item:getId() ~= Tile(positions[i]):getGround():getId() and not table.contains(config.rouletteOptions.ignoredItems, item:getId()) then
            item:remove()
        end

        if newItemInfo == nil then
            positions[i]:sendMagicEffect(CONST_ME_POFF)
        else
            if ItemType(newItemInfo.itemId):getCharges() then
                local item = Game.createItem(newItemInfo.itemId, 1, positions[i])
         --       item:setAttribute(ITEM_ATTRIBUTE_CHARGES, newItemInfo.count)
            else
                Game.createItem(newItemInfo.itemId, newItemInfo.count, positions[i])
            end
        end
    end
end

local function chanceNewReward()
    local newItemInfo = {itemId = 0, count = 0}
    local rewardTable = {}
    while #rewardTable < 1 do
        for i = 1, #config.prizePool do
            if config.prizePool[i].chance >= math.random(10000) then
                rewardTable[#rewardTable + 1] = i
            end
        end
    end

    local rand = math.random(#rewardTable)
    newItemInfo.itemId = config.prizePool[rewardTable[rand]].itemId
    newItemInfo.count = math.random(config.prizePool[rewardTable[rand]].count[1], config.prizePool[rewardTable[rand]].count[2])
    chancedItems[#chancedItems + 1] = config.prizePool[rewardTable[rand]].chance
    return newItemInfo
end

local function initiateReward(leverPosition, effectCounter)
    if effectCounter < #config.rouletteOptions.winEffects then
        effectCounter = effectCounter + 1
        if effectCounter == 1 then
            config.roulettePositions[1]:sendDistanceEffect(config.roulettePositions[4], config.rouletteOptions.winEffects[1])
            config.roulettePositions[7]:sendDistanceEffect(config.roulettePositions[4], config.rouletteOptions.winEffects[1])
        else
            for i = 1, #config.roulettePositions do
                config.roulettePositions[i]:sendMagicEffect(config.rouletteOptions.winEffects[effectCounter])
            end
        end

        if effectCounter == 2 then
            local item = Tile(config.roulettePositions[6]):getTopVisibleThing()
            local newItemInfo = {itemId = item:getId(), count = item:getCount()}
            clearRoulette(newItemInfo)
        end

        addEvent(initiateReward, config.rouletteOptions.effectDelay, leverPosition, effectCounter)
        return
    end

    resetLever(leverPosition)
end

local function rewardPlayer(playerId, leverPosition)
    local player = Player(playerId)
    if not player then
        return
    end

    local item = Tile(config.roulettePositions[6]):getTopVisibleThing()
    local inbox = player:getInbox()
    if inbox then
        local addedItem = inbox:addItem(item:getId(), 1, INDEX_WHEREEVER, FLAG_NOLIMIT)
        if addedItem and ItemType(item:getId()):getCharges() then
     --       addedItem:setAttribute(ITEM_ATTRIBUTE_CHARGES, item:getCharges())
        end
    end

    player:sendTextMessage(MESSAGE_STATUS, "Congratulations! You have won " .. item:getName() .. ". The item has been sent to your inbox.")
    player:kv():set(config.rouletteOptions.rouletteStorage, -1)
    player:setMoveLocked(false)
    Game.broadcastMessage("The player " .. player:getName() .. " has won " .. item:getName() .. " from the roulette!", MESSAGE_EVENT_ADVANCE)
end

local function roulette(playerId, leverPosition, spinTimeRemaining, spinDelay)
    local player = Player(playerId)
    if not player then
        resetLever(leverPosition)
        return
    end

    local newItemInfo = chanceNewReward()
    updateRoulette(newItemInfo)

    if spinTimeRemaining > 0 then
        spinDelay = spinDelay + config.rouletteOptions.spinSlowdownRamping
        addEvent(roulette, spinDelay, playerId, leverPosition, spinTimeRemaining - (spinDelay - config.rouletteOptions.spinSlowdownRamping), spinDelay)
        return
    end

    initiateReward(leverPosition, 0)
    rewardPlayer(playerId, leverPosition)
end

local casinoRoulette = Action()

function casinoRoulette.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    if item:getId() == config.lever.right then
        player:sendTextMessage(MESSAGE_FAILURE, "Casino Roulette is currently in progress. Please wait.")
        return true
    end

    if player:getItemCount(config.playItem.itemId) < config.playItem.count then
        if player:kv():get(config.rouletteOptions.rouletteStorage) < 1 then
            player:sendTextMessage(MESSAGE_FAILURE, "Casino Roulette requires " .. config.playItem.count .. " " .. (ItemType(config.playItem.itemId):getName()) .. " to use.")
            return true
        end
    end

    item:transform(config.lever.right)
    clearRoulette()
    chancedItems = {}

    player:removeItem(config.playItem.itemId, config.playItem.count)
    player:kv():set(config.rouletteOptions.rouletteStorage, 1)
    player:setMoveLocked(true)

    local spinTimeRemaining = math.random((config.rouletteOptions.spinTime.min * 1000), (config.rouletteOptions.spinTime.max * 1000))
    roulette(player:getId(), toPosition, spinTimeRemaining, 100)
    return true
end

casinoRoulette:aid(config.actionId)
casinoRoulette:register()


local rouletteLogout = CreatureEvent("Roulette Logout")

function rouletteLogout.onLogout(player)
    if player:kv():get(config.rouletteOptions.rouletteStorage) == 1 then
        player:sendTextMessage(MESSAGE_FAILURE, "You cannot disconnect while using roulette!")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
    return true
end

rouletteLogout:register()