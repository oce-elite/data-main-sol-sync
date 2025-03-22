local config = {
	{ position = {x = 32362, y = 32222, z = 7}, destination = {x = 32357, y = 32222, z = 6} },
	{ position = {x = 32362, y = 32223, z = 7}, destination = {x = 32357, y = 32222, z = 6} },
}

local moveEvent = MoveEvent()
function moveEvent.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return false
	end

	for value in pairs(config) do
		if Position(config[value].position) == player:getPosition() then
			player:teleportTo(Position(config[value].destination))
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			return true
		end
	end
end

moveEvent:type("stepin")
for value in pairs(config) do
	moveEvent:position(config[value].position)
end
moveEvent:register()
