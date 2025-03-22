local config = {
	boss = {
		name = "Brokul",
		position = Position(33483, 31437, 15),
	},
	timeToFightAgain = 20 * 60 * 60,
	timeAfterKill = 120,
	timeToDefeat = 20 * 60,
	playerPositions = {
		{ pos = Position(33522, 31465, 15), teleport = Position(33484, 31446, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33520, 31465, 15), teleport = Position(33484, 31446, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33521, 31465, 15), teleport = Position(33484, 31446, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33523, 31465, 15), teleport = Position(33484, 31446, 15), effect = CONST_ME_TELEPORT },
		{ pos = Position(33524, 31465, 15), teleport = Position(33484, 31446, 15), effect = CONST_ME_TELEPORT },
	},
	specPos = {
		from = Position(33472, 31427, 15),
		to = Position(33496, 31450, 15),
	},
	exit = Position(33528, 31464, 14),
}

--local leverBrokul = BossLever(config)
--leverBrokul:aid(34000)
--leverBrokul:register()
local lever = BossLever(config)
lever:position(Position(33522, 31464, 15))
lever:register()
