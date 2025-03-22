-- Fiendish Boss System Integration
-- This script modifies bosses spawned via the lever system, giving them a chance to be upgraded into Fiendish versions.

local fiendishConfig = {
	baseChance = 100,        -- Base chance for a Fiendish boss to appear (100% for testing)
	vipMultiplier = 2,       -- VIP players double the chance
	bossPointsMultiplier = 0.1, -- Each boss point slightly increases the chance
	tiers = {
		[1] = { chance = 50, hpMultiplier = 1.25, speedMultiplier = 1.3, abilities = 1, rewardContainers = 1, loot = { { itemId = 34109, count = { 1, 1 }, chance = 100 } } },
		[2] = { chance = 40, hpMultiplier = 1.5, speedMultiplier = 1.6, abilities = 3, rewardContainers = 2, loot = { { itemId = 34109, count = { 1, 1 }, chance = 100 } } },
		[3] = { chance = 10, hpMultiplier = 2.0, speedMultiplier = 2.0, abilities = 5, rewardContainers = 3, loot = { { itemId = 34109, count = { 1, 1 }, chance = 100 } } }
	}
}

-- Function to broadcast a message to all party members
local function broadcastFiendishMessage(players, tier)
	if not players or #players == 0 then
		print("[Warning] broadcastFiendishMessage: No players provided.")
		return
	end

	local message = "A powerful presence is detected! A Fiendish Tier " .. tier .. " boss is approaching!"
	for _, player in ipairs(players) do
		if player and player:isPlayer() then
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
		end
	end
end

-- Function to lock the lever temporarily
local leverLocks = {}

function setLeverLock(bossName, duration)
	if not bossName then return end
	leverLocks[bossName] = true

	addEvent(function()
		leverLocks[bossName] = nil
	end, duration * 1000) -- Convert seconds to milliseconds
end

-- Function to check if the lever is locked
function isLeverLocked(bossName)
	return leverLocks[bossName] == true
end

function onFiendishBossDeath(creature, corpse)
	if not creature or not creature:isMonster() then return true end
	local tier = creature:getStorageValue(Storage.FiendishBossTier) -- tier stored on boss
	if tier < 1 or tier > 3 then return true end

	local players = creature:getDamageMap() -- all damagers
	for playerId, _ in pairs(players) do
		local player = Player(playerId)
		if player then
			local tierConfig = fiendishConfig.tiers[tier]
			-- Determine how many bonus containers to give (e.g. tier2=2 containers)
			local containerCount = tierConfig.rewardContainers or 1
			for i = 1, containerCount do
				-- Create a container (e.g. bag) for the bonus loot
				local rewardBag = Game.createItem(1987, 1) -- 1987 = normal brown bag, use any container ID
				-- Generate loot items for this container
				for _, loot in ipairs(tierConfig.loot) do
					if not loot.chance or math.random(100) <= loot.chance then
						local amount = math.random(loot.count[1], loot.count[2])
						rewardBag:addItem(loot.itemId, amount)
					end
				end
				-- Ultra-rare reward (only once across all containers to avoid duplicates)
				if i == 1 and canDropUltraRareReward() then
					rewardBag:addItem(2160, 1) -- e.g. crystal coin as ultra-rare
					setUltraRareRewardCooldown()
					Game.broadcastMessage(
						"A player has obtained an ultra-rare reward from a Fiendish Boss! Next drop in 7 days.")
				end
				-- Insert the filled bag into the player's personal reward chest
				local rewardId = corpse:getAttribute(ITEM_ATTRIBUTE_DATE)
				local personalChest = player:getReward(rewardId, true)
				if personalChest then
					personalChest:addItemEx(rewardBag)
				else
					-- Fallback: if reward chest not available, give directly
					player:addItemEx(rewardBag)
				end
			end
		end
	end
	return true
end

local function modifyBoss(boss, tier)
	if not boss then return end
	local tierConfig = fiendishConfig.tiers[tier]
	if not tierConfig then return end

	boss:setMaxHealth(boss:getMaxHealth() * tierConfig.hpMultiplier)
	boss:setHealth(boss:getMaxHealth())
	boss:setSpeed(boss:getSpeed() * tierConfig.speedMultiplier)

	boss:setStorageValue(10000, tier) -- This is critical for reward handling on death

	-- Assign the Fiendish symbol and aura effect based on tier
	local auraEffects = {
		[1] = CONST_ME_MAGIC_BLUE, -- Tier 1: Blue Aura
		[2] = CONST_ME_PURPLESMOKE, -- Tier 2: Purple Aura
		[3] = CONST_ME_MORTAREA -- Tier 3: Dark Aura
	}

	boss:setOutfit({ lookType = 129, lookHead = 94, lookBody = 94, lookLegs = 94, lookFeet = 94 }) -- Example fiendish look

	-- Apply aura effect every few seconds
	local function applyAura()
		if boss and boss:isMonster() and not boss:isRemoved() then
			boss:getPosition():sendMagicEffect(auraEffects[tier] or CONST_ME_MAGIC_BLUE)
			addEvent(applyAura, 5000)
		end
	end
	applyAura()

	-- Apply additional abilities (to be implemented later)
	boss:registerEvent("FiendishAbilities")
