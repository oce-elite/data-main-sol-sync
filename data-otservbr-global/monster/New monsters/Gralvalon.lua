local mType = Game.createMonsterType("Gralvalon")
local monster = {}

monster.description = "a Gralvalon"
monster.experience = 24000
monster.outfit = {
	lookType = 1793,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 1,
	lookMount = 0,
}
monster.bosstiary = {
	bossRaceId = 2606,
	bossRace = RARITY_BANE,

}

monster.health = 33000
monster.maxHealth = 33000
monster.race = "fire"
monster.corpse = 50046
monster.speed = 175
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
	targetDistance = 4,
	runHealth = 0,
	healthHidden = false,
	isBlockable = false,
	canWalkOnEnergy = false,
	canWalkOnFire = true,
	canWalkOnPoison = true,
}

monster.summon = {
	maxSummons = 8,
	summons = {
		{ name = "hellhunter inferniarch", chance = 100, interval = 2000, count = 8 },
	},
}

monster.light = {
	level = 0,
	color = 0,
}

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ardash... El...!", "Urrrglll!", yell = false },
	
}

monster.loot = {
	{ id = 3035, chance = 50000, maxCount = 50 }, -- platinum coin
	{ name = "assassin star", chance = 22550, maxCount = 10 },
	{ id = 9058, chance = 1300, maxCount = 10 }, -- gold ingot
	{ id = 238, chance = 19600, maxCount = 20 }, -- great mana potion
	{ id = 3033, chance = 13000, maxCount = 20 }, -- small amethyst
	{ id = 3028, chance = 13900, maxCount = 30 }, -- small diamond
	{ id = 16125, chance = 3900, maxCount = 10 }, -- Cyan Crystal Fragment
	{ id = 3030, chance = 2000, maxCount = 20 }, -- small ruby
	{ id = 9057, chance = 2900, maxCount = 20 }, -- small topaz
	{ id = 49909, chance = 5300, maxCount = 1 }, -- demonic core essence
	{ id = 49892, chance = 3000 }, -- skin of Gralvalon
	{ id = 49893, chance = 3500 }, -- demonic matter
	{ id = 281, chance = 800 }, -- giant shimmering pearl (green)
	{ id = 3038, chance = 800 }, -- green gem
	{ id = 818, chance = 11500 }, -- magma boots
	{ id = 821, chance = 11200 }, -- magma legs
	{ id = 3414, chance = 11350 }, -- mastermind shield
	{ id = 3039, chance = 9500 }, -- red gem
	{ id = 22866, chance = 9280 }, -- rift bow
	{ id = 22867, chance = 9180 }, -- rift crossbow
	{ id = 5741, chance = 9450 }, -- skull helmet
	{ id = 22727, chance = 9200 }, -- rift lance
	{ id = 7413, chance = 9900 }, -- titan axe
	{ id = 3360, chance = 9750 }, -- golden armor
	{ id = 8074, chance = 1900 }, -- spellbook of mind control
	{ id = 3340, chance = 1400 }, -- heavy mace
        { id = 49908, chance = 11800 }, -- mummified demon finger
	
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = 200, maxDamage = -1069, condition = { type = CONDITION_FIRE, totalDamage = 600, interval = 9000 } },
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -460, maxDamage = -930, range = 7, shootEffect = CONST_ANI_INFERNALBOLT, target = true},
	{name ="combat", interval = 2000, chance = 17, type = COMBAT_ENERGYDAMAGE, minDamage = -380, maxDamage = -720, radius = 4, effect = CONST_ME_YELLOWENERGY, target = false},
        {name ="combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -700, range = 7, shootEffect = CONST_ANI_ENERGY, radius = 3, effect = CONST_ME_ENERGYHIT, target = true},
        {name = "whitechain", interval = 3000, chance = 10, minDamage = -100, maxDamage = -380, target = true },
        {name ="combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -750, range = 7, shootEffect = CONST_ANI_ONYXARROW, effect = CONST_ME_MORTAREA, target = true},
	
}

monster.defenses = {
	defense = 20,
	armor = 73,
	mitigation = 2.20,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 95, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = 10 },
	{ type = COMBAT_ENERGYDAMAGE, percent = 15 },
	{ type = COMBAT_EARTHDAMAGE, percent = -15 },
	{ type = COMBAT_FIREDAMAGE, percent = 0 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = 5 },
	{ type = COMBAT_HOLYDAMAGE, percent = 0 },
	{ type = COMBAT_DEATHDAMAGE, percent = -15 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
