local mType = Game.createMonsterType("Brinebrute Inferniarch")
local monster = {}

monster.description = "a brinebrute inferniarch"
monster.experience = 23500
monster.outfit = {
	lookType = 1794,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2601
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

monster.health = 32000
monster.maxHealth = 32000
monster.race = "fire"
monster.corpse = 49998
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
	rewardBoss = false,
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
        { id = 49909, chance = 5300, maxCount = 1 }, -- demonic core essence
	{ id = 7643, chance = 6000, maxCount = 5 }, -- Ultimate Health Potion
        { id = 50101, chance = 4000 }, -- Bloodstained Scythe
	{ id = 49893, chance = 5600 }, -- demonic matter
	{ name = "giant sword", chance = 4480 },
	{ id = 3038, chance = 4100 }, -- green gem
	{ name = "might ring", chance = 3890 },
	{ id = 3098, chance = 3990 }, -- ring of healing
        { name = "might ring", chance = 3790 },
        { name = "stone skin amulet", chance = 3820 },
        { name = "gold ring", chance = 1950 },
        { id = 49908, chance = 1800 }, -- mummified demon finger
        { name = "demon shield", chance = 740 },
        { name = "demonrage sword", chance = 170 },
        { name = "crusader helmet", chance = 850 },
	
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = 400, maxDamage = -1069, condition = { type = CONDITION_FIRE, totalDamage = 600, interval = 9000 } },
	{name ="combat", interval = 2000, chance = 18, type = COMBAT_AGONYDAMAGE, minDamage = -80, maxDamage = -150, range = 7, effect = 150, target = true},
	{name ="combat", interval = 2000, chance = 14, type = COMBAT_FIREDAMAGE, minDamage = -380, maxDamage = -720, length = 6, spread = 0, effect = CONST_ME_EXPLOSIONHIT, target = false},
        {name ="combat", interval = 2000, chance = 12, type = COMBAT_DEATHDAMAGE, minDamage = -380, maxDamage = -520, radius = 4, effect = CONST_ME_SLASH, target = false},
	
}

monster.defenses = {
	defense = 40,
	armor = 80,
	mitigation = 2.45,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 95, effect = CONST_ME_REDSMOKE, target = false },
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
