local internalNpcName = "Imbuement Assistant"
local npcType = Game.createNpcType(internalNpcName)
local npcConfig = {}

npcConfig.name = internalNpcName
npcConfig.description = internalNpcName

npcConfig.health = 100
npcConfig.maxHealth = npcConfig.health
npcConfig.walkInterval = 2000
npcConfig.walkRadius = 2

npcConfig.outfit = {
	lookType = 141,
	lookHead = 41,
	lookBody = 72,
	lookLegs = 39,
	lookFeet = 96,
	lookAddons = 3,
	lookMount = 688,
}

npcConfig.flags = {
	floorchange = false,
}

npcConfig.voices = {
	interval = 15000,
	chance = 50,
	{ text = "Hello adventurer, looking for Imbuement items? Just ask me!" },
}

local playerImbuementData = {}

local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)

npcType.onThink = function(npc, interval)
	npcHandler:onThink(npc, interval)
end

npcType.onAppear = function(npc, creature)
	npcHandler:onAppear(npc, creature)
end

npcType.onDisappear = function(npc, creature)
	npcHandler:onDisappear(npc, creature)
end

npcType.onMove = function(npc, creature, fromPosition, toPosition)
	npcHandler:onMove(npc, creature, fromPosition, toPosition)
end

npcType.onSay = function(npc, creature, type, message)
	npcHandler:onSay(npc, creature, type, message)
end

npcType.onCloseChannel = function(npc, creature)
	npcHandler:onCloseChannel(npc, creature)
	playerImbuementData[creature:getId()] = nil
end

function addItemsToShoppingBag(npc, player)
	local playerId = player:getId()
	local playerData = playerImbuementData[playerId]

	if playerData then
		local moneyRequired = playerData.moneyRequired
		local itemList = playerData.itemList
		if player:getMoney() + player:getBankBalance() < moneyRequired then
			npcHandler:say("Sorry, you don't have enough money", npc, player)
			npcHandler:setTopic(player:getId(), 0)
			return false, "You don't have enough money."
		end

		local totalWeight = 0
		for _, item in pairs(itemList) do
			local itemType = ItemType(item.itemId)
			totalWeight = totalWeight + (itemType:getWeight() * item.count)
		end

		if player:getFreeCapacity() < totalWeight then
			return false, "You don't have enough weight."
		end

		if player:getFreeBackpackSlots() == 0 then
			return false, "You don't have enough room."
		end

		local shoppingBag = player:addItem(2856, 1) -- present box
		for _, item in pairs(itemList) do
			shoppingBag:addItem(item.itemId, item.count)
		end

		player:removeMoneyBank(moneyRequired)

		return true
	end

	return false
end