end

-- Global storage key for ultra-rare reward cooldown
local ULTRA_RARE_REWARD_STORAGE = 99999      -- Change this to an appropriate unused storage key
local ULTRA_RARE_COOLDOWN = 7 * 24 * 60 * 60 -- 7 days in seconds

-- Function to check if ultra-rare reward can be granted
local function canDropUltraRareReward()
	local lastDropTime = Game.getStorageValue(ULTRA_RARE_REWARD_STORAGE) or 0
	return os.time() >= lastDropTime + ULTRA_RARE_COOLDOWN
end

-- Function to set global cooldown for ultra-rare rewards
local function setUltraRareRewardCooldown()
	Game.setStorageValue(ULTRA_RARE_REWARD_STORAGE, os.time())
end

function grantBossRewards(player, tier, creature)
	local tierConfig = fiendishConfig.tiers[tier]
	if not tierConfig then return end

	-- Find the corpse on the tile where the boss died
	local position = creature:getPosition()
	local tile = Tile(position)
	if not tile then
		print("[FiendishReward] No tile found at boss position")
		return
	end

	local corpse = nil
	for i = 1, tile:getThingCount() do
		local thing = tile:getThing(i)
		if thing and thing:isItem() and thing:getType():isCorpse() then
			corpse = thing
			break
		end
	end

	if not corpse then
		print("[FiendishReward] No corpse found at boss death position")
		return
	end

	local rewardId = corpse:getAttribute(ITEM_ATTRIBUTE_DATE)
	local rewardChest = player:getReward(rewardId, true)

	if not rewardChest then
		print("[FiendishReward] Could not access reward chest for player: " .. player:getName())
		return
	end

	for i = 1, tierConfig.rewardContainers do
		local rewardContainer = Game.createItem(19202, 1) -- Reward Container

		for _, loot in ipairs(tierConfig.loot) do
			if not loot.chance or math.random(100) <= loot.chance then
				local count = math.random(loot.count[1], loot.count[2])
				rewardContainer:addItem(loot.itemId, count)
			end
		end

		if i == 1 and canDropUltraRareReward() then
			rewardContainer:addItem(2160, 1) -- Crystal coin example
			setUltraRareRewardCooldown()
			Game.broadcastMessage(
				"A player has obtained an ultra-rare reward from a Fiendish Boss! Next drop in 7 days.")
		end

		rewardChest:addItemEx(rewardContainer)
	end
end

_G.grantBossRewards = grantBossRewards

-- Function to teleport players to a preparation room for Tier 3 bosses
local function teleportToPreparationRoom(players, bossName, bossPosition, tier)
	local prepRoomPosition = Position(32369, 32240, 5) -- Update this position after testing

	for _, player in ipairs(players) do
		if player and player:isPlayer() then
			player:teleportTo(prepRoomPosition)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
				"You have been pulled into a preparation chamber! You have 60 seconds to prepare for battle.")
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		end
	end

	-- Countdown messages
	addEvent(function()
		for _, player in ipairs(players) do
			if player and player:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "30 seconds remaining until the battle begins!")
			end
		end
	end, 30000) -- 30 seconds

	addEvent(function()
		for _, player in ipairs(players) do
			if player and player:isPlayer() then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "15 seconds remaining until the battle begins!")
			end
		end
	end, 45000) -- 45 seconds

	-- Final countdown with animated floating text
	local countdownNumbers = { "5", "4", "3", "2", "1" }
	for i, number in ipairs(countdownNumbers) do
		addEvent(function()
			for _, player in ipairs(players) do
				if player and player:isPlayer() then
					player:getPosition():sendAnimatedText(number, TEXTCOLOR_RED)
				end
			end
		end, 60000 - (i * 1000))
	end

	-- Final dramatic message
	addEvent(function()
		for _, player in ipairs(players) do
			if player and player:isPlayer() then
				player:sendTextMessage(MESSAGE_STATUS_WARNING, "Prepare to perish!")
			end
		end
	end, 59500) -- Show just before the teleport at 60s


	-- Lock the lever for 65 seconds
	setLeverLock(bossName, 65)

	-- Teleport to boss room after 60 seconds
	addEvent(function()
		for _, player in ipairs(players) do
			if player and player:isPlayer() then
				player:teleportTo(bossPosition)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
					"The presence of darkness engulfs you... The battle begins now!")
				player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			end
		end

		-- Spawn the Tier 3 Fiendish boss
		local boss = Game.createMonster(bossName, bossPosition)
		if boss then
			boss:registerEvent("FiendishBossDeath")
			boss:setStorageValue(GlobalStorage.Custom.FiendishBossTier, tier)
			modifyBoss(boss, tier)
		end
	end, 60000) -- 60 seconds delay
