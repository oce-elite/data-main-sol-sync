local function teleportToTemple(creature)
	if not creature:isPlayer() then
		return true
	end

	creature:teleportTo(creature:getTown():getTemplePosition())
	creature:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
end

local trainerExit = MoveEvent()
function trainerExit.onStepIn(creature, item, position, fromPosition)
	teleportToTemple(creature)
	return true
end

local positions = {
	{x = 32369, y = 32241, z = 7},
}
for index, position in pairs(positions) do
	trainerExit:position(position)
end

trainerExit:aid(40015)
trainerExit:aid(4255)
trainerExit:register()