local imbuementPackagesData = {
	-- Skill increase packages
	["skill club"] = {
		text = "skill club",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9657, count = 20 }, -- cyclops toe
			{ itemId = 22189, count = 15 }, -- ogre nose ring
			{ itemId = 10405, count = 10 }, -- warmaster's wristguards
		},
	},
	["skill shield"] = {
		text = "skill shield",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9641, count = 20 }, -- piece of scarab shell
			{ itemId = 11703, count = 25 }, -- brimstone shell
			{ itemId = 20199, count = 25 }, -- frazzle skin
		},
	},
	["skill axe"] = {
		text = "skill axe",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 10196, count = 20 }, -- orc tooth
			{ itemId = 11447, count = 25 }, -- battle stone
			{ itemId = 21200, count = 20 }, -- moohtant horn
		},
	},
	["magic level"] = {
		text = "magic level",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9635, count = 25 }, -- elvish talisman
			{ itemId = 11452, count = 15 }, -- broken shamanic staff
			{ itemId = 10309, count = 15 }, -- strand of medusa hair
		},
	},
	["skill distance"] = {
		text = "skill distance",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 11464, count = 25 }, -- elven scouting glass
			{ itemId = 18994, count = 20 }, -- elven hoof
			{ itemId = 10298, count = 10 }, -- metal spike
		},
	},
	["skill sword"] = {
		text = "skill sword",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9691, count = 25 }, -- lion's mane
			{ itemId = 21202, count = 25 }, -- mooh'tah shell
			{ itemId = 9654, count = 5 }, -- war crystal
		},
	},
	-- Additional attributes packages
	["capacity increase"] = {
		text = "capacity increase",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 25694, count = 20 }, -- fairy wings
			{ itemId = 25702, count = 10 }, -- little bowl of myrrh
			{ itemId = 20205, count = 5 }, -- goosebump leather
		},
	},
	["critical"] = {
		text = "critical",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 11444, count = 20 }, -- protective charm
			{ itemId = 10311, count = 25 }, -- sabretooth
			{ itemId = 22728, count = 5 }, -- vexclaw talon
		},
	},
	["speed"] = {
		text = "speed",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 17458, count = 15 }, -- damselfly wing
			{ itemId = 10302, count = 25 }, -- compass
			{ itemId = 14081, count = 20 }, -- waspoid wing
		},
	},
	["life leech"] = {
		text = "life leech",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9685, count = 25 }, -- vampire teeth
			{ itemId = 9633, count = 15 }, -- bloody pincers
			{ itemId = 9663, count = 5 }, -- piece of dead brain
		},
	},
	["paralysis removal"] = {
		text = "paralysis removal",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 22053, count = 20 }, -- wereboar hooves
			{ itemId = 23507, count = 15 }, -- crystallized anger
			{ itemId = 28567, count = 5 }, -- quill
		},
	},
	["mana leech"] = {
		text = "mana leech",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 11492, count = 25 }, -- rope belt
			{ itemId = 20200, count = 25 }, -- silencer claws
			{ itemId = 22730, count = 5 }, -- some grimeleech wings
		},
	},
	-- Elemental damage packages
	["energy damage"] = {
		text = "energy damage",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 18993, count = 25 }, -- rorc feather
			{ itemId = 21975, count = 5 }, -- peacock feather fan
			{ itemId = 23508, count = 1 }, -- energy vein
		},
	},
	["ice damage"] = {
		text = "ice damage",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9661, count = 25 }, -- frosty heart
			{ itemId = 21801, count = 10 }, -- seacrest hair
			{ itemId = 9650, count = 5 }, -- polar bear paw
		},
	},
	["death damage"] = {
		text = "death damage",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 11484, count = 25 }, -- pile of grave earth
			{ itemId = 9647, count = 20 }, -- demonic skeletal hand
			{ itemId = 10420, count = 5 }, -- petrified scream
		},
	},
	["fire damage"] = {
		text = "fire damage",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9636, count = 25 }, -- fiery heart
			{ itemId = 5920, count = 5 }, -- green dragon scale
			{ itemId = 5954, count = 5 }, -- demon horn
		},
	},
	["earth damage"] = {
		text = "earth damage",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9686, count = 25 }, -- swamp grass
			{ itemId = 9640, count = 20 }, -- poisonous slime
			{ itemId = 21194, count = 2 }, -- slime heart
		},
	},
	-- Elemental protection packages
	["energy protection"] = {
		text = "energy protection",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9644, count = 20 }, -- wyvern talisman
			{ itemId = 14079, count = 15 }, -- crawler head plating
			{ itemId = 9665, count = 10 }, -- wyrm scale
		},
	},
	["holy protection"] = {
		text = "holy protection",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 9639, count = 25 }, -- cultish robe
			{ itemId = 9638, count = 25 }, -- cultish mask
			{ itemId = 10304, count = 20 }, -- hellspawn tail
		},
	},
	["fire protection"] = {
		text = "fire protection",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 5877, count = 20 }, -- green dragon leather
			{ itemId = 16131, count = 10 }, -- blazing bone
			{ itemId = 11658, count = 5 }, -- draken sulphur
		},
	},
	["death protection"] = {
		text = "death protection",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 11466, count = 25 }, -- flask of embalming fluid
			{ itemId = 22007, count = 20 }, -- gloom wolf fur
			{ itemId = 9660, count = 5 }, -- mystical hourglass
		},
	},
	["ice protection"] = {
		text = "ice protection",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 10295, count = 25 }, -- winter wolf fur
			{ itemId = 10307, count = 15 }, -- thick fur
			{ itemId = 14012, count = 10 }, -- deepling warts
		},
	},
	["earth protection"] = {
		text = "earth protection",
		moneyRequired = 250000,
		itemList = {
			{ itemId = 17823, count = 25 }, -- piece of swampling wood
			{ itemId = 9694, count = 20 }, -- snake skin
			{ itemId = 11702, count = 10 }, -- brimstone fangs
		},
	},
}

