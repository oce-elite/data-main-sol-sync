local mType = Game.createMonsterType("Malvaroth")
local monster = {}

monster.description = "a Malvaroth"
monster.experience = 28000
monster.outfit = {
	lookType = 1794,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0,
}

monster.bosstiary = {
	bossRaceId = 2607,
	bossRace = RARITY_BANE,
}

monster.health = 45000
monster.maxHealth = 45000
monster.race = "fire"
monster.corpse = 50050
monster.speed = 160
monster.manaCost = 0

monster.changeTarget = {
	interval = 4000,
	chance = 10,
}

monster.strategiesTarget = {
	nearest = 70,
	health = 10,
	damage = 10,
	random = 10,
}

monster.flags = {
	summonable = false,
	attackable = true,
	hostile = true,
	convinceable = false,
	pushable = false,
	rewardBoss = true,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 1,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.light = {
	level = 0,
	color = 0,
}


monster.summon = {
	maxSummons = 8,
	summons = {
		{ name = "brinebrute inferniarch", chance = 100, interval = 2000, count = 8 },
	},
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Garrr...Garrr!", yell = false },
	
}

monster.loot = {
	{ id = 3035, chance = 20000, maxCount = 50 }, -- platinum coin
	{ id = 7642, chance = 19600, maxCount = 2 }, -- great spirit potion
	{ id = 50056, chance = 16000, maxCount = 1 }, -- brinebrute claw
	{ id = 16119, chance = 13000, maxCount = 5 }, -- blue crystal shard
	{ id = 16120, chance = 10000, maxCount = 5 }, -- violet crystal shard
        { id = 16121, chance = 11000, maxCount = 5 }, -- green crystal shard
	{ id = 3029, chance = 12000, maxCount = 5 }, -- small sapphire
	{ name = "brown crystal splinter", chance = 12000, maxCount = 2 },
	{ name = "green crystal splinter", chance = 13000, maxCount = 2 },
        { name = "blue crystal splinter", chance = 12000, maxCount = 2 },
        { id = 3039, chance = 10850 }, -- red gem
        { id = 49909, chance = 15300, maxCount = 1 }, -- demonic core essence
	{ id = 7643, chance = 16000, maxCount = 5 }, -- Ultimate Health Potion
        { id = 49893, chance = 3000 }, -- skin of Malvaroth
	{ id = 49893, chance = 5600 }, -- demonic matter
	{ name = "giant sword", chance = 4480 },
	{ id = 3038, chance = 14100 }, -- green gem
	{ name = "might ring", chance = 3890 },
	{ id = 3098, chance = 13990 }, -- ring of healing
        { name = "might ring", chance = 13790 },
        { name = "stone skin amulet", chance = 13820 },
        { name = "gold ring", chance = 11950 },
        { id = 49908, chance = 7800 }, -- mummified demon finger
        { name = "demon shield", chance = 11740 },
        { name = "demonrage sword", chance = 1170 },
        { name = "crusader helmet", chance = 10850 },
	
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = 400, maxDamage = -1669, condition = { type = CONDITION_FIRE, totalDamage = 600, interval = 9000 } },

	
}

monster.defenses = {
	defense = 40,
	armor = 90,
	mitigation = 2.45,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 95, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 20 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -10 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 0 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = 20 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
