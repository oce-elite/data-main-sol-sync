local mType = Game.createMonsterType("Sineater Inferniarch")
local monster = {}

monster.description = "a sineater inferniarch"
monster.experience = 7250
monster.outfit = {
	lookType = 1795,
	lookHead = 0,
	lookBody = 0,
	lookLegs = 0,
	lookFeet = 0,
	lookAddons = 0,
	lookMount = 0,
}

monster.raceId = 2602
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

monster.health = 9150
monster.maxHealth = 9150
monster.race = "blood"
monster.corpse = 50001
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
	{ text = "Kah ... Thul... GROAR!", yell = false },
        { text = "Bahrrr... Bharush!", yell = false },
	
}

monster.loot = {
	{ id = 3035, chance = 20000, maxCount = 20 }, -- platinum coin
	{ id = 238, chance = 19600, maxCount = 3 }, -- great mana potion
	{ id = 3030, chance = 12000, maxCount = 5 }, -- small ruby
	{ id = 49909, chance = 5300, maxCount = 1 }, -- demonic core essence
	{ id = 3016, chance = 5800 }, -- ruby necklace
        { id = 25699, chance = 1000 }, -- wooden spellbook
	{ id = 49893, chance = 1600 }, -- demonic matter
	{ name = "wand of defiance", chance = 4560 },	
	{ id = 50057, chance = 1800 }, -- sineater wing
	{ id = 49908, chance = 1800 }, -- mummified demon finger
	
}

monster.attacks = {
	{name = "melee", interval = 2000, chance = 100, minDamage = 196, maxDamage = -352, condition = { type = CONDITION_FIRE, totalDamage = 400, interval = 9000 } },
	{name ="combat", interval = 2000, chance = 15, type = COMBAT_FIREDAMAGE, minDamage = -362, maxDamage = -430, radius = 4, effect = CONST_ME_FIREAREA, target = true},
	{name ="sineaterwave", interval = 2000, chance = 17, minDamage = -218, maxDamage = -445, target = false},
        {name ="combat", interval = 2000, chance = 18, type = COMBAT_DEATHDAMAGE, minDamage = -425, maxDamage = -454, effect = CONST_ME_BIG_SCRATCH, target = false},
        {name = "firefield", interval = 2000, chance = 10, range = 7, radius = 1, shootEffect = CONST_ANI_FIRE, target = true },
       
	
}

monster.defenses = {
	defense = 20,
	armor = 68,
	mitigation = 2.20,
	{ name = "combat", interval = 2000, chance = 10, type = COMBAT_HEALING, minDamage = 80, maxDamage = 95, effect = CONST_ME_MAGIC_BLUE, target = false },
}

monster.elements = {
	{ type = COMBAT_PHYSICALDAMAGE, percent = -5 },
	{ type = COMBAT_ENERGYDAMAGE, percent = -10 },
	{ type = COMBAT_EARTHDAMAGE, percent = 0 },
	{ type = COMBAT_FIREDAMAGE, percent = 100 },
	{ type = COMBAT_LIFEDRAIN, percent = 100 },
	{ type = COMBAT_MANADRAIN, percent = 0 },
	{ type = COMBAT_DROWNDAMAGE, percent = 100 },
	{ type = COMBAT_ICEDAMAGE, percent = -5 },
	{ type = COMBAT_HOLYDAMAGE, percent = -10 },
	{ type = COMBAT_DEATHDAMAGE, percent = 10 },
}

monster.immunities = {
	{ type = "paralyze", condition = true },
	{ type = "outfit", condition = false },
	{ type = "invisible", condition = true },
	{ type = "bleed", condition = false },
}

mType:register(monster)
