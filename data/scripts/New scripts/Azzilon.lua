local config = {
	{ position = {x = 33281, y = 31845, z = 8}, destination = {x = 33861, y = 32413, z = 6} },
	{ position = {x = 33862, y = 32413, z = 6}, destination = {x = 33281, y = 31844, z = 8} },
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
