local supremeCube = Action()

local config = {
    cooldownStorage = 9007,
    categories = {
        { name = "Boss Hubs" },
        { name = "Bosses" },
        { name = "Cities" },
        { name = "House" },
        { name = "Quests" },
        { name = "Special Areas" }
    },
    towns = {
        { name = "Ab'Dendriel", teleport = Position(32732, 31634, 7) },
        { name = "Ankrahmun", teleport = Position(33194, 32853, 8) },
        { name = "Carlin", teleport = Position(32360, 31782, 7) },
        { name = "Darashia", teleport = Position(33213, 32454, 1) },
        { name = "Edron", teleport = Position(33217, 31814, 8) },
        { name = "Farmine", teleport = Position(33023, 31521, 11) },
        { name = "Issavi", teleport = Position(33921, 31477, 5) },
        { name = "Kazordoon", teleport = Position(32649, 31925, 11) },
        { name = "Krailos", teleport = Position(33657, 31665, 8) },
        { name = "Liberty Bay", teleport = Position(32317, 32826, 7) },
        { name = "Marapur", teleport = Position(33842, 32853, 7) },
        { name = "Port Hope", teleport = Position(32594, 32745, 7) },
        { name = "Rathleton", teleport = Position(33594, 31899, 6) },
        { name = "Roshamuul", teleport = Position(33513, 32363, 6) },
        { name = "Svargrond", teleport = Position(32212, 31132, 7) },
        { name = "Thais", teleport = Position(32369, 32241, 7) },
        { name = "Venore", teleport = Position(32957, 32076, 7) },
        { name = "Yalahar", teleport = Position(32787, 31276, 7) }
    },
    bosses = {
        { name = "Ahau", teleport = Position(34035, 31717, 10) },
        { name = "Ascending Ferumbras", teleport = Position(33269, 31475, 14) },
        { name = "Brokul", teleport = Position(33522, 31467, 15) },
        { name = "Dragon Hoard", teleport = Position(33263, 31058, 13) },
        { name = "Dream Courts", teleport = Position(32208, 32035, 13) },
        { name = "Drume", teleport = Position(32458, 32507, 6) },
        { name = "Faceless Bane", teleport = Position(33638, 32560, 13) },
        { name = "Grand Master Oberon", teleport = Position(33364, 31342, 9) },
        { name = "Magma Bubble", teleport = Position(33669, 32932, 15) },
        { name = "Mitmah Vanguard", teleport = Position(34050, 31433, 11) },
        { name = "Ratmiral Blackwhiskers", teleport = Position(33895, 31390, 15) },
        { name = "Ravenous Hunger", teleport = Position(33137, 31950, 15) },
        { name = "Scarlett Etzel", teleport = Position(33395, 32668, 6) },
        { name = "Tentugly's Head", teleport = Position(33795, 31389, 6) },
        { name = "The Monster", teleport = Position(33810, 32587, 12) },
        { name = "The Rootkraken", teleport = Position(32615, 32912, 15) },
        { name = "Timira", teleport = Position(33807, 32699, 8) },
        { name = "Urma", teleport = Position(33920, 31623, 8) }
    },
    quests = {
        { name = "Annihilator", teleport = Position(33213, 31671, 13) },
        { name = "Behemoth", teleport = Position(33296, 31686, 14) },
        { name = "Demon Helmet", teleport = Position(33211, 31639, 13) },
        { name = "Demon Oak", teleport = Position(32816, 32264, 6) },
        { name = "Inquisition", teleport = Position(33190, 31659, 13) },
        { name = "Pits of Inferno", teleport = Position(32835, 32276, 9) },
        { name = "Wrath of the Emperor", teleport = Position(33359, 31398, 9) },
        { name = "Yalahar", teleport = Position(32785, 31191, 8) }
    },
    specialAreas = {
        { name = "Library", teleport = Position(32515, 32539, 12) },
        { name = "Gnomprona", teleport = Position(33517, 32856, 14) },
        { name = "Rotten Blood", teleport = Position(32958, 32398, 9) },
        { name = "Soulwars", teleport = Position(33621, 31426, 10) }
    },
    bossHubs = {
        { name = "Ferumbras Ascension" },
        { name = "Forgotten Knowledge" },
        { name = "Grave Dangers" },
        { name = "Heart of Destruction" },
        { name = "Secret Library" }
    },
    bossHubDetails = {
        ["Ferumbras Ascension"] = {
            { name = "Plagirath", teleport = Position(33230, 31502, 13) },
            { name = "Mazoran", teleport = Position(33594, 32646, 14) },
            { name = "Ragiaz", teleport = Position(33458, 32357, 13) },
            { name = "Razzagorn", teleport = Position(33388, 32456, 14) },
            { name = "Shulgrax", teleport = Position(33435, 32787, 13) },
            { name = "Tarbaz", teleport = Position(33417, 32851, 11) },
            { name = "Zamulosh", teleport = Position(33681, 32743, 11) },
            { name = "Ferumbras Mortal Shell", teleport = Position(33268, 31479, 14) }
        },
        ["Forgotten Knowledge"] = {
            { name = "Lady Tenebris", teleport = Position(32903, 31625, 14) },
            { name = "Lloyd", teleport = Position(32760, 32870, 12) },
            { name = "Melting Frozen Horror", teleport = Position(32303, 31090, 14) },
            { name = "Soul of Dragonking Zyrtarch", teleport = Position(33392, 31180, 10) },
            { name = "Thorn Knight", teleport = Position(32658, 32879, 14) },
            { name = "Time Guardian", teleport = Position(33011, 31662, 14) }
        },
        ["Grave Dangers"] = {
            { name = "Count Vlarkorth", teleport = Position(33457, 31412, 13) },
            { name = "Duke Krule", teleport = Position(33457, 31494, 13) },
            { name = "Earl Osam", teleport = Position(33518, 31443, 13) },
            { name = "Lord Azaram", teleport = Position(33424, 31494, 13) },
            { name = "Sir Nictros", teleport = Position(33426, 31412, 13) },
            { name = "King Zelos", teleport = Position(33487, 31546, 13) }
        },
        ["Heart of Destruction"] = {
            { name = "Anomaly", teleport = Position(32244, 31247, 14) },
            { name = "Eradicator", teleport = Position(32335, 31286, 14) },
            { name = "Outburst", teleport = Position(32206, 31286, 14) },
            { name = "Realityquake", teleport = Position(32181, 31246, 14) },
            { name = "Rupture", teleport = Position(32308, 31250, 14) },
            { name = "The World Devourer", teleport = Position(32272, 31380, 14) }
        },
        ["Secret Library"] = {
            { name = "Ghulosh", teleport = Position(32749, 32772, 10) },
            { name = "Gorzindel", teleport = Position(32749, 32748, 10) },
            { name = "Lokathmor", teleport = Position(32723, 32748, 10) },
            { name = "Mazzinor", teleport = Position(32723, 32772, 10) }
        },
        ["Feaster of Souls"] = {
            { name = "The Unwelcome", teleport = Position(33738, 31536, 14) },
            { name = "The Fear Feaster", teleport = Position(33736, 31470, 14) },
            { name = "The Dread Maiden", teleport = Position(33741, 31505, 14) },
            { name = "The Pale Worm", teleport = Position(33776, 31504, 14) }
        }
    }
}


