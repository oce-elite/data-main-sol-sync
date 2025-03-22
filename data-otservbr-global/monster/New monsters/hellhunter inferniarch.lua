local mType = Game.createMonsterType("Hellhunter Inferniarch")
local monster = {}

monster.description = "a hellhunter inferniarch"
monster.experience = 9100
monster.outfit = {
	lookType = 1793,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2600
monster.Bestiary = {
	class = "Demon",
	race = BESTY_RACE_DEMON,
	toKill = 2500,
	FirstUnlock = 100,
	SecondUnlock = 1000,
	CharmsPoints = 50,
	Stars = 4,
	Occurrence = 0,
	Locations = "Grounds of Damnation, Grounds of Despair, Grounds of Destruction, Grounds of Fire, Grounds of Plague, Grounds of Undeath, Halls of Ascension and Hell Hub",
}

monster.health = 11300
monster.maxHealth = 11300
monster.race = "fire"
monster.corpse = 49994
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
	rewardBoss = false,
	illusionable = false,
	canPushItems = true,
	canPushCreatures = true,
	staticAttackChance = 90,
	targetDistance = 3,
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

monster.voices = {
	interval = 5000,
	chance = 10,
	{ text = "Ardash... El...!", "Urrrglll!", yell = false },
	
}

monster.loot = {
	{ id = 3035, chance = 20000, maxCount = 20 }, -- platinum coin
	{ name = "assassin star", chance = 12550, maxCount = 10 },
	{ id = 9058, chance = 1300, maxCount = 2 }, -- gold ingot
	{ id = 238, chance = 19600, maxCount = 2 }, -- great mana potion
	{ id = 3033, chance = 13000, maxCount = 2 }, -- small amethyst
	{ id = 3028, chance = 13900, maxCount = 3 }, -- small diamond
	{ id = 16125, chance = 3900, maxCount = 1 }, -- Cyan Crystal Fragment
	{ id = 3030, chance = 2000, maxCount = 5 }, -- small ruby
	{ id = 9057, chance = 2900, maxCount = 5 }, -- small topaz
	{ id = 49909, chance = 5300, maxCount = 1 }, -- demonic core essence
	{ id = 50055, chance = 1000 }, -- hellhunter eye
	{ id = 49893, chance = 1600 }, -- demonic matter
	{ id = 281, chance = 800 }, -- giant shimmering pearl (green)
	{ id = 3038, chance = 800 }, -- green gem
	{ id = 818, chance = 1500 }, -- magma boots
	{ id = 821, chance = 1200 }, -- magma legs
	{ id = 3414, chance = 350 }, -- mastermind shield
	{ id = 3039, chance = 500 }, -- red gem
	{ id = 22866, chance = 280 }, -- rift bow
	{ id = 22867, chance = 180 }, -- rift crossbow
	{ id = 5741, chance = 450 }, -- skull helmet
	{ id = 22727, chance = 200 }, -- rift lance
	{ id = 7413, chance = 900 }, -- titan axe
	{ id = 3360, chance = 750 }, -- golden armor
	{ id = 8074, chance = 1900 }, -- spellbook of mind control
	{ id = 3340, chance = 1400 }, -- heavy mace
        { id = 49908, chance = 1800 }, -- mummified demon finger
	
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = 200, maxDamage = -669, condition = { type = CONDITION_FIRE, totalDamage = 600, interval = 9000 } },
	{name ="combat", interval = 2000, chance = 25, type = COMBAT_PHYSICALDAMAGE, minDamage = -460, maxDamage = -930, range = 7, shootEffect = CONST_ANI_INFERNALBOLT, target = true},
	{name ="combat", interval = 2000, chance = 17, type = COMBAT_ENERGYDAMAGE, minDamage = -380, maxDamage = -520, radius = 4, effect = CONST_ME_YELLOWENERGY, target = false},
        {name ="combat", interval = 2000, chance = 18, type = COMBAT_ENERGYDAMAGE, minDamage = -200, maxDamage = -500, range = 7, shootEffect = CONST_ANI_ENERGY, radius = 3, effect = CONST_ME_ENERGYHIT, target = true},
        {name = "whitechain", interval = 2000, chance = 15, minDamage = -100, maxDamage = -380, range = 8 },
        {name ="combat", interval = 2000, chance = 16, type = COMBAT_DEATHDAMAGE, minDamage = -200, maxDamage = -550, range = 7, shootEffect = CONST_ANI_ONYXARROW, effect = CONST_ME_MORTAREA, target = true},
	
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
