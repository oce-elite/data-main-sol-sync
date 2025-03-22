local config = {
	boss = {
		name = "The Rootkraken",
		position = Position(32623, 32946, 15),
	},
	requiredLevel = 300,
	timeAfterKill = 120,
	timeToDefeat = 30 * 60,
	playerPositions = { 
		{ pos = Position(32618, 32909, 15), teleport = Position(32622, 32939, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32618, 32910, 15), teleport = Position(32622, 32939, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32618, 32911, 15), teleport = Position(32622, 32939, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32618, 32912, 15), teleport = Position(32622, 32939, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(32618, 32913, 15), teleport = Position(32622, 32939, 15), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(32608, 32933, 15),
		to = Position(32636, 32960, 15),
	},
	exit = Position(32615, 32910, 15),
}

local lever = BossLever(config)
lever:position(Position(32618, 32908, 15))
lever:register()