local function applyCooldown(player)
    if not player then
        return
    end

    local cooldownTime = 60 -- Default cooldown
    if player:isVip() then
        cooldownTime = 30 -- VIP cooldown
    end

    player:setStorageValue(config.cooldownStorage, os.time() + cooldownTime)
end

function openLocationWindow(player, title, locations)
    local window = ModalWindow({ title = title, message = "Select a Destination" })
    for _, location in ipairs(locations) do
        window:addChoice(location.name, function(player, button, choice)
            if button.name == "Select" then
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                player:teleportTo(location.teleport, true)
                player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
                player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Teleported to " .. location.name .. ".")
                applyCooldown(player)
            end
        end)
    end
    window:addButton("Select")
    window:addButton("Close")
    window:sendToPlayer(player)
end

function supremeCube.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    local currentTime = os.time()
    local cooldownTime = player:getStorageValue(config.cooldownStorage) 
    
-- Check cooldown (bypass for gods)
if cooldownTime > currentTime and player:getAccountType() < ACCOUNT_TYPE_GOD then
    player:getPosition():sendMagicEffect(CONST_ME_POFF)
    player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You must wait " .. (cooldownTime - currentTime) .. " seconds before you can use this item.")
    return true
end

    -- Check combat state
    if not player:getTile():hasFlag(TILESTATE_PROTECTIONZONE) and (player:isPzLocked() or player:getCondition(CONDITION_INFIGHT, CONDITIONID_DEFAULT)) then
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can't use this item while you're in a fight.")
        return false
    end
    
    local window = ModalWindow({ title = "Elite Teleport Cube", message = "Select a Category" })
    for _, category in ipairs(config.categories) do
        window:addChoice(category.name, function(player, button, choice)
            if button.name == "Select" then
                if category.name == "House" then
                    local house = player:getHouse()
                    if house then
                        player:teleportTo(house:getExitPosition(), true)
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Welcome to your house.")
                        applyCooldown(player)
                    else
                        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You don't have a house.")
                    end
                elseif category.name == "Boss Hubs" then
                    openBossHubWindow(player)
                elseif category.name == "Cities" then
                    openLocationWindow(player, "Cities", config.towns)
                elseif category.name == "Bosses" then
                    openLocationWindow(player, "Bosses", config.bosses)
                elseif category.name == "Quests" then
                    openLocationWindow(player, "Quests", config.quests)
                elseif category.name == "Special Areas" then
                    openLocationWindow(player, "Special Areas", config.specialAreas)
                end
            end
        end)
    end
    window:addButton("Select")
    window:addButton("Close")
    window:sendToPlayer(player)
    return true
end

function openBossHubWindow(player)
    local window = ModalWindow({ title = "Boss Hubs", message = "Select a Hub" })
    for _, hub in ipairs(config.bossHubs) do
        window:addChoice(hub.name, function(player, button, choice)
            if button.name == "Select" then
                openBossCategoryWindow(player, hub.name)
            end
        end)
    end
    window:addButton("Select")
    window:addButton("Close")
    window:sendToPlayer(player)
end

function openBossCategoryWindow(player, hubName)
    local bosses = config.bossHubDetails[hubName]
    if not bosses then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Invalid selection.")
        return
    end
    openLocationWindow(player, hubName, bosses)
end

supremeCube:id(50358)
supremeCube:register()