local function purchaseItems(npc, player, message)
	local packageData = imbuementPackagesData[message]
	if packageData and npcHandler:getTopic(player:getId()) == 1 then
		npcHandler:say("Do you want to buy items for " .. packageData.text .. " imbuement for " .. packageData.moneyRequired .. " gold?", npc, player)
		npcHandler:setTopic(player:getId(), 2)
		playerImbuementData[player:getId()] = {
			moneyRequired = packageData.moneyRequired,
			itemList = packageData.itemList,
		}
	end
end

local function creatureSayCallback(npc, creature, type, message)
	local player = Player(creature)
	local playerId = player:getId()
	if not npcHandler:checkInteraction(npc, creature) then
		return false
	end

	local imbuementPackages =
		"These are the available imbuement packages Additional attributes: {capacity increase}, {critical}, {life leech}, {mana leech}, {paralysis removal}, {speed}. Skill increase: {skill club}, {skill shield}, {skill axe}, {magic level}, {skill distance}, {skill sword}. Elemental damage: {energy damage}, {ice damage}, {death damage}, {fire damage}, {earth damage}. Elemental protection: {energy protection}, {holy protection}, {fire protection}, {death protection}, {ice protection}, {earth protection}."
	if MsgContains(message, "imbuement packages") then
		npcHandler:setTopic(playerId, 1)
		npcHandler:say(imbuementPackages, npc, creature)
	elseif imbuementPackagesData[message] then
		purchaseItems(npc, player, message)
	elseif MsgContains(message, "yes") and npcHandler:getTopic(playerId) == 2 then
		local success, message = addItemsToShoppingBag(npc, player)
		if not success then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
			npcHandler:setTopic(playerId, 1)
			npcHandler:say(imbuementPackages, npc, player)
			return
		end

		playerImbuementData[playerId] = nil
		npcHandler:say("You have successfully completed your purchase of the items.", npc, player)
		npcHandler:setTopic(playerId, 1)
		npcHandler:say(imbuementPackages, npc, creature)
	end
end

npcHandler:setMessage(MESSAGE_GREET, "Hello |PLAYERNAME|, say {imbuement packages} to buy imbuement items.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "See you later |PLAYERNAME| come back soon.")
npcHandler:setMessage(MESSAGE_FAREWELL, "See you later |PLAYERNAME| come back soon.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new(), npcConfig.name, true, true, true)

npcConfig.shop = {
}

-- On buy npc shop message
npcType.onBuyItem = function(npc, player, itemId, subType, amount, ignore, inBackpacks, totalCost)
	npc:sellItem(player, itemId, amount, subType, 0, ignore, inBackpacks)
end
-- On sell npc shop message
npcType.onSellItem = function(npc, player, itemId, subtype, amount, ignore, name, totalCost)
	player:sendTextMessage(MESSAGE_TRADE, string.format("Sold %ix %s for %i gold.", amount, name, totalCost))
end
-- On check npc shop message (look item)
npcType.onCheckItem = function(npc, player, clientId, subType) end

npcType:register(npcConfig)