end

---@class BossLever
---@field private name string
---@field private bossPosition Position
---@field private createBoss function
---@field private timeToFightAgain number
---@field private timeToDefeat number
---@field private minPlayers number
---@field private timeAfterKill number
---@field private requiredLevel number
---@field private disabled boolean
---@field private onUseExtra function
---@field private _position Position
---@field private _uid number
---@field private _aid number
---@field private playerPositions {pos: Position, teleport: Position}[]
---@field private area {from: Position, to: Position}
---@field private monsters {name: string, pos: Position, delay: number}[]
---@field private exitTeleporter Position
---@field private exit Position
---@field private encounter Encounter
---@field private timeoutEvent Event
---@field private disableCooldown boolean
BossLever = {}

--[[
local config = {
	boss = {
		name = "Faceless Bane",
		position = Position(33617, 32561, 13)
	}
	requiredLevel = 250,
	timeToFightAgain = 10 * 60 * 60, -- In seconds
	minPlayers = 4,
	playerPositions = {
		{ pos = Position(33638, 32562, 13), teleport = Position(33617, 32567, 13) },
		{ pos = Position(33639, 32562, 13), teleport = Position(33617, 32567, 13) },
		{ pos = Position(33640, 32562, 13), teleport = Position(33617, 32567, 13) },
		{ pos = Position(33641, 32562, 13), teleport = Position(33617, 32567, 13) },
		{ pos = Position(33642, 32562, 13), teleport = Position(33617, 32567, 13) },
	},
	specPos = {
		from = Position(33607, 32553, 13),
		to = Position(33627, 32570, 13)
	},
	monsters = {
        { name = "rat", pos = Position(33615, 32563, 13) },
        { name = "rat", pos = Position(33615, 32563, 13), delay = 5000 },
    },
	onUseExtra = function(player, infoPositions)
		player:teleportTo(Position(33618, 32523, 15))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
	end,
	exit = Position(33618, 32523, 15),
}
]]
setmetatable(BossLever, {
	---@param self BossLever
	---@param config table
	__call = function(self, config)
		local boss = config.boss
		if not boss then
			error("BossLever: boss is required")
		end
		return setmetatable({
			name = boss.name:lower(),
			encounter = config.encounter,
			bossPosition = boss.position,
			timeToFightAgain = config.timeToFightAgain or
				configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_FIGHT_AGAIN),
			timeToDefeat = config.timeToDefeat or configManager.getNumber(configKeys.BOSS_DEFAULT_TIME_TO_DEFEAT),
			timeAfterKill = config.timeAfterKill or 60,
			requiredLevel = config.requiredLevel or 0,
			createBoss = boss.createFunction,
			disabled = config.disabled,
			minPlayers = config.minPlayers or 1,
			playerPositions = config.playerPositions,
			onUseExtra = config.onUseExtra or function() end,
			exitTeleporter = config.exitTeleporter,
			exit = config.exit,
			area = config.specPos,
			monsters = config.monsters or {},
			disableCooldown = config.disableCooldown,
			_position = nil,
			_uid = nil,
			_aid = nil,
		}, { __index = BossLever })
	end,
})

---@param self BossLever
---@param position Position
---@return BossLever
function BossLever:position(position)
	self._position = position
	return self
end

---@param self BossLever
---@param uid number
---@return BossLever
function BossLever:uid(uid)
	self._uid = uid
	return self
end

---@param self BossLever
---@param aid number
---@return BossLever
function BossLever:aid(aid)
	self._aid = aid
	return self
end

function BossLever:kvScope()
	local mType = MonsterType(self.name)
	if not mType then
		error("BossLever: boss name is invalid")
	end
	return "boss.cooldown." .. toKey(tostring(mType:raceId()))
