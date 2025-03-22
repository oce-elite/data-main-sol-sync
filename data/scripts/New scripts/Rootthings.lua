local config = {
	{ position = {x = 33829, y = 32025, z = 7}, destination = {x = 33825, y = 32001, z = 8} },
	{ position = {x = 33825, y = 32000, z = 8}, destination = {x = 33829, y = 32024, z = 7} },
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