end

---@param self BossLever
---@param player Player
---@return number
function BossLever:lastEncounterTime(player)
	if not player or self.disableCooldown then
		return 0
	end
	return player:getBossCooldown(self.name)
end

---@param self BossLever
---@param time number
---@return boolean
function BossLever:setLastEncounterTime(time)
	local info = self.lever:getInfoPositions()
	if not info then
		logger.error("BossLever:setLastEncounterTime - lever:getInfoPositions() returned nil")
		return false
	end
	for _, v in pairs(info) do
		if v.creature then
			local player = v.creature:getPlayer()
			if player then
				-- Skip cooldown if player is named "Not Sparkz"
				if player:getName() ~= "Not Sparkz" then
					player:setBossCooldown(self.name, time)
				else
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Cooldown skipped for testing purposes.")
				end
			end
		end
	end
	return true
end

---@param player Player
---@return boolean
function BossLever:onUse(player)
	local monsterName = MonsterType(self.name):getName()
	local isParticipant = false
	for _, v in ipairs(self.playerPositions) do
		if Position(v.pos) == player:getPosition() then
			isParticipant = true
		end
	end
	if not isParticipant then
		return false
	end

	if self.disabled then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The boss is temporarily disabled.")
		return true
	end

	if isLeverLocked(self.name) then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's already someone fighting with " .. monsterName .. ".")
		return true
	end

	local zone = self:getZone()
	if zone:countPlayers(IgnoredByMonsters) > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "There's already someone fighting with " .. monsterName .. ".")
		return true
	end

	self.lever = Lever()
	local lever = self.lever
	lever:setPositions(self.playerPositions)
	lever:setCondition(function(creature)
		if not creature or not creature:isPlayer() then
			return true
		end

		local isAccountNormal = creature:getAccountType() < ACCOUNT_TYPE_GAMEMASTER
		if isAccountNormal and creature:getLevel() < self.requiredLevel then
			local message = "All players need to be level " .. self.requiredLevel .. " or higher."
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
			return false
		end

		local infoPositions = lever:getInfoPositions()
		if creature:getGroup():getId() < GROUP_TYPE_GOD and isAccountNormal and self:lastEncounterTime(creature) > os.time() then
			for _, posInfo in pairs(infoPositions) do
				local currentPlayer = posInfo.creature
				if currentPlayer then
					local lastEncounter = self:lastEncounterTime(currentPlayer)
					local currentTime = os.time()
					if lastEncounter and currentTime < lastEncounter then
						local timeLeft = lastEncounter - currentTime
						local timeMessage = Game.getTimeInWords(timeLeft) .. " to face " .. self.name .. " again!"
						local message = "You have to wait " .. timeMessage

						if currentPlayer ~= player then
							player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
								"A member in your team has to wait " .. timeMessage)
						end

						currentPlayer:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
						currentPlayer:getPosition():sendMagicEffect(CONST_ME_POFF)
					end
				end
			end
			return false
		end

		return self.onUseExtra(creature, infoPositions) ~= false
	end)

	lever:checkPositions()
	if #lever:getPlayers() < self.minPlayers then
		lever:executeOnPlayers(function(creature)
			local message = string.format("You need %d qualified players for this challenge.", self.minPlayers)
			creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
			creature:getPosition():sendMagicEffect(CONST_ME_POFF)
		end)
		return false
	end
	if lever:checkConditions() then
		zone:removeMonsters()

		-- Function to check if the boss should be a Fiendish boss
		local function shouldSpawnFiendishBoss(player)
			local chance = fiendishConfig.baseChance

			if player:isVip() then
				chance = chance * fiendishConfig.vipMultiplier
			end

			local bossPoints = player:getStorageValue(Storage.BossPoints) or 0
			chance = chance + (bossPoints * fiendishConfig.bossPointsMultiplier)

			return math.random(100) <= chance
		end

		-- Function to determine the tier of the Fiendish boss
		local function determineFiendishTier()
			local roll = math.random(100)
			local cumulativeChance = 0

			for tier, data in pairs(fiendishConfig.tiers) do
				cumulativeChance = cumulativeChance + data.chance
				if roll <= cumulativeChance then
					return tier
				end
			end

			return 1 -- Default to Tier 1 if something goes wrong
		end

		-- Modify boss spawning in the BossLever system
		function BossLever:onUse(player)
			local monsterName = MonsterType(self.name):getName()
			local isParticipant = false
			for _, v in ipairs(self.playerPositions) do
				if Position(v.pos) == player:getPosition() then
					isParticipant = true
				end
			end
			if not isParticipant then
				return false
			end

			if self.disabled then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "The boss is temporarily disabled.")
				return true
			end

			local zone = self:getZone()
			if zone:countPlayers(IgnoredByMonsters) > 0 then
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
					"There's already someone fighting with " .. monsterName .. ".")
				return true
			end

			self.lever = Lever()
			local lever = self.lever
			lever:setPositions(self.playerPositions)

			lever:checkPositions()
			if #lever:getPlayers() < self.minPlayers then
				lever:executeOnPlayers(function(creature)
					local message = string.format("You need %d qualified players for this challenge.", self.minPlayers)
					creature:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
					creature:getPosition():sendMagicEffect(CONST_ME_POFF)
				end)
				return false
			end
			if lever:checkConditions() then
				zone:removeMonsters()

				-- Check if this should be a Fiendish boss
				local isFiendish = shouldSpawnFiendishBoss(player)
				local tier = isFiendish and determineFiendishTier() or nil

				if isFiendish then
					-- Get all players standing on the lever tiles
					local players = lever:getPlayers()

					-- Send the message to all involved players
					broadcastFiendishMessage(players, tier)
				end

				if isFiendish and tier == 3 then
					-- Teleport players to the preparation room before the fight starts
					teleportToPreparationRoom(lever:getPlayers(), self.name, self.bossPosition, tier)
					return true -- Prevent immediate boss spawn
				end

				-- Standard boss spawning if it's not a Tier 3
				if self.createBoss then
					if not self.createBoss() then
						return true
					end
				elseif self.bossPosition then
					logger.debug("BossLever:onUse - creating boss: {}", self.name)
					local monster = Game.createMonster(self.name, self.bossPosition, true, true)
					if not monster then
						return true
					end
					monster:registerEvent("BossLeverOnDeath")

					-- Modify boss if Fiendish
					if isFiendish then
						modifyBoss(monster, tier)
					end
				end

				lever:teleportPlayers()
				self:setLastEncounterTime(os.time() + self.timeToFightAgain)

				if self.timeoutEvent then
					stopEvent(self.timeoutEvent)
					self.timeoutEvent = nil
				end

				self.timeoutEvent = addEvent(function(zn)
					zn:refresh()
					zn:removePlayers()
				end, self.timeToDefeat * 1000, zone)
			end
			return true
		end

		for _, monster in pairs(self.monsters) do
			if monster.delay then
				addEvent(Game.createMonster, monster.delay, monster.name, monster.pos, true, true)
			else
				Game.createMonster(monster.name, monster.pos, true, true)
			end
		end
		lever:teleportPlayers()
		if self.encounter then
			local encounter = Encounter(self.encounter)
			encounter:reset()
			encounter:start()
		end
		self:setLastEncounterTime(os.time() + self.timeToFightAgain)
		if self.timeoutEvent then
			stopEvent(self.timeoutEvent)
			self.timeoutEvent = nil
		end
		self.timeoutEvent = addEvent(function(zn)
			zn:refresh()
			zn:removePlayers()
		end, self.timeToDefeat * 1000, zone)
	end
	return true
end

---@param Zone
function BossLever:getZone()
	return Zone("boss." .. toKey(self.name))
end

---@param self BossLever
---@return boolean
function BossLever:register()
	local missingParams = {}
	if not self.name then
		table.insert(missingParams, "boss.name")
	end
	if not self.playerPositions then
		table.insert(missingParams, "playerPositions")
	end
	if not self.area then
		table.insert(missingParams, "specPos")
	end
	if not self.exit then
		table.insert(missingParams, "exit")
	end
	if not self._position and not self._uid and not self._aid then
		table.insert(missingParams, "position or uid or aid")
	end
	if #missingParams > 0 then
		local name = self.name or "unknown"
		logger.error("BossLever:register() - boss with name {} missing parameters: {}", name,
			table.concat(missingParams, ", "))
		return false
	end

	local zone = self:getZone()

	zone:addArea(self.area.from, self.area.to)
	zone:blockFamiliars()
	zone:setRemoveDestination(self.exit)

	local action = Action()
	action.onUse = function(player)
		self:onUse(player)
	end
	if self._position then
		action:position(self._position)
	end
	if self._uid then
		action:uid(self._uid)
	end
	if self._aid then
		action:aid(self._aid)
	end
	action:register()
	BossLever[self.name] = self

	if self.exitTeleporter then
		SimpleTeleport(self.exitTeleporter, self.exit)
	end
	return true
